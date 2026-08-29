import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class DashboardKpi {
  final String title;
  String value;
  final String subtitle;
  final IconData icon;
  final Color color;
  DashboardKpi({required this.title, required this.value, required this.subtitle, required this.icon, required this.color});
}

class AdminViewDashboardScreen extends StatefulWidget {
  final String name;
  final String roleLabel;
  final String headerSubtitle;
  final String revenueLabel;
  final String revenueValue;
  final List<DashboardKpi> kpis;
  final String viewerLabel;

  const AdminViewDashboardScreen({
    super.key,
    required this.name,
    required this.roleLabel,
    required this.headerSubtitle,
    required this.revenueLabel,
    required this.revenueValue,
    required this.kpis,
    this.viewerLabel = 'Admin',
  });

  @override
  State<AdminViewDashboardScreen> createState() => _AdminViewDashboardScreenState();
}

class _AdminViewDashboardScreenState extends State<AdminViewDashboardScreen> {
  late List<TextEditingController> _kpiControllers;
  late TextEditingController _revenueController;

  @override
  void initState() {
    super.initState();
    _kpiControllers = widget.kpis.map((k) => TextEditingController(text: k.value)).toList();
    _revenueController = TextEditingController(text: widget.revenueValue);
  }

  @override
  void dispose() {
    for (final c in _kpiControllers) {
      c.dispose();
    }
    _revenueController.dispose();
    super.dispose();
  }

  void _save() {
    setState(() {
      for (int i = 0; i < widget.kpis.length; i++) {
        widget.kpis[i].value = _kpiControllers[i].text;
      }
    });
    // TODO: Firestore मध्ये update करा — ${widget.viewerLabel} ला या डेटावर पूर्ण अधिकार आहे
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('डॅशबोर्ड आकडे यशस्वीरित्या Update झाले'), backgroundColor: Colors.green),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 48, 20, 24),
              decoration: const BoxDecoration(gradient: LinearGradient(colors: [AppColors.primaryBlue, AppColors.royalBlue], begin: Alignment.topLeft, end: Alignment.bottomRight)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
                    Expanded(child: Text('${widget.roleLabel} Dashboard (${widget.viewerLabel} View)', style: const TextStyle(color: Colors.white70, fontSize: 12))),
                  ]),
                  Text(widget.name, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(widget.headerSubtitle, style: const TextStyle(color: Colors.white70, fontSize: 13)),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(14)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.revenueLabel, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                        const SizedBox(height: 6),
                        TextField(
                          controller: _revenueController,
                          style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                          decoration: const InputDecoration(isDense: true, border: InputBorder.none),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(10)),
                    child: Row(children: [
                      const Icon(Icons.verified_user_outlined, color: Colors.green, size: 18),
                      const SizedBox(width: 8),
                      Expanded(child: Text('${widget.viewerLabel} म्हणून तुम्हाला हे आकडे पूर्णपणे Edit करण्याचा अधिकार आहे.', style: const TextStyle(fontSize: 12, color: AppColors.textDark))),
                    ]),
                  ),
                  const SizedBox(height: 16),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 1.3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    children: List.generate(widget.kpis.length, (i) {
                      final k = widget.kpis[i];
                      return Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 8, offset: const Offset(0, 2))]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                              Expanded(child: Text(k.title, style: const TextStyle(fontSize: 12, color: AppColors.textLight))),
                              Icon(k.icon, color: k.color, size: 20),
                            ]),
                            TextField(
                              controller: _kpiControllers[i],
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: k.color),
                              decoration: const InputDecoration(isDense: true, border: InputBorder.none, contentPadding: EdgeInsets.zero),
                            ),
                            Text(k.subtitle, style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
                          ],
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _save,
                      icon: const Icon(Icons.save_outlined, color: Colors.white),
                      label: const Text('बदल Save करा', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
