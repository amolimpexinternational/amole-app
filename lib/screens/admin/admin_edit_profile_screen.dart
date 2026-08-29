import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'admin_entity_transactions_screen.dart';

class ProfileField {
  final String label;
  final IconData icon;
  String value;
  ProfileField({required this.label, required this.icon, required this.value});
}

// Admin जेव्हा CP/Franchise/Seller/Buyer चा खरा Home Dashboard उघडतो, तेव्हा
// त्या मूळ स्क्रीनमध्ये कुठलाही बदल न करता वर एक तरंगणारं Back बटण दाखवतो —
// कारण त्या रोलच्या स्वतःच्या home screen ला मुळात Back बटणाची गरज नसते.
class _AdminDashboardWrapper extends StatelessWidget {
  final Widget child;
  final String roleLabel;
  const _AdminDashboardWrapper({required this.child, required this.roleLabel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          child,
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 8, top: 8),
              child: Material(
                color: Colors.black.withValues(alpha: 0.35),
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () => Navigator.pop(context),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back, color: Colors.white, size: 22),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AdminEditProfileScreen extends StatefulWidget {
  final String name;
  final String roleLabel;
  final String idCode;
  final IconData avatarIcon;
  final Color avatarColor;
  final List<MapEntry<String, String>> stats;
  final List<ProfileField> fields;
  final Widget? dashboardScreen;

  const AdminEditProfileScreen({
    super.key,
    required this.name,
    required this.roleLabel,
    required this.idCode,
    required this.avatarIcon,
    required this.avatarColor,
    this.stats = const [],
    required this.fields,
    this.dashboardScreen,
  });

  @override
  State<AdminEditProfileScreen> createState() => _AdminEditProfileScreenState();
}

class _AdminEditProfileScreenState extends State<AdminEditProfileScreen> {
  late TextEditingController _nameController;
  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _controllers = widget.fields.map((f) => TextEditingController(text: f.value)).toList();
  }

  @override
  void dispose() {
    _nameController.dispose();
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _save() {
    for (int i = 0; i < widget.fields.length; i++) {
      widget.fields[i].value = _controllers[i].text;
    }
    // TODO: Firestore मध्ये update करा — Admin कडे 100% edit अधिकार आहे
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('बदल यशस्वीरित्या Save झाले'), backgroundColor: Colors.green),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        title: Text('${widget.roleLabel} — Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24),
              color: AppColors.primaryBlue,
              child: Column(
                children: [
                  CircleAvatar(radius: 38, backgroundColor: Colors.white, child: Icon(widget.avatarIcon, color: widget.avatarColor, size: 40)),
                  const SizedBox(height: 10),
                  Text(widget.idCode, style: const TextStyle(color: Colors.white70, fontSize: 12)),
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
                    child: const Row(children: [
                      Icon(Icons.verified_user_outlined, color: Colors.green, size: 18),
                      SizedBox(width: 8),
                      Expanded(child: Text('Admin म्हणून तुम्हाला ही सर्व माहिती पूर्णपणे Edit करण्याचा अधिकार आहे.', style: TextStyle(fontSize: 12, color: AppColors.textDark))),
                    ]),
                  ),
                  const SizedBox(height: 14),
                  Row(children: [
                    if (widget.dashboardScreen != null)
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => Navigator.push(context, MaterialPageRoute(
                            builder: (_) => _AdminDashboardWrapper(roleLabel: widget.roleLabel, child: widget.dashboardScreen!),
                          )),
                          icon: const Icon(Icons.dashboard_outlined, size: 18),
                          label: const Text('डॅशबोर्ड बघा', style: TextStyle(fontSize: 12)),
                        ),
                      ),
                    if (widget.dashboardScreen != null) const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AdminEntityTransactionsScreen(entityName: widget.name, roleLabel: widget.roleLabel))),
                        icon: const Icon(Icons.receipt_long_outlined, size: 18),
                        label: const Text('व्यवहार इतिहास', style: TextStyle(fontSize: 12)),
                      ),
                    ),
                  ]),
                  const SizedBox(height: 16),
                  if (widget.stats.isNotEmpty)
                    Row(
                      children: widget.stats.map((s) => Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.lightGrey)),
                          child: Column(children: [
                            Text(s.value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.primaryBlue)),
                            Text(s.key, style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
                          ]),
                        ),
                      )).toList(),
                    ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'नाव', filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                  ),
                  const SizedBox(height: 14),
                  ...List.generate(widget.fields.length, (i) => Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: TextField(
                      controller: _controllers[i],
                      decoration: InputDecoration(
                        labelText: widget.fields[i].label,
                        prefixIcon: Icon(widget.fields[i].icon, size: 20),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  )),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _save,
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                      child: const Text('बदल Save करा', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
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
