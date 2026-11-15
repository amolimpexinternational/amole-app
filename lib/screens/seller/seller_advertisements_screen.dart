import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'seller_advertisement_screen.dart';

class SellerAdvertisementsScreen extends StatefulWidget {
  const SellerAdvertisementsScreen({super.key});
  @override
  State<SellerAdvertisementsScreen> createState() => _SellerAdvertisementsScreenState();
}

class _SellerAdvertisementsScreenState extends State<SellerAdvertisementsScreen> {
  final List<Map<String, dynamic>> _myAds = [
    {
      'title': 'Diwali Offer 20% Off',
      'views': '1,240',
      'clicks': '86',
      'status': 'Active',
      'budget': 500,
      'daysLeft': 5,
    },
    {
      'title': 'New Stock!',
      'views': '890',
      'clicks': '52',
      'status': 'Active',
      'budget': 300,
      'daysLeft': 2,
    },
    {
      'title': 'Weekend Special',
      'views': '2,100',
      'clicks': '140',
      'status': 'Ended',
      'budget': 400,
      'daysLeft': 0,
    },
  ];

  // ✅ Live जाहिरातीवर टॅप → Detail dialog
  void _showAdDetail(int index) {
    final ad = _myAds[index];
    final isActive = ad['status'] == 'Active';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(ad['title'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: isActive ? Colors.green.shade50 : AppColors.lightGrey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    ad['status'],
                    style: TextStyle(
                      fontSize: 12,
                      color: isActive ? Colors.green : AppColors.textLight,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _detailRow(Icons.visibility_outlined, 'Views', '${ad['views']}', Colors.blue),
            const SizedBox(height: 8),
            _detailRow(Icons.touch_app_outlined, 'Clicks', '${ad['clicks']}', Colors.orange),
            const SizedBox(height: 8),
            _detailRow(Icons.currency_rupee, 'बजेट', '₹${ad['budget']}', Colors.green),
            const SizedBox(height: 8),
            _detailRow(
              Icons.access_time,
              'उर्वरित मुदत',
              isActive ? '${ad['daysLeft']} दिवस' : 'संपली',
              AppColors.textLight,
            ),
            const SizedBox(height: 20),

            if (isActive) ...[
              const Divider(),
              const SizedBox(height: 8),
              const Text('वाढवा', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textDark)),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pop(ctx);
                        _showIncreaseBudgetDialog(index);
                      },
                      icon: const Icon(Icons.add_circle_outline, color: AppColors.primaryBlue, size: 20),
                      label: const Text('बजेट वाढवा', style: TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.bold)),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: const BorderSide(color: AppColors.primaryBlue),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        minimumSize: const Size(0, 44),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pop(ctx);
                        _showExtendDurationDialog(index);
                      },
                      icon: const Icon(Icons.calendar_month, color: AppColors.successGreen, size: 20),
                      label: const Text('मुदत वाढवा', style: TextStyle(color: AppColors.successGreen, fontWeight: FontWeight.bold)),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: const BorderSide(color: AppColors.successGreen),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        minimumSize: const Size(0, 44),
                      ),
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _detailRow(IconData icon, String label, String value, Color color) {
    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 8),
        Text('$label: ', style: const TextStyle(fontSize: 13, color: AppColors.textLight)),
        Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark)),
      ],
    );
  }

  // ✅ बजेट वाढवा Dialog
  void _showIncreaseBudgetDialog(int index) {
    final ctrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('बजेट वाढवा'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: ctrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'उदा. 100',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.currency_rupee, size: 18),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, size: 14, color: Colors.orange),
                  SizedBox(width: 6),
                  Expanded(
                    child: Text('Demo — खरं payment नाही (Stage 3 मध्ये Cashfree)',
                        style: TextStyle(fontSize: 10, color: Colors.orange)),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('रद्द')),
          ElevatedButton(
            onPressed: () {
              final n = int.tryParse(ctrl.text.trim()) ?? 0;
              if (n < 50) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('किमान ₹50'), backgroundColor: Colors.red),
                );
                return;
              }
              setState(() {
                _myAds[index]['budget'] = (_myAds[index]['budget'] as int) + n;
              });
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('बजेट ₹$n ने वाढवलं ✅'), backgroundColor: Colors.green),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue),
            child: const Text('पैसे भरा', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // ✅ मुदत वाढवा Dialog
  void _showExtendDurationDialog(int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('मुदत वाढवा'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('₹100 भरून 7 दिवस मुदत वाढवा', style: TextStyle(fontSize: 14)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, size: 14, color: Colors.orange),
                  SizedBox(width: 6),
                  Expanded(
                    child: Text('Demo — खरं payment नाही (Stage 3 मध्ये Cashfree)',
                        style: TextStyle(fontSize: 10, color: Colors.orange)),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('रद्द')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _myAds[index]['daysLeft'] = (_myAds[index]['daysLeft'] as int) + 7;
              });
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('7 दिवस वाढवले ✅'), backgroundColor: Colors.green),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.successGreen),
            child: const Text('₹100 भरा + 7 दिवस', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildMyAdCard(Map<String, dynamic> ad, int index) {
    final isActive = ad['status'] == 'Active';
    return GestureDetector(
      onTap: () => _showAdDetail(index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: isActive ? Colors.green.shade200 : AppColors.lightGrey),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(ad['title'],
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: isActive ? Colors.green.shade50 : AppColors.lightGrey,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(ad['status'],
                      style: TextStyle(
                        fontSize: 11,
                        color: isActive ? Colors.green : AppColors.textLight,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.visibility_outlined, size: 13, color: Colors.blue),
                const SizedBox(width: 3),
                Text('${ad['views']} Views', style: const TextStyle(fontSize: 11, color: Colors.blue)),
                const SizedBox(width: 10),
                const Icon(Icons.touch_app_outlined, size: 13, color: Colors.orange),
                const SizedBox(width: 3),
                Text('${ad['clicks']} Clicks', style: const TextStyle(fontSize: 11, color: Colors.orange)),
                const SizedBox(width: 10),
                const Icon(Icons.currency_rupee, size: 13, color: Colors.green),
                const SizedBox(width: 3),
                Text('₹${ad['budget']}', style: const TextStyle(fontSize: 11, color: Colors.green)),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.access_time, size: 13, color: AppColors.textLight),
                const SizedBox(width: 4),
                Text(
                  isActive ? '${ad['daysLeft']} दिवस उर्वरित' : 'संपली',
                  style: const TextStyle(fontSize: 12, color: AppColors.textLight),
                ),
                const Spacer(),
                if (isActive)
                  const Icon(Icons.touch_app, size: 14, color: AppColors.primaryBlue),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        title: const Text('माझ्या जाहिराती'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SellerAdvertisementScreen()),
        ),
        backgroundColor: AppColors.primaryBlue,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('नवीन जाहिरात', style: TextStyle(color: Colors.white)),
      ),
      body: _myAds.isEmpty
          ? const Center(child: Text('अजून कोणतीही जाहिरात नाही', style: TextStyle(color: AppColors.textLight)))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _myAds.length,
              itemBuilder: (context, index) => _buildMyAdCard(_myAds[index], index),
            ),
    );
  }
}
