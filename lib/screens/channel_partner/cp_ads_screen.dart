import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class CpAdsScreen extends StatefulWidget {
  const CpAdsScreen({super.key});
  @override
  State<CpAdsScreen> createState() => _CpAdsScreenState();
}

class _CpAdsScreenState extends State<CpAdsScreen> {
  final List<Map<String, dynamic>> _ads = [
    {'title': 'दिवाळी सेल — संपूर्ण जिल्हा', 'target': 'सर्व Sellers', 'status': 'Active', 'reach': '3,250', 'date': '25 Jun'},
    {'title': 'नवीन Seller Registration ऑफर', 'target': 'Buyers', 'status': 'Active', 'reach': '1,800', 'date': '24 Jun'},
    {'title': 'AMOLE Premium Launch', 'target': 'सर्व Users', 'status': 'Ended', 'reach': '5,100', 'date': '20 Jun'},
  ];

  void _showBroadcastDialog() {
    final titleController = TextEditingController();
    final msgController = TextEditingController();
    String selectedTarget = 'सर्व Users';
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
                const Text('Broadcast Ad पाठवा', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx)),
              ]),
              const SizedBox(height: 16),
              TextField(
                controller: titleController,
                decoration: InputDecoration(hintText: 'Ad Title', prefixIcon: const Icon(Icons.title, color: AppColors.primaryBlue), border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: msgController,
                maxLines: 3,
                decoration: InputDecoration(hintText: 'संदेश लिहा...', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(height: 12),
              const Text('कोणाला पाठवायचं?', style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.textDark)),
              const SizedBox(height: 8),
              Wrap(spacing: 8, children: ['सर्व Users', 'फक्त Sellers', 'फक्त Buyers', 'Franchise'].map((t) => ChoiceChip(
                label: Text(t),
                selected: selectedTarget == t,
                selectedColor: AppColors.primaryBlue,
                labelStyle: TextStyle(color: selectedTarget == t ? AppColors.white : AppColors.textDark),
                onSelected: (_) => setModalState(() => selectedTarget = t),
              )).toList()),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (titleController.text.isNotEmpty) {
                      setState(() => _ads.insert(0, {
                        'title': titleController.text,
                        'target': selectedTarget,
                        'status': 'Active',
                        'reach': '0',
                        'date': 'आज',
                      }));
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('✅ Broadcast Ad पाठवला!'), backgroundColor: AppColors.successGreen),
                      );
                    }
                  },
                  icon: const Icon(Icons.campaign_outlined, color: AppColors.white),
                  label: const Text('Broadcast करा', style: TextStyle(color: AppColors.white, fontSize: 16)),
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue, padding: const EdgeInsets.symmetric(vertical: 14)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        title: const Text('Broadcast Ads', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: AppColors.white),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _ads.length,
        itemBuilder: (ctx, i) {
          final ad = _ads[i];
          final isActive = ad['status'] == 'Active';
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: isActive ? AppColors.primaryBlue.withOpacity(0.3) : AppColors.lightGrey),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: AppColors.primaryBlue.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                  child: const Icon(Icons.campaign_outlined, color: AppColors.primaryBlue, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(ad['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textDark)),
                  Text('Target: ${ad['target']}', style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
                ])),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: (isActive ? AppColors.successGreen : AppColors.textLight).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(ad['status'], style: TextStyle(color: isActive ? AppColors.successGreen : AppColors.textLight, fontSize: 11, fontWeight: FontWeight.w600)),
                ),
              ]),
              const SizedBox(height: 10),
              Row(children: [
                const Icon(Icons.people_outline, size: 14, color: AppColors.textLight),
                const SizedBox(width: 4),
                Text('${ad['reach']} Reach', style: const TextStyle(fontSize: 12, color: AppColors.textDark)),
                const Spacer(),
                const Icon(Icons.calendar_today_outlined, size: 14, color: AppColors.textLight),
                const SizedBox(width: 4),
                Text(ad['date'], style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
              ]),
            ]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showBroadcastDialog,
        backgroundColor: AppColors.primaryBlue,
        icon: const Icon(Icons.campaign_outlined, color: AppColors.white),
        label: const Text('Broadcast करा', style: TextStyle(color: AppColors.white)),
      ),
    );
  }
}
