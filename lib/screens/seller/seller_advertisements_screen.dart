import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class SellerAdvertisementsScreen extends StatefulWidget {
  const SellerAdvertisementsScreen({super.key});
  @override
  State<SellerAdvertisementsScreen> createState() => _SellerAdvertisementsScreenState();
}

class _SellerAdvertisementsScreenState extends State<SellerAdvertisementsScreen> {
  final List<Map<String, dynamic>> _ads = [
    {'title': 'दिवाळी ऑफर — 20% सूट', 'views': '1,240', 'clicks': '86', 'status': 'Active', 'budget': '₹500', 'days': '5 दिवस उरले'},
    {'title': 'नवीन Stock आला!', 'views': '890', 'clicks': '52', 'status': 'Active', 'budget': '₹300', 'days': '2 दिवस उरले'},
    {'title': 'Weekend Special', 'views': '2,100', 'clicks': '140', 'status': 'Ended', 'budget': '₹400', 'days': 'संपलं'},
  ];

  void _showCreateAdDialog() {
    final titleController = TextEditingController();
    final budgetController = TextEditingController();
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
              const Text('नवीन जाहिरात तयार करा', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark)),
              IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx)),
            ]),
            const SizedBox(height: 16),
            TextField(
              controller: titleController,
              decoration: InputDecoration(hintText: 'जाहिरातीचं Title', prefixIcon: const Icon(Icons.campaign_outlined, color: AppColors.primaryBlue), border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: budgetController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Budget (₹)', prefixIcon: const Icon(Icons.currency_rupee, color: AppColors.primaryBlue), border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: AppColors.primaryOrange.withOpacity(0.08), borderRadius: BorderRadius.circular(10)),
              child: Row(children: const [
                Icon(Icons.info_outline, color: AppColors.primaryOrange, size: 18),
                SizedBox(width: 8),
                Expanded(child: Text('जाहिरात Franchise Approval नंतर Active होईल', style: TextStyle(fontSize: 12, color: AppColors.textDark))),
              ]),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (titleController.text.isNotEmpty && budgetController.text.isNotEmpty) {
                    setState(() => _ads.insert(0, {
                      'title': titleController.text,
                      'views': '0',
                      'clicks': '0',
                      'status': 'Pending Approval',
                      'budget': '₹${budgetController.text}',
                      'days': 'Franchise कडे पाठवली',
                    }));
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('✅ जाहिरात Franchise कडे पाठवली!'), backgroundColor: AppColors.successGreen),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue, padding: const EdgeInsets.symmetric(vertical: 14)),
                child: const Text('Approval साठी पाठवा', style: TextStyle(color: AppColors.white, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _statusColor(String status) {
    if (status == 'Active') return AppColors.successGreen;
    if (status == 'Pending Approval') return AppColors.primaryOrange;
    return AppColors.textLight;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        title: const Text('माझ्या जाहिराती', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: AppColors.white),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: AppColors.white,
            child: Row(children: [
              _buildStat('एकूण', '${_ads.length}', AppColors.primaryBlue),
              _buildStat('Active', '${_ads.where((a) => a['status'] == 'Active').length}', AppColors.successGreen),
              _buildStat('एकूण Views', '4,230', AppColors.primaryOrange),
            ]),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _ads.length,
              itemBuilder: (ctx, i) {
                final ad = _ads[i];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.lightGrey),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Expanded(child: Text(ad['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textDark))),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(color: _statusColor(ad['status']).withOpacity(0.12), borderRadius: BorderRadius.circular(20)),
                          child: Text(ad['status'], style: TextStyle(color: _statusColor(ad['status']), fontSize: 10, fontWeight: FontWeight.w600)),
                        ),
                      ]),
                      const Divider(height: 18),
                      Row(children: [
                        _buildChip(Icons.visibility_outlined, '${ad['views']} Views', AppColors.primaryBlue),
                        const SizedBox(width: 8),
                        _buildChip(Icons.touch_app_outlined, '${ad['clicks']} Clicks', AppColors.successGreen),
                      ]),
                      const SizedBox(height: 8),
                      Row(children: [
                        const Icon(Icons.currency_rupee, size: 13, color: AppColors.textLight),
                        Text(ad['budget'], style: const TextStyle(fontSize: 12, color: AppColors.textDark)),
                        const Spacer(),
                        Text(ad['days'], style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
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
        onPressed: _showCreateAdDialog,
        backgroundColor: AppColors.primaryBlue,
        icon: const Icon(Icons.campaign_outlined, color: AppColors.white),
        label: const Text('नवीन जाहिरात', style: TextStyle(color: AppColors.white)),
      ),
    );
  }

  Widget _buildStat(String label, String value, Color color) {
    return Expanded(child: Column(children: [
      Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
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
