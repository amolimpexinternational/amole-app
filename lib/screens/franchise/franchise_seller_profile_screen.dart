import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../admin/admin_view_dashboard_screen.dart';
import '../admin/admin_entity_transactions_screen.dart';

class FranchiseSellerProfileScreen extends StatefulWidget {
  final Map<String, String> seller;
  const FranchiseSellerProfileScreen({super.key, required this.seller});

  @override
  State<FranchiseSellerProfileScreen> createState() => _FranchiseSellerProfileScreenState();
}

class _FranchiseSellerProfileScreenState extends State<FranchiseSellerProfileScreen> {
  late String _name;
  late String _mobile;
  late String _pincode;
  late String _address;
  late String _joined;

  @override
  void initState() {
    super.initState();
    _name = widget.seller['name'] ?? '-';
    _mobile = widget.seller['mobile'] ?? '-';
    _pincode = widget.seller['pincode'] ?? '-';
    _address = widget.seller['address'] ?? 'गल्ली नं. ४, मुख्य रस्ता, हडपसर, पुणे, महाराष्ट्र';
    _joined = widget.seller['joined'] ?? '-';
  }

  void _editSellerInfo() {
    final nameCtrl = TextEditingController(text: _name);
    final mobileCtrl = TextEditingController(text: _mobile);
    final pincodeCtrl = TextEditingController(text: _pincode);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: const Text('सेलर माहिती Edit करा'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'दुकानाचे नाव')),
            const SizedBox(height: 10),
            TextField(controller: mobileCtrl, keyboardType: TextInputType.phone, maxLength: 10, decoration: const InputDecoration(labelText: 'मोबाईल नंबर')),
            const SizedBox(height: 10),
            TextField(controller: pincodeCtrl, keyboardType: TextInputType.number, maxLength: 6, decoration: const InputDecoration(labelText: 'पिनकोड')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('रद्द करा')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _name = nameCtrl.text;
                _mobile = mobileCtrl.text;
                _pincode = pincodeCtrl.text;
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('✅ सेलर माहिती अद्ययावत झाली')),
              );
            },
            child: const Text('जतन करा'),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: AppColors.primaryBlue),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
                const SizedBox(height: 2),
                Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textDark)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        title: Text(_name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: const Icon(Icons.edit_outlined, color: Colors.white), tooltip: 'Edit', onPressed: _editSellerInfo),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 40,
                backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
                child: const Icon(Icons.storefront_outlined, size: 40, color: AppColors.primaryBlue),
              ),
            ),
            const SizedBox(height: 16),
            Row(children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AdminViewDashboardScreen(
                    name: _name,
                    roleLabel: 'Seller',
                    headerSubtitle: 'पिनकोड: $_pincode',
                    revenueLabel: 'या महिन्यातील महसूल',
                    revenueValue: '₹18,450',
                    viewerLabel: 'Franchise',
                    kpis: [
                      DashboardKpi(title: 'ऑर्डर्स', value: '37', subtitle: '3 प्रतीक्षेत', icon: Icons.shopping_bag_outlined, color: Colors.orange),
                      DashboardKpi(title: 'ग्राहक', value: '124', subtitle: 'या महिन्यात', icon: Icons.people_outlined, color: Colors.purple),
                    ],
                  ))),
                  icon: const Icon(Icons.dashboard_outlined, size: 18),
                  label: const Text('डॅशबोर्ड बघा', style: TextStyle(fontSize: 12)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AdminEntityTransactionsScreen(entityName: _name, roleLabel: 'Seller'))),
                  icon: const Icon(Icons.receipt_long_outlined, size: 18),
                  label: const Text('व्यवहार इतिहास', style: TextStyle(fontSize: 12)),
                ),
              ),
            ]),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6, offset: const Offset(0, 2))]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _infoRow(Icons.storefront_outlined, "दुकानाचे नाव", _name),
                  _infoRow(Icons.phone_outlined, "मोबाईल नंबर", _mobile),
                  _infoRow(Icons.location_on_outlined, "पिनकोड", _pincode),
                  _infoRow(Icons.home_outlined, "पूर्ण पत्ता", _address),
                  _infoRow(Icons.calendar_today_outlined, "सामील झाल्याची तारीख", _joined),
                  _infoRow(Icons.verified_outlined, "स्टेटस", "✅ Verified"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
