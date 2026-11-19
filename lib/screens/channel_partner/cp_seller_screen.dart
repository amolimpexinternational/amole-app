import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'cp_seller_kyc_screen.dart';

class CpSellerScreen extends StatefulWidget {
  const CpSellerScreen({super.key});
  @override
  State<CpSellerScreen> createState() => _CpSellerScreenState();
}

class _CpSellerScreenState extends State<CpSellerScreen> {
  int _selectedTab = 0;

  final List<Map<String, dynamic>> _sellers = [
    {
      'shopName': 'पाटील किराणा स्टोअर',
      'owner': 'संदीप पाटील',
      'phone': '9876501234',
      'franchise': 'हडपसर फ्रँचाइजी',
      'status': 'Verified',
      'expiry': '31 Mar 2027',
      'active': true,
    },
    {
      'shopName': 'श्री साई मेडिकल',
      'owner': 'अनिता जाधव',
      'phone': '9765401235',
      'franchise': 'कोथरूड फ्रँचाइजी',
      'status': 'Verified',
      'expiry': '15 Jan 2027',
      'active': true,
    },
    {
      'shopName': 'न्यू फॅशन पॉइंट',
      'owner': 'रोहित शिंदे',
      'phone': '9654301236',
      'franchise': 'वडगाव फ्रँचाइजी',
      'status': 'KYC Pending',
      'expiry': '—',
      'active': true,
    },
  ];

  List<Map<String, dynamic>> get _filtered {
    switch (_selectedTab) {
      case 0:
        return _sellers;
      case 1:
        return _sellers.where((s) => s['active'] == true).toList();
      case 2:
        return _sellers.where((s) => s['active'] == false).toList();
      case 3:
        return _sellers.where((s) => s['status'] == 'KYC Pending').toList();
      default:
        return _sellers;
    }
  }

  void _toggleSeller(int originalIndex, bool value) {
    setState(() {
      _sellers[originalIndex]['active'] = value;
      if (!value) {
        _sellers[originalIndex]['status'] = 'Inactive';
      } else if (_sellers[originalIndex]['status'] == 'Inactive') {
        _sellers[originalIndex]['status'] = 'Verified';
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          value
              ? '${_sellers[originalIndex]["shopName"]} — Profile ON ✅'
              : '${_sellers[originalIndex]["shopName"]} — Profile OFF',
        ),
        backgroundColor: value ? Colors.green : Colors.orange,
        duration: const Duration(seconds: 2),
      ),
    );
  }

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
                          'expiry': '—',
                          'active': true,
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
    final items = _filtered;

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
              label: const Text('Add', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(46),
          child: Container(
            color: AppColors.primaryBlue,
            child: Row(
              children: [
                _buildTab(0, 'सर्व', _sellers.length),
                _buildTab(1, 'Active', _sellers.where((s) => s['active'] == true).length),
                _buildTab(2, 'Inactive', _sellers.where((s) => s['active'] == false).length),
                _buildTab(3, 'KYC Pending', _sellers.where((s) => s['status'] == 'KYC Pending').length),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: AppColors.white,
            child: Row(
              children: [
                _buildStat('एकूण', '${_sellers.length}', AppColors.primaryBlue),
                _buildStat('Active', '${_sellers.where((s) => s['active'] == true).length}', AppColors.successGreen),
                _buildStat('Inactive', '${_sellers.where((s) => s['active'] == false).length}', AppColors.textLight),
                _buildStat('KYC Pending', '${_sellers.where((s) => s['status'] == 'KYC Pending').length}', AppColors.primaryOrange),
              ],
            ),
          ),
          Expanded(
            child: items.isEmpty
                ? const Center(
                    child: Text(
                      'कोणताही Seller नाही',
                      style: TextStyle(color: AppColors.textLight),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: items.length,
                    itemBuilder: (ctx, i) {
                      final s = items[i];
                      final originalIndex = _sellers.indexOf(s);
                      return _buildSellerCard(s, originalIndex);
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

  Widget _buildTab(int index, String label, int count) {
    final selected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 2),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: selected ? AppColors.cyan : Colors.transparent, width: 3),
            ),
          ),
          child: Text(
            '$label ($count)',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: selected ? Colors.white : Colors.white60,
              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSellerCard(Map<String, dynamic> s, int originalIndex) {
    final isActive = s['active'] as bool;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isActive ? Colors.green.shade200 : Colors.grey.shade300,
        ),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Column(
        children: [
          InkWell(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CpSellerKycScreen(seller: s)),
              );
              if (result == true) setState(() {});
            },
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: isActive ? AppColors.primaryBlue.withValues(alpha: 0.1) : Colors.grey.shade200,
                      child: Icon(Icons.storefront_outlined, color: isActive ? AppColors.primaryBlue : Colors.grey),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Expanded(
                              child: Text(s['shopName'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.textDark)),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(color: _statusColor(s['status']).withValues(alpha: 0.12), borderRadius: BorderRadius.circular(20)),
                              child: Text(s['status'], style: TextStyle(color: _statusColor(s['status']), fontSize: 11, fontWeight: FontWeight.w600)),
                            ),
                          ]),
                          const SizedBox(height: 2),
                          Text(s['franchise'], style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.event_outlined, size: 12, color: Colors.orange),
                              const SizedBox(width: 4),
                              Text(
                                'Expiry: ${s['expiry']}',
                                style: const TextStyle(fontSize: 11, color: Colors.orange, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      ),
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
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.power_settings_new, size: 14, color: isActive ? Colors.green : Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      isActive ? 'Profile ON' : 'Profile OFF',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: isActive ? Colors.green.shade700 : Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
                Switch(
                  value: isActive,
                  onChanged: (v) => _toggleSeller(originalIndex, v),
                  activeThumbColor: Colors.green.shade600,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value, Color color) {
    return Expanded(
      child: Column(children: [
        Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
      ]),
    );
  }
}