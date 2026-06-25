import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class CpFranchiseScreen extends StatefulWidget {
  const CpFranchiseScreen({super.key});
  @override
  State<CpFranchiseScreen> createState() => _CpFranchiseScreenState();
}

class _CpFranchiseScreenState extends State<CpFranchiseScreen> {
  final List<Map<String, dynamic>> _franchises = [
    {'name': 'हडपसर फ्रँचाइजी', 'area': 'पुणे — हडपसर', 'owner': 'राजेश शर्मा', 'phone': '9876543210', 'sellers': 24, 'status': 'Active', 'revenue': '₹12,400'},
    {'name': 'कोथरूड फ्रँचाइजी', 'area': 'पुणे — कोथरूड', 'owner': 'सुनीता पाटील', 'phone': '9765432109', 'sellers': 18, 'status': 'Active', 'revenue': '₹9,800'},
    {'name': 'वडगाव फ्रँचाइजी', 'area': 'पुणे — वडगाव', 'owner': 'अमित देशमुख', 'phone': '9654321098', 'sellers': 11, 'status': 'KYC Pending', 'revenue': '₹5,200'},
    {'name': 'भोसरी फ्रँचाइजी', 'area': 'पुणे — भोसरी', 'owner': 'प्रिया जोशी', 'phone': '9543210987', 'sellers': 8, 'status': 'Active', 'revenue': '₹4,600'},
    {'name': 'खडकी फ्रँचाइजी', 'area': 'पुणे — खडकी', 'owner': 'विकास कुलकर्णी', 'phone': '9432109876', 'sellers': 5, 'status': 'Inactive', 'revenue': '₹0'},
  ];

  void _showAddFranchiseDialog() {
    final nameController = TextEditingController();
    final areaController = TextEditingController();
    final ownerController = TextEditingController();
    final phoneController = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text('नवीन Franchise जोडा', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark)),
              IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx)),
            ]),
            const SizedBox(height: 16),
            _buildField(nameController, 'Franchise नाव', Icons.business_outlined),
            const SizedBox(height: 12),
            _buildField(areaController, 'क्षेत्र / तालुका', Icons.location_on_outlined),
            const SizedBox(height: 12),
            _buildField(ownerController, 'मालकाचं नाव', Icons.person_outlined),
            const SizedBox(height: 12),
            _buildField(phoneController, 'मोबाईल नंबर', Icons.phone_outlined, isPhone: true),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (nameController.text.isNotEmpty && areaController.text.isNotEmpty) {
                    setState(() {
                      _franchises.insert(0, {
                        'name': nameController.text,
                        'area': areaController.text,
                        'owner': ownerController.text,
                        'phone': phoneController.text,
                        'sellers': 0,
                        'status': 'KYC Pending',
                        'revenue': '₹0',
                      });
                    });
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('✅ नवीन Franchise जोडली!'), backgroundColor: AppColors.successGreen),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue, padding: const EdgeInsets.symmetric(vertical: 14)),
                child: const Text('Franchise जोडा', style: TextStyle(color: AppColors.white, fontSize: 16)),
              ),
            ),
          ],
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
    if (status == 'Active') return AppColors.successGreen;
    if (status == 'KYC Pending') return AppColors.primaryOrange;
    return AppColors.textLight;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        title: const Text('Franchise Management', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: AppColors.white),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: TextButton.icon(
              onPressed: _showAddFranchiseDialog,
              icon: const Icon(Icons.add, color: AppColors.white),
              label: const Text('Add Franchise', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold)),
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
                _buildStat('एकूण', '${_franchises.length}', AppColors.primaryBlue),
                _buildStat('Active', '${_franchises.where((f) => f['status'] == 'Active').length}', AppColors.successGreen),
                _buildStat('KYC Pending', '${_franchises.where((f) => f['status'] == 'KYC Pending').length}', AppColors.primaryOrange),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _franchises.length,
              itemBuilder: (ctx, i) {
                final f = _franchises[i];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.lightGrey),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0, 2))],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        CircleAvatar(
                          radius: 22, backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
                          child: const Icon(Icons.store_outlined, color: AppColors.primaryBlue),
                        ),
                        const SizedBox(width: 12),
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(f['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.textDark)),
                          Text(f['area'], style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
                        ])),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(color: _statusColor(f['status']).withOpacity(0.12), borderRadius: BorderRadius.circular(20)),
                          child: Text(f['status'], style: TextStyle(color: _statusColor(f['status']), fontSize: 11, fontWeight: FontWeight.w600)),
                        ),
                      ]),
                      const Divider(height: 20),
                      Row(children: [
                        const Icon(Icons.person_outline, size: 14, color: AppColors.textLight),
                        const SizedBox(width: 4),
                        Text(f['owner'], style: const TextStyle(fontSize: 13, color: AppColors.textDark)),
                        const SizedBox(width: 16),
                        const Icon(Icons.phone_outlined, size: 14, color: AppColors.textLight),
                        const SizedBox(width: 4),
                        Text(f['phone'], style: const TextStyle(fontSize: 13, color: AppColors.textDark)),
                      ]),
                      const SizedBox(height: 8),
                      Row(children: [
                        _buildChip(Icons.storefront_outlined, '${f['sellers']} Sellers', AppColors.primaryBlue),
                        const SizedBox(width: 8),
                        _buildChip(Icons.currency_rupee, f['revenue'], AppColors.successGreen),
                      ]),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddFranchiseDialog,
        backgroundColor: AppColors.primaryBlue,
        icon: const Icon(Icons.add, color: AppColors.white),
        label: const Text('Add Franchise', style: TextStyle(color: AppColors.white)),
      ),
    );
  }

  Widget _buildStat(String label, String value, Color color) {
    return Expanded(child: Column(children: [
      Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color)),
      Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
    ]));
  }

  Widget _buildChip(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(8)),
      child: Row(children: [
        Icon(icon, size: 13, color: color),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w600)),
      ]),
    );
  }
}
