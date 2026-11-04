import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class JobPortalScreen extends StatefulWidget {
  const JobPortalScreen({super.key});

  @override
  State<JobPortalScreen> createState() => _JobPortalScreenState();
}

class _JobPortalScreenState extends State<JobPortalScreen> {
  // डेमो जॉब लिस्ट (नाव, कंपनी, पगार, स्किल)
  final List<Map<String, dynamic>> _jobs = [
    {
      'title': 'Mechanical Engineer',
      'company': 'Tata Motors',
      'salary': '₹35,000 - ₹45,000',
      'location': 'Pune',
      'skills': 'BE Mechanical, AutoCAD, 2+ years exp',
      'posted': '2 दिवसांपूर्वी'
    },
    {
      'title': 'Civil Supervisor',
      'company': 'L&T Construction',
      'salary': '₹25,000 - ₹30,000',
      'location': 'Mumbai',
      'skills': 'Diploma Civil, Site Management',
      'posted': '5 दिवसांपूर्वी'
    },
    {
      'title': 'Operations Head',
      'company': 'Amazon',
      'salary': '₹60,000 - ₹80,000',
      'location': 'Pune',
      'skills': 'MBA, Supply Chain, 5+ years',
      'posted': 'आज'
    },
  ];

  void _showFeeDialog(String title, int amount) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text('यासाठी ₹$amount फी लागेल. तुमच्या Expenses Wallet मधून पैसे कापले जातील.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('रद्द करा')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('₹$amount फी कापली गेली! ✅'), backgroundColor: Colors.green),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue),
            child: const Text('₹$amount भरा'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text('💼 नोकरी (Jobs)'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // === २ मुख्य बटन (CV अपलोड आणि जॉब पोस्ट) ===
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _showFeeDialog('CV / Resume अपलोड करा', 300),
                  icon: const Icon(Icons.upload_file, size: 18),
                  label: const Text('CV अपलोड करा (₹300)'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _showFeeDialog('नवीन जॉब पोस्ट करा', 30),
                  icon: const Icon(Icons.post_add, size: 18),
                  label: const Text('जॉब पोस्ट करा (₹30)'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text('नवीन नोकऱ्या', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark)),
          const SizedBox(height: 10),

          // === जॉब यादी ===
          ..._jobs.map((job) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6)],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(job['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textDark)),
                        Text(job['posted'], style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(job['company'], style: const TextStyle(fontSize: 14, color: AppColors.primaryBlue, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Text(job['skills'], style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          const Icon(Icons.location_on, size: 14, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(job['location'], style: const TextStyle(fontSize: 12)),
                        ]),
                        Text(job['salary'], style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('अर्ज करण्यासाठी तुमचा CV पाठवला जाईल.')));
                        },
                        child: const Text('Apply करा'),
                      ),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}