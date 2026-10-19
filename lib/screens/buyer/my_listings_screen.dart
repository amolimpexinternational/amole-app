import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../data/listings_data.dart';
import 'listing_post_screen.dart';

class MyListingsScreen extends StatefulWidget {
  final List<String> types;
  const MyListingsScreen({super.key, required this.types});

  @override
  State<MyListingsScreen> createState() => _MyListingsScreenState();
}

class _MyListingsScreenState extends State<MyListingsScreen> {
  Future<void> _delete(Map<String, dynamic> p) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('पोस्ट डिलीट करायची?'),
        content: Text(ListingStore.title(p)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('नको'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('डिलीट करा'),
          ),
        ],
      ),
    );
    if (ok != true || !mounted) return;
    setState(() => ListingStore.remove(p['id'] as String));
  }

  void _edit(Map<String, dynamic> p) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            ListingPostScreen(type: p['type'] as String, existing: p),
      ),
    ).then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final mine = ListingStore.mine(widget.types);
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('माझ्या पोस्ट',
            style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold)),
      ),
      body: mine.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'तुम्ही अजून कोणतीही पोस्ट टाकलेली नाही.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.textLight),
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: mine.length,
              itemBuilder: (context, i) {
                final p = mine[i];
                final left = ListingStore.daysLeft(p);
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.lightGrey),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(ListingStore.title(p),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: AppColors.textDark)),
                      const SizedBox(height: 2),
                      Text(
                        '${ListingData.typeName[p['type']]} · ${ListingStore.subtitle(p)}',
                        style: const TextStyle(
                            fontSize: 12, color: AppColors.textLight),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$left दिवस शिल्लक, नंतर आपोआप डिलीट होईल',
                        style: TextStyle(
                          fontSize: 12,
                          color: left <= 5 ? Colors.deepOrange : Colors.green,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => _edit(p),
                              icon: const Icon(Icons.edit_outlined, size: 18),
                              label: const Text('Edit'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => _delete(p),
                              icon: const Icon(Icons.delete_outline, size: 18),
                              label: const Text('Delete'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.red,
                                side: const BorderSide(color: Colors.red),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}