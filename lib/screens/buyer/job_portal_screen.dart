import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class JobPortalScreen extends StatefulWidget {
  const JobPortalScreen({super.key});

  @override
  State<JobPortalScreen> createState() => _JobPortalScreenState();
}

class _JobPortalScreenState extends State<JobPortalScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // डेमो जॉब लिस्ट
  final List<Map<String, dynamic>> _jobs = [
    {
      'title': 'Mechanical Engineer',
      'company': 'Tata Motors',
      'salary': '₹35,000 - ₹45,000',
      'location': 'Pune',
      'skills': 'BE Mechanical, AutoCAD, 2+ years exp',
      'posted': '2 दिवसांपूर्वी',
      'isNew': true,
    },
    {
      'title': 'Civil Supervisor',
      'company': 'L&T Construction',
      'salary': '₹25,000 - ₹30,000',
      'location': 'Mumbai',
      'skills': 'Diploma Civil, Site Management',
      'posted': '5 दिवसांपूर्वी',
      'isNew': false,
    },
    {
      'title': 'Operations Head',
      'company': 'Amazon',
      'salary': '₹60,000 - ₹80,000',
      'location': 'Pune',
      'skills': 'MBA, Supply Chain, 5+ years',
      'posted': 'आज',
      'isNew': true,
    },
    {
      'title': 'Electrician',
      'company': 'Reliance',
      'salary': '₹18,000 - ₹22,000',
      'location': 'Nagpur',
      'skills': 'ITI Electrician, 1+ years',
      'posted': '१ आठवड्यापूर्वी',
      'isNew': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showFeeDialog(String title, int amount, String description) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            const Icon(Icons.currency_rupee, color: Colors.green),
            const SizedBox(width: 8),
            Text(title),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(description, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('फी:', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('₹$amount', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 18)),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Text('टीप: फी तुमच्या Expenses Wallet मधून कापली जाईल.', style: TextStyle(fontSize: 11, color: AppColors.textLight)),
          ],
        ),
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
            child: Text('₹$amount भरा आणि पुढे जा'),
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
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'नोकऱ्या शोधा'),
            Tab(text: 'माझे प्रोफाइल (CV)'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildJobSearchTab(),
          _buildCandidateProfileTab(),
        ],
      ),
    );
  }

  // === टॅब १: जॉब शोध ===
  Widget _buildJobSearchTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // === जॉब पोस्ट करण्याचं बटन (Employer साठी) ===
        Container(
          padding: const EdgeInsets.all(14),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.teal.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.teal.shade200),
          ),
          child: Row(
            children: [
              const Icon(Icons.post_add, color: Colors.teal, size: 28),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('तुम्हाला कर्मचारी हवा आहेत?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    Text('₹30 फी - ३० दिवसांसाठी जॉब पोस्ट करा', style: TextStyle(fontSize: 11, color: AppColors.textLight)),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () => _showFeeDialog('नवीन जॉब पोस्ट करा', 30, 'तुमच्या कंपनीची जॉब पोस्ट ३० दिवसांसाठी लाईव्ह राहील.'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, minimumSize: const Size(0, 36)),
                child: const Text('Post', style: TextStyle(color: Colors.white, fontSize: 12)),
              )
            ],
          ),
        ),

        const Text('नवीन नोकऱ्या', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark)),
        const SizedBox(height: 10),

        // === जॉब यादी ===
        ..._jobs.map((job) => Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: job['isNew'] ? AppColors.primaryBlue.withValues(alpha: 0.3) : Colors.grey.shade200),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text(job['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textDark))),
                      if (job['isNew'])
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(10)),
                          child: const Text('नवीन', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(job['company'], style: const TextStyle(fontSize: 14, color: AppColors.primaryBlue, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.work_outline, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Expanded(child: Text(job['skills'], style: const TextStyle(fontSize: 12, color: AppColors.textLight))),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        const Icon(Icons.location_on, size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(job['location'], style: const TextStyle(fontSize: 12)),
                      ]),
                      Text(job['salary'], style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 14)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('अर्ज करण्यासाठी तुमचा CV आवश्यक आहे. कृपया "माझे प्रोफाइल" टॅबमध्ये CV अपलोड करा.')),
                            );
                          },
                          child: const Text('Apply करा'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(job['posted'], style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
                    ],
                  )
                ],
              ),
            )),
      ],
    );
  }

  // === टॅब २: कॅंडिडेट प्रोफाइल (CV अपलोड) ===
  Widget _buildCandidateProfileTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8)],
          ),
          child: Column(
            children: [
              const Icon(Icons.upload_file, size: 60, color: Colors.indigo),
              const SizedBox(height: 16),
              const Text('तुमचा CV / Resume अपलोड करा', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text(
                'CV अपलोड केल्यावर तुमची प्रोफाइल प्लॅटफॉर्मवरील सर्व कंपन्यांना दिसेल आणि ते तुम्हाला थेट संपर्क करू शकतील.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: AppColors.textLight),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.indigo.shade200),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('CV अपलोड फी:', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('₹300', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo, fontSize: 20)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () => _showFeeDialog('CV / Resume अपलोड करा', 300, 'तुमचा CV ३० दिवसांसाठी प्लॅटफॉर्मवर ॲक्टिव्ह राहील.'),
                  icon: const Icon(Icons.cloud_upload, color: Colors.white),
                  label: const Text('₹300 भरा आणि CV अपलोड करा', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Text('तुमची प्रोफाइल कशी दिसेल?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: AppColors.primaryBlue.withValues(alpha: 0.1),
                child: const Icon(Icons.person, color: AppColors.primaryBlue, size: 30),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('तुमचे नाव', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const Text('BE Mechanical | 2 years exp', style: TextStyle(fontSize: 12, color: AppColors.textLight)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(4)),
                          child: const Text('CV Attached ✓', style: TextStyle(fontSize: 10, color: Colors.green, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}