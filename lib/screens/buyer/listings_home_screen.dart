import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../data/listings_data.dart';
import 'listing_post_screen.dart';
import 'my_listings_screen.dart';

class ListingsHomeScreen extends StatefulWidget {
  final String module;
  const ListingsHomeScreen({super.key, required this.module});

  @override
  State<ListingsHomeScreen> createState() => _ListingsHomeScreenState();
}

class _ListingsHomeScreenState extends State<ListingsHomeScreen> {
  String _section = 'resale';
  String _query = '';

  bool get _isJobs => widget.module == 'jobs';
  String get _type => _isJobs ? 'job' : _section;
  List<String> get _myTypes => _isJobs ? ['job'] : ['resale', 'rent'];

  // === Jobs साठी डेमो डेटा (जॉब प्रोफाइल) ===
  final List<Map<String, dynamic>> _jobPosts = [
    {
      'id': 'JOB001',
      'title': 'Mechanical Engineer',
      'company': 'Tata Motors',
      'location': 'पुणे',
      'salary': '₹35,000 - ₹50,000',
      'experience': '2-4 वर्षे',
      'skills': 'CAD, SolidWorks, AutoCAD',
      'degree': 'B.E. Mechanical',
      'type': 'Full Time',
      'postedBy': 'HR Department',
      'phone': '+91 9876543210',
      'postedDays': '2 दिवसांपूर्वी',
      'expiresIn': '28 दिवस शिल्लक',
    },
    {
      'id': 'JOB002',
      'title': 'Civil Supervisor',
      'company': 'L&T Construction',
      'location': 'मुंबई',
      'salary': '₹25,000 - ₹40,000',
      'experience': '1-3 वर्षे',
      'skills': 'Site Management, AutoCAD',
      'degree': 'Diploma Civil',
      'type': 'Full Time',
      'postedBy': 'Project Manager',
      'phone': '+91 9876543211',
      'postedDays': '3 दिवसांपूर्वी',
      'expiresIn': '27 दिवस शिल्लक',
    },
    {
      'id': 'JOB003',
      'title': 'Operation Head',
      'company': 'Amazon India',
      'location': 'हैदराबाद',
      'salary': '₹80,000 - ₹1,20,000',
      'experience': '5-8 वर्षे',
      'skills': 'Supply Chain, Team Management',
      'degree': 'MBA Operations',
      'type': 'Full Time',
      'postedBy': 'HR Team',
      'phone': '+91 9876543212',
      'postedDays': '1 दिवसापूर्वी',
      'expiresIn': '29 दिवस शिल्लक',
    },
    {
      'id': 'JOB004',
      'title': 'Electrician',
      'company': 'Bajaj Electricals',
      'location': 'नागपूर',
      'salary': '₹18,000 - ₹25,000',
      'experience': '0-2 वर्षे',
      'skills': 'Wiring, Repair, Safety',
      'degree': 'ITI Electrician',
      'type': 'Full Time',
      'postedBy': 'Supervisor',
      'phone': '+91 9876543213',
      'postedDays': '4 दिवसांपूर्वी',
      'expiresIn': '26 दिवस शिल्लक',
    },
    {
      'id': 'JOB005',
      'title': 'Mechanic',
      'company': 'Maruti Suzuki',
      'location': 'पुणे',
      'salary': '₹20,000 - ₹30,000',
      'experience': '1-3 वर्षे',
      'skills': 'Engine Repair, Diagnostics',
      'degree': 'ITI Mechanic',
      'type': 'Full Time',
      'postedBy': 'Service Manager',
      'phone': '+91 9876543214',
      'postedDays': '5 दिवसांपूर्वी',
      'expiresIn': '25 दिवस शिल्लक',
    },
  ];

  // === Resume अपलोड केले आहे का (डेमो) ===
  bool _resumeUploaded = false;

  // === जॉब शोध (Skill/Degree/Company) ===
  List<Map<String, dynamic>> get _filteredJobs {
    if (_query.trim().isEmpty) return _jobPosts;
    final q = _query.toLowerCase();
    return _jobPosts.where((job) {
      return job['title'].toString().toLowerCase().contains(q) ||
          job['company'].toString().toLowerCase().contains(q) ||
          job['skills'].toString().toLowerCase().contains(q) ||
          job['degree'].toString().toLowerCase().contains(q) ||
          job['location'].toString().toLowerCase().contains(q);
    }).toList();
  }

