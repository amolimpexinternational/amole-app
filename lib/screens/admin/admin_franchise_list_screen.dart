import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class AdminFranchiseListScreen extends StatelessWidget {
  const AdminFranchiseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> franchises = [
      {'name': 'हडपसर फ्रँचाइजी', 'area': 'पुणे — हडपसर', 'cp': 'राजेश कुलकर्णी (पुणे CP)', 'sellers': '24', 'status': 'Active'},
      {'name': 'कोथरूड फ्रँचाइजी', 'area': 'पुणे — कोथरूड', 'cp': 'राजेश कुलकर्णी (पुणे CP)', 'sellers': '18', 'status': 'Active'},
      {'name': 'वडगाव फ्रँचाइजी', 'area': 'पुणे — वडगाव', 'cp': 'राजेश कुलकर्णी (पुणे CP)', 'sellers': '11', 'status': 'KYC Pending'},
    ];

    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        title: const Text('सर्व Franchise'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(children: [
              Expanded(child: Column(children: [
                Text('${franchises.length}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
                const Text('एकूण Franchise', style: TextStyle(fontSize: 12, color: AppColors.textLight)),
              ])),
              Expanded(child: Column(children: [
                Text('${franchises.where((f) => f['status'] == 'Active').length}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.successGreen)),
                const Text('Active', style: TextStyle(fontSize: 12, color: AppColors.textLight)),
              ])),
            ]),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: franchises.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (ctx, i) {
                final f = franchises[i];
                final isActive = f['status'] == 'Active';
                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: ctx,
                      builder: (dialogCtx) => AlertDialog(
                        title: Text(f['name']!),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('परिसर: ${f['area']}'),
                            const SizedBox(height: 8),
                            Text('CP: ${f['cp']}'),
                            const SizedBox(height: 8),
                            Text('Sellers: ${f['sellers']}'),
                            const SizedBox(height: 8),
                            Text('स्थिती: ${f['status']}'),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(dialogCtx),
                            child: const Text('बंद करा'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
                            child: const Icon(Icons.storefront_outlined, color: AppColors.primaryBlue),
                          ),
                          const SizedBox(width: 12),
                          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(f['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.textDark)),
                            Text(f['area']!, style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
                          ])),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: (isActive ? AppColors.successGreen : AppColors.primaryOrange).withOpacity(0.12),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(f['status']!, style: TextStyle(color: isActive ? AppColors.successGreen : AppColors.primaryOrange, fontSize: 11, fontWeight: FontWeight.w600)),
                          ),
                        ]),
                        const Divider(height: 20),
                        Row(children: [
                          const Icon(Icons.hub_outlined, size: 14, color: AppColors.textLight),
                          const SizedBox(width: 4),
                          Expanded(child: Text(f['cp']!, style: const TextStyle(fontSize: 12, color: AppColors.textDark))),
                          const Icon(Icons.store_outlined, size: 14, color: AppColors.textLight),
                          const SizedBox(width: 4),
                          Text('${f['sellers']} Sellers', style: const TextStyle(fontSize: 12, color: AppColors.textDark)),
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
    );
  }
}
