import 'package:flutter/material.dart';

class FranchiseBuyerListScreen extends StatelessWidget {
  const FranchiseBuyerListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO (Stage 3 - Backend): replace with Firestore query of buyers
    // linked to this Franchise's pincode.
    final List<Map<String, String>> buyers = [
      {"name": "सचिन जाधव", "mobile": "9898989898", "pincode": "411001", "joined": "05 Jul 2026"},
      {"name": "प्रिया देशमुख", "mobile": "9797979797", "pincode": "411002", "joined": "20 Jul 2026"},
      {"name": "विकास मोरे", "mobile": "9696969696", "pincode": "411001", "joined": "03 Aug 2026"},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Total Buyers")),
      body: buyers.isEmpty
          ? const Center(child: Text("अजून कोणीही बायर लिंक नाही"))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: buyers.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final b = buyers[index];
                return Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.grey.shade200),
                  ),
                  child: ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.person_outline)),
                    title: Text(b["name"]!, style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text("📱 ${b["mobile"]}   📍 ${b["pincode"]}\nसामील: ${b["joined"]}"),
                    isThreeLine: true,
                  ),
                );
              },
            ),
    );
  }
}
