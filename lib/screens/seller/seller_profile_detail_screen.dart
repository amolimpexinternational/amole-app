import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'registration/seller_registration_screen.dart';
import 'seller_support_screen.dart';

class SellerProfileDetailScreen extends StatelessWidget {
  const SellerProfileDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        title: const Text('Business Profile'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          Center(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) => SafeArea(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: const Icon(Icons.photo_library),
                              title: const Text("Upload Logo"),
                              onTap: () => Navigator.pop(context),
                            ),
                            ListTile(
                              leading: const Icon(Icons.camera_alt),
                              title: const Text("Take Photo"),
                              onTap: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      const CircleAvatar(
                        radius: 52,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.store,
                          size: 52,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            color: AppColors.primaryBlue,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.edit,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                const Text(
                  "AMOLE Farmer Store",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const Text(
                  "Business ID : AMOLE000001",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Card(
            child: Column(
              children: const [

                ListTile(
                  leading: Icon(Icons.business),
                  title: Text("Business Name"),
                  subtitle: Text("AMOLE Farmer Store"),
                ),

                Divider(height: 1),

                ListTile(
                  leading: Icon(Icons.category_outlined),
                  title: Text("Business Category"),
                  subtitle: Text("Grocery / Agriculture"),
                ),

                Divider(height: 1),

                ListTile(
                  leading: Icon(Icons.phone),
                  title: Text("Mobile"),
                  subtitle: Text("+91 9876543210"),
                ),

                Divider(height: 1),

                ListTile(
                  leading: Icon(Icons.email_outlined),
                  title: Text("Email"),
                  subtitle: Text("business@email.com"),
                ),

                Divider(height: 1),

                ListTile(
                  leading: Icon(Icons.location_on_outlined),
                  title: Text("Business Address"),
                  subtitle: Text("Pune, Maharashtra"),
                ),

                Divider(height: 1),

                ListTile(
                  leading: Icon(Icons.verified_user_outlined),
                  title: Text("KYC Status"),
                  subtitle: Text("Verified"),
                ),

                Divider(height: 1),

                ListTile(
                  leading: Icon(Icons.workspace_premium_outlined),
                  title: Text("Subscription"),
                  subtitle: Text("Free Plan"),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
            ),
            icon: const Icon(Icons.edit),
            label: const Text("Edit Business Profile"),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const SellerRegistrationScreen()));
            },
          ),

          const SizedBox(height: 12),

          Card(
            child: ListTile(
              leading: const Icon(
                Icons.help_outline,
                color: AppColors.primaryBlue,
              ),
              title: const Text("Help & Support"),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SellerSupportScreen(),
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
