import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../data/listings_data.dart';

// type: 'resale' / 'rent' / 'job'. existing दिले तर edit mode (फी नाही).
class ListingPostScreen extends StatefulWidget {
  final String type;
  final Map<String, dynamic>? existing;
  const ListingPostScreen({super.key, required this.type, this.existing});

  @override
  State<ListingPostScreen> createState() => _ListingPostScreenState();
}

class _ListingPostScreenState extends State<ListingPostScreen> {
  final Map<String, TextEditingController> _ctrls = {};
  int _media = 0;

  bool get _editing => widget.existing != null;
  List<ListingField> get _fields => ListingData.fields[widget.type]!;

  @override
  void initState() {
    super.initState();
    final old = widget.existing;
    final values = old == null ? <String, dynamic>{} : old['values'] as Map;
    for (final f in _fields) {
      if (f.media) continue;
      _ctrls[f.key] =
          TextEditingController(text: (values[f.key] ?? '').toString());
    }
    if (old != null) _media = old['media'] as int;
  }

  @override
  void dispose() {
    for (final c in _ctrls.values) {
      c.dispose();
    }
    super.dispose();
  }

  int _words(String t) {
    final s = t.trim();
    if (s.isEmpty) return 0;
    return s.split(RegExp(r'\s+')).length;
  }

  void _toast(String msg, {Color color = Colors.red}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: color),
    );
  }

  Map<String, String> _values() {
    final m = <String, String>{};
    _ctrls.forEach((k, c) => m[k] = c.text.trim());
    return m;
  }

  String _validate() {
    for (final f in _fields) {
      if (f.media) continue;
      final t = _ctrls[f.key]!.text.trim();
      if (f.required && t.isEmpty) return '"${f.label}" भरा';
      if (f.multiline && _words(t) > ListingData.maxWords) {
        return 'माहिती ${ListingData.maxWords} शब्दांपेक्षा जास्त आहे';
      }
    }
    return '';
  }

  String get _buttonLabel {
    if (_editing) return 'बदल जतन करा';
    return 'पोस्ट टाका';
  }

  Future<void> _submit() async {
    final err = _validate();
    if (err.isNotEmpty) {
      _toast(err);
      return;
    }
    if (_editing) {
      ListingStore.update(widget.existing!, _values(), _media);
      _toast('बदल जतन केले.', color: Colors.green);
      Navigator.pop(context, true);
      return;
    }
    final paid = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('पोस्ट फी'),
        content: Text(
          'ही पोस्ट सार्वजनिक करण्यासाठी ₹${ListingData.fee} फी भरा.\n\n'
          '₹${ListingData.fee} फी भरल्यानंतरच ही पोस्ट ${ListingData.days} दिवस सार्वजनिक राहील. '
          '${ListingData.days} दिवसांनी ती आपोआप डिलीट होईल.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('रद्द'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text('₹${ListingData.fee} Online पेमेंट करा'),
          ),
        ],
      ),
    );
    if (paid != true || !mounted) return;
    ListingStore.add(widget.type, _values(), _media);
    _toast('फी भरली. पोस्ट पूर्ण झाली, ${ListingData.days} दिवस सार्वजनिक राहील. (Demo पेमेंट)',
        color: Colors.green);
    Navigator.pop(context, true);
  }

  String get _title {
    final base = widget.type == 'job'
        ? 'Job Alert post'
        : (widget.type == 'rent' ? 'Rent ने द्या' : 'Resale करा');
    return _editing ? '$base (बदल)' : base;
  }

  Widget _mediaRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OutlinedButton.icon(
          onPressed: () => setState(() {
            if (_media < 5) _media++;
          }),
          icon: const Icon(Icons.photo_camera_outlined),
          label: Text('फोटो / व्हिडिओ जोडा ($_media/5)'),
        ),
        const Text('Demo: खरे फोटो आणि व्हिडिओ निवडणे पुढे येईल.',
            style: TextStyle(fontSize: 11, color: AppColors.textLight)),
        if (_media > 0)
          TextButton(
            onPressed: () => setState(() => _media = 0),
            child: const Text('मीडिया काढा'),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(_title,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ..._fields.map((f) {
            if (f.media) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: _mediaRow(),
              );
            }
            final ctrl = _ctrls[f.key]!;
            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: ctrl,
                    maxLines: f.multiline ? 6 : 1,
                    keyboardType:
                        f.number ? TextInputType.number : TextInputType.text,
                    onChanged: f.multiline ? (_) => setState(() {}) : null,
                    decoration: InputDecoration(
                      labelText: f.required ? f.label : '${f.label} (ऐच्छिक)',
                      alignLabelWithHint: f.multiline,
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  if (f.multiline)
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '${_words(ctrl.text)} / ${ListingData.maxWords} शब्द',
                        style: TextStyle(
                          fontSize: 11,
                          color: _words(ctrl.text) > ListingData.maxWords
                              ? Colors.red
                              : AppColors.textLight,
                        ),
                      ),
                    ),
                ],
              ),
            );
          }),
          if (!_editing)
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'पोस्ट टाकण्यासाठी ₹${ListingData.fee} फी आहे. फी भरल्यानंतरच पोस्ट '
                '${ListingData.days} दिवस सार्वजनिक राहील.',
                style: const TextStyle(
                    fontSize: 12, color: AppColors.textDark),
              ),
            ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(_buttonLabel,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}