  List<Map<String, dynamic>> get _results {
    if (_isJobs) return [];
    final q = _query.trim();
    return ListingStore.active(_type).where((p) {
      if (q.isEmpty) return true;
      final v = p['values'] as Map;
      final text = '${ListingStore.title(p)} ${v['keywords']} ${v['where']}'.toLowerCase();
      return text.contains(q.toLowerCase());
    }).toList();
  }

  String get _postLabel {
    if (_type == 'job') return 'जॉब पोस्ट करा (₹30)';
    if (_type == 'rent') return 'स्वतः Rent ने द्या';
    return 'Resale करा';
  }

  // === CV/Resume अपलोड विंडो ===
  void _showResumeUpload() {
    if (_resumeUploaded) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('तुमचा Resume आधीच अपलोड आहे'), backgroundColor: Colors.green),
      );
      return;
    }
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom + 20, left: 20, right: 20, top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('CV/Resume अपलोड करा', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark)),
            const SizedBox(height: 6),
            const Text('तुमचा Resume अपलोड केल्यावर कंपन्या तुम्हाला शोधू शकतील.', style: TextStyle(fontSize: 12, color: AppColors.textLight)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.blue.shade200)),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: Colors.blue, size: 20),
                  const SizedBox(width: 10),
                  Expanded(child: Text('Resume अपलोड करण्यासाठी ₹300 फी भरावी लागेल.', style: TextStyle(fontSize: 12, color: Colors.blue.shade900))),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(ctx);
                  setState(() => _resumeUploaded = true);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('₹300 फी भरली. Resume यशस्वीरित्या अपलोड झाला! ✅'), backgroundColor: Colors.green),
                  );
                },
                icon: const Icon(Icons.upload_file, color: Colors.white),
                label: const Text('₹300 भरा आणि Resume अपलोड करा', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // === जॉब पोस्ट करण्यासाठी (₹30 फी) ===
  void _openPost() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ListingPostScreen(type: _type)),
    ).then((_) => setState(() {}));
  }

  void _openMine() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => MyListingsScreen(types: _myTypes)),
    ).then((_) => setState(() {}));
  }

  // === जॉब डिटेल विंडो ===
  void _showJobDetail(Map<String, dynamic> job) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.75,
        minChildSize: 0.4,
        maxChildSize: 0.95,
        expand: false,
        builder: (ctx, scroll) => ListView(
          controller: scroll,
          padding: const EdgeInsets.all(20),
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: AppColors.primaryBlue.withValues(alpha: 0.1),
                  child: const Icon(Icons.work_outline, color: AppColors.primaryBlue, size: 28),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(job['title'], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                      Text(job['company'], style: const TextStyle(fontSize: 14, color: AppColors.primaryBlue, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            _infoRow(Icons.location_on_outlined, 'लोकेशन', job['location']),
            _infoRow(Icons.currency_rupee, 'पगार', job['salary']),
            _infoRow(Icons.work_history_outlined, 'अनुभव', job['experience']),
            _infoRow(Icons.school_outlined, 'पदवी', job['degree']),
            _infoRow(Icons.timer_outlined, 'प्रकार', job['type']),
            _infoRow(Icons.build_outlined, 'स्किल्स', job['skills']),
            _infoRow(Icons.person_outlined, 'पोस्ट करणारे', job['postedBy']),
            _infoRow(Icons.phone_outlined, 'संपर्क', job['phone']),
            _infoRow(Icons.access_time, 'पोस्ट केल्यापासून', job['postedDays']),
            _infoRow(Icons.timer, 'मुदत', job['expiresIn']),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('कंपनीला तुमची माहिती पाठवली!'), backgroundColor: Colors.green),
                  );
                },
                icon: const Icon(Icons.send, color: Colors.white),
                label: const Text('अप्लाय करा', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.primaryBlue),
          const SizedBox(width: 8),
          Text('$label: ', style: const TextStyle(fontSize: 13, color: AppColors.textLight)),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark))),
        ],
      ),
    );
  }

  // === जॉब कार्ड ===
  Widget _jobCard(Map<String, dynamic> job) {
    return GestureDetector(
      onTap: () => _showJobDetail(job),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.lightGrey),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6, offset: const Offset(0, 2))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48, height: 48,
                  decoration: BoxDecoration(color: AppColors.primaryBlue.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                  child: const Icon(Icons.work_outline, color: AppColors.primaryBlue, size: 28),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(job['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.textDark)),
                      Text(job['company'], style: const TextStyle(fontSize: 12, color: AppColors.primaryBlue, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: AppColors.textLight),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(height: 1),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.location_on_outlined, size: 14, color: AppColors.textLight),
                const SizedBox(width: 4),
                Text(job['location'], style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
                const SizedBox(width: 12),
                const Icon(Icons.currency_rupee, size: 14, color: Colors.green),
                const SizedBox(width: 4),
                Text(job['salary'], style: const TextStyle(fontSize: 11, color: Colors.green, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.build_outlined, size: 14, color: AppColors.textLight),
                const SizedBox(width: 4),
                Expanded(child: Text(job['skills'], style: const TextStyle(fontSize: 11, color: AppColors.textLight), maxLines: 1, overflow: TextOverflow.ellipsis)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(6)),
                  child: Text(job['postedDays'], style: TextStyle(fontSize: 10, color: Colors.orange.shade800)),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(6)),
                  child: Text(job['expiresIn'], style: TextStyle(fontSize: 10, color: Colors.red.shade700)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // === Resale/Rent कार्ड (जुनं) ===
  Widget _card(Map<String, dynamic> p) {
    final icon = _type == 'job'
        ? Icons.work_outline
        : (_type == 'rent' ? Icons.key_outlined : Icons.sell_outlined);
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.lightGrey)),
        child: Row(
          children: [
            Container(
              width: 48, height: 48,
              decoration: BoxDecoration(color: AppColors.primaryBlue.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, color: AppColors.primaryBlue),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(ListingStore.title(p), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textDark)),
                  const SizedBox(height: 2),
                  Text(ListingStore.subtitle(p), style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textLight),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final results = _results;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(_isJobs ? '💼 Jobs' : '🔁 Resale Or Rent', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // === शोध ===
          TextField(
            onChanged: (v) => setState(() => _query = v),
            decoration: InputDecoration(
              hintText: _isJobs ? 'जॉब शोधा (Skill, Degree, Company)...' : 'शोधा (keyword)...',
              prefixIcon: const Icon(Icons.search, color: AppColors.primaryBlue),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 12),

          // === Resale/Rent टॅब ===
          if (!_isJobs)
            Row(
              children: [
                ChoiceChip(label: const Text('Resale section बघा'), selected: _section == 'resale', onSelected: (_) => setState(() => _section = 'resale')),
                const SizedBox(width: 8),
                ChoiceChip(label: const Text('Rent section'), selected: _section == 'rent', onSelected: (_) => setState(() => _section = 'rent')),
              ],
            ),
          const SizedBox(height: 10),

          // === Jobs साठी Resume अपलोड बटण ===
          if (_isJobs) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.green.shade200)),
              child: Row(
                children: [
                  Icon(_resumeUploaded ? Icons.check_circle : Icons.description_outlined, color: _resumeUploaded ? Colors.green : Colors.green.shade700, size: 24),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_resumeUploaded ? 'Resume अपलोड आहे ✅' : 'तुमचा Resume अपलोड करा', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.green.shade900)),
                        Text(_resumeUploaded ? 'कंपन्या तुम्हाला शोधू शकतात' : '₹300 फी - कंपन्या तुम्हाला शोधू शकतील', style: TextStyle(fontSize: 11, color: Colors.green.shade700)),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _showResumeUpload,
                    style: ElevatedButton.styleFrom(backgroundColor: _resumeUploaded ? Colors.grey : Colors.green, padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), minimumSize: Size.zero),
                    child: Text(_resumeUploaded ? 'अपलोड ✅' : 'अपलोड (₹300)', style: const TextStyle(fontSize: 11, color: Colors.white)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],

          // === पोस्ट आणि माझ्या पोस्ट बटण ===
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _openPost,
                  icon: const Icon(Icons.add),
                  label: Text(_postLabel),
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 12)),
                ),
              ),
              const SizedBox(width: 10),
              OutlinedButton(
                onPressed: _openMine,
                style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14)),
                child: const Text('माझ्या पोस्ट'),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // === Jobs साठी जॉब लिस्ट ===
          if (_isJobs) ...[
            if (_filteredJobs.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Center(child: Text('या शोधासाठी जॉब सापडला नाही', style: TextStyle(color: AppColors.textLight))),
              )
            else
              ..._filteredJobs.map(_jobCard),
          ]
          // === Resale/Rent साठी जुनं ===
          else ...[
            if (results.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Center(child: Text('सध्या कोणतीही पोस्ट सापडली नाही', style: TextStyle(color: AppColors.textLight))),
              )
            else
              ...results.map(_card),
          ],
        ],
      ),
    );
  }
}
