#!/bin/bash

echo ""
echo "============================================================"
echo " AMOLE APP - QUICK PROJECT STATUS"
echo "============================================================"
echo "Project: $(pwd)"
echo "Time   : $(date '+%Y-%m-%d %H:%M:%S')"
echo ""

echo "============================================================"
echo "1. GIT"
echo "============================================================"
git branch --show-current
git status --short
echo ""
echo "Recent commits:"
git log --oneline -5
echo ""

echo "============================================================"
echo "2. SCREEN FILES"
echo "============================================================"
find lib/screens -type f -name '*_screen.dart' | sort
echo ""

echo "============================================================"
echo "3. DATA FILES"
echo "============================================================"
find lib/data -type f | sort
echo ""

echo "============================================================"
echo "4. MODEL FILES"
echo "============================================================"
find lib/models -type f | sort
echo ""

echo "============================================================"
echo "5. TODO / FIXME"
echo "============================================================"
grep -RInE 'TODO|FIXME' lib/screens lib/data lib/models --include='*.dart' 2>/dev/null | head -100
echo ""

echo "============================================================"
echo "6. EMPTY ACTIONS"
echo "============================================================"
grep -RInE 'onPressed:[[:space:]]*\(\)[[:space:]]*\{\}|onTap:[[:space:]]*\(\)[[:space:]]*\{\}' lib/screens --include='*.dart' 2>/dev/null | head -100
echo ""

echo "============================================================"
echo "7. DEMO / MOCK / DUMMY"
echo "============================================================"
grep -RInEi 'demo|dummy|mock|sample' lib/data lib/screens --include='*.dart' 2>/dev/null | head -100
echo ""

echo "============================================================"
echo "8. FLUTTER ANALYZE"
echo "============================================================"

if command -v flutter >/dev/null 2>&1; then
    ANALYZE_FILE="/tmp/amole_flutter_analyze.txt"

    flutter analyze > "$ANALYZE_FILE" 2>&1
    EXIT_CODE=$?

    echo "Flutter analyze exit code: $EXIT_CODE"

    if grep -q "No issues found" "$ANALYZE_FILE"; then
        echo "Result: No issues found."
    else
        SUMMARY=$(grep -E '[0-9]+ issues? found' "$ANALYZE_FILE" | tail -1)
        if [ -n "$SUMMARY" ]; then
            echo "Result: $SUMMARY"
        else
            echo "Result: Analyzer completed; see actual errors below if any."
        fi
    fi

    ERROR_COUNT=$(grep -cE '^[[:space:]]*error •' "$ANALYZE_FILE" 2>/dev/null || true)
    WARNING_COUNT=$(grep -cE '^[[:space:]]*warning •' "$ANALYZE_FILE" 2>/dev/null || true)

    echo "Errors  : $ERROR_COUNT"
    echo "Warnings: $WARNING_COUNT"

    if [ "$ERROR_COUNT" -gt 0 ]; then
        echo ""
        echo "ACTUAL ERRORS:"
        grep -E '^[[:space:]]*error •' "$ANALYZE_FILE" | head -30
    fi

    rm -f "$ANALYZE_FILE"
else
    echo "Flutter not found."
fi

echo ""

echo "============================================================"
echo "9. CURRENT CHANGES"
echo "============================================================"
git diff --stat
echo ""

echo "============================================================"
echo "10. UNTRACKED FILES"
echo "============================================================"
git ls-files --others --exclude-standard
echo ""

echo "============================================================"
echo " STATUS REPORT COMPLETE"
echo "============================================================"
