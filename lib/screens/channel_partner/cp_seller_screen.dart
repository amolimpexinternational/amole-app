import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../admin/admin_edit_profile_screen.dart';
import '../admin/admin_view_dashboard_screen.dart';

class CpSellerScreen extends StatefulWidget {
  const CpSellerScreen({super.key});
  @override
  State<CpSellerScreen> createState() => _CpSellerScreenState();
}

class _CpSellerScreenState extends State<CpSellerScreen> {
  final List<Map<String, dynamic>> _sellers = [
    {'shopName': 'पाटील किराणा स्टोअर', 'owner': 'संदीप पाटील', 'phone': '9876501234', 'franchise': 'हडपसर फ्रँचाइजी', 'status': 'Verified'},
    {'shopName': 'श्री साई मेडिकल', 'owner': 'अनिता जाधव', 'phone': '9765401235', 'franchise': 'कोथरूड फ्रँचाइजी', 'status': 'Verified'},
    {'shopName': 'न्यू फॅशन पॉइंट', 'owner': 'रोहित शिंदे', 'phone': '9654301236', 'franchise': 'वडगाव फ्रँचाइजी', 'status': 'KYC Pending'},
  ];

  void _showAddSellerDialog() {
    final shopController = TextEditingController();
    final ownerController = TextEditingController();
    final phoneController = TextEditingController();
    final pincodeController = TextEditingController();
    String selectedFranchise = 'हडपसर फ्रँचाइजी';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) => Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text('नवीन Seller जोडा', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx)),
              ]),
              const SizedBox(height: 16),
              _buildField(shopController, 'दुकानाचे नाव', Icons.storefront_outlined),
              const SizedBox(height: 12),
              _buildField(ownerController, 'मालकाचे नाव', Icons.person_outlined),
              const SizedBox(height: 12),
              _buildField(phoneController, 'मोबाईल नंबर', Icons.phone_outlined, isPhone: true),
              const SizedBox(height: 12),
              _buildField(pincodeController, 'पिनकोड', Icons.pin_drop_outlined, isPhone: true),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: selectedFranchise,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.business_outlined, color: AppColors.primaryBlue),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                items: ['हडपसर फ्रँचाइजी', 'कोथरूड फ्रँचाइजी', 'वडगाव फ्रँचाइजी', 'भोसरी फ्रँचाइजी']
                    .map((f) => DropdownMenuItem(value: f, child: Text(f)))
                    .toList(),
                onChanged: (v) => setModalState(() => selectedFranchise = v!),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(10)),
                child: const Row(children: [
                  Icon(Icons.info_outline, color: AppColors.primaryBlue, size: 18),
                  SizedBox(width: 8),
                  Expanded(child: Text('Channel Partner ने जोडलेला Seller थेट verified राहील.', style: TextStyle(fontSize: 12, color: AppColors.textDark))),
                ]),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (shopController.text.isNotEmpty && ownerController.text.isNotEmpty) {
                      setState(() {
                        _sellers.insert(0, {
                          'shopName': shopController.text,
                          'owner': ownerController.text,
                          'phone': phoneController.text,
                          'franchise': selectedFranchise,
                          'status': 'Verified',
                        });
                      });
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('✅ नवीन Seller जोडला!'), backgroundColor: AppColors.successGreen),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue, padding: const EdgeInsets.symmetric(vertical: 14)),
                  child: const Text('Seller जोडा', style: TextStyle(color: AppColors.white, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(TextEditingController c, String hint, IconData icon, {bool isPhone = false}) {
    return TextField(
      controller: c,
      keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: AppColors.primaryBlue),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
    );
  }

  Color _statusColor(String status) {
    if (status == 'Verified') return AppColors.successGreen;
    if (status == 'KYC Pending') return AppColors.primaryOrange;
    return AppColors.textLight;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        title: const Text('Seller Management', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: AppColors.white),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: TextButton.icon(
              onPressed: _showAddSellerDialog,
              icon: const Icon(Icons.add, color: AppColors.white),
              label: const Text('Add Seller', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: AppColors.white,
            child: Row(
              children: [
                Expanded(child: Column(children: [
                  Text('${_sellers.length}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
                  const Text('एकूण', style: TextStyle(fontSize: 12, color: AppColors.textLight)),
                ])),
                Expanded(child: Column(children: [
                  Text('${_sellers.where((s) => s['status'] == 'Verified').length}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.successGreen)),
                  const Text('Verified', style: TextStyle(fontSize: 12, color: AppColors.textLight)),
                ])),
                Expanded(child: Column(children: [
                  Text('${_sellers.where((s) => s['status'] == 'KYC Pending').length}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primaryOrange)),
                  const Text('KYC Pending', style: TextStyle(fontSize: 12, color: AppColors.textLight)),
                ])),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _sellers.length,
              itemBuilder: (ctx, i) {
                final s = _sellers[i];
                return GestureDetector(
                  onTap: () => Navigator.push(ctx, MaterialPageRoute(
                    builder: (_) => AdminEditProfileScreen(
                      name: s['shopName'],
                      roleLabel: 'Seller',
                      idCode: s['franchise'],
                      avatarIcon: Icons.storefront_outlined,
                      avatarColor: AppColors.primaryBlue,
                      fields: [
                        ProfileField(label: 'दुकानाचे नाव', icon: Icons.storefront_outlined, value: s['shopName']),
                        ProfileField(label: 'मालक', icon: Icons.person_outlined, value: s['owner']),
                        ProfileField(label: 'मोबाईल', icon: Icons.phone_outlined, value: s['phone']),
                        ProfileField(label: 'Franchise', icon: Icons.business_outlined, value: s['franchise']),
                        ProfileField(label: 'स्थिती', icon: Icons.verified_outlined, value: s['status']),
                      ],
                      dashboardScreen: AdminViewDashboardScreen(
                        name: s['shopName'],
                        roleLabel: 'Seller',
                        headerSubtitle: s['franchise'],
                        revenueLabel: 'या महिन्यातील महसूल',
                        revenueValue: '₹18,450',
                        viewerLabel: 'Channel Partner',
                        kpis: [
                          DashboardKpi(title: 'ऑर्डर्स', value: '37', subtitle: 'या महिन्यात', icon: Icons.shopping_bag_outlined, color: Colors.orange),
                          DashboardKpi(title: 'ग्राहक', value: '124', subtitle: 'या महिन्यात', icon: Icons.people_outlined, color: Colors.purple),
                        ],
                      ),
                    ),
                  )),
                  child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.lightGrey),
                    boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6, offset: const Offset(0, 2))],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        CircleAvatar(
                          radius: 22, backgroundColor: AppColors.primaryBlue.withValues(alpha: 0.1),
                          child: const Icon(Icons.storefront_outlined, color: AppColors.primaryBlue),
                        ),
                        const SizedBox(width: 12),
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(s['shopName'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.textDark)),
                          Text(s['franchise'], style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
                        ])),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(color: _statusColor(s['status']).withValues(alpha: 0.12), borderRadius: BorderRadius.circular(20)),
                          child: Text(s['status'], style: TextStyle(color: _statusColor(s['status']), fontSize: 11, fontWeight: FontWeight.w600)),
                        ),
                      ]),
                      const Divider(height: 20),
                      Row(children: [
                        const Icon(Icons.person_outline, size: 14, color: AppColors.textLight),
                        const SizedBox(width: 4),
                        Text(s['owner'], style: const TextStyle(fontSize: 13, color: AppColors.textDark)),
                        const SizedBox(width: 16),
                        const Icon(Icons.phone_outlined, size: 14, color: AppColors.textLight),
                        const SizedBox(width: 4),
                        Text(s['phone'], style: const TextStyle(fontSize: 13, color: AppColors.textDark)),
                      ]),
                    ],
                  ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddSellerDialog,
        backgroundColor: AppColors.primaryBlue,
        icon: const Icon(Icons.add, color: AppColors.white),
        label: const Text('Add Seller', style: TextStyle(color: AppColors.white)),
      ),
    );
  }
}
