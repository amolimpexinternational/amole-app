import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'franchise_seller_profile_screen.dart';
import 'franchise_add_seller_screen.dart';

class FranchiseSellerListScreen extends StatelessWidget {
  const FranchiseSellerListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO (Stage 3 - Backend): replace with Firestore query of sellers
    // linked to this Franchise's pincode.
    final List<Map<String, String>> sellers = [
      {"name": "राजेश किराणा स्टोअर", "mobile": "9876543210", "pincode": "411001", "joined": "12 Jul 2026"},
      {"name": "श्री मेडिकल्स", "mobile": "9823456712", "pincode": "411001", "joined": "18 Jul 2026"},
      {"name": "अनिता फॅशन हाऊस", "mobile": "9765432109", "pincode": "411002", "joined": "02 Aug 2026"},
      {"name": "पाटील हार्डवेअर", "mobile": "9911223344", "pincode": "411001", "joined": "10 Aug 2026"},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Total Sellers")),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primaryBlue,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text("नवीन सेलर जोडा", style: TextStyle(color: Colors.white)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const FranchiseAddSellerScreen()),
          );
        },
      ),
      body: sellers.isEmpty
          ? const Center(child: Text("अजून कोणीही सेलर लिंक नाही"))
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
              itemCount: sellers.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final s = sellers[index];
                return Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.grey.shade200),
                  ),
                  child: ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.storefront_outlined)),
                    title: Text(s["name"]!, style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text("📱 ${s["mobile"]}   📍 ${s["pincode"]}\nसामील: ${s["joined"]}"),
                    isThreeLine: true,
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FranchiseSellerProfileScreen(seller: s),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
