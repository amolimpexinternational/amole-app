import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class JobPortalScreen extends StatefulWidget {
  const JobPortalScreen({super.key});

  @override
  State<JobPortalScreen> createState() => _JobPortalScreenState();
}

class _JobPortalScreenState extends State<JobPortalScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // === Tab 1: Jobs (Job Seeker side) ===
  final List<Map<String, dynamic>> _jobs = [
    {
      'title': 'Mechanical Engineer',
      'company': 'Tata Motors',
      'salary': '₹35,000 - ₹45,000',
      'location': 'Pune',
      'profile': 'Mechanical Engineer',
      'requirements': 'BE Mechanical, AutoCAD, 2+ years exp',
      'workType': 'Full-time',
      'duration': 'Permanent',
      'posted': '2 दिवसांपूर्वी',
      'isNew': true,
      'contactPerson': 'HR Manager - Tata Motors',
      'contactPhone': '+91 98200 11111',
      'contactEmail': 'hr@tatamotors.com',
    },
    {
      'title': 'Civil Supervisor',
      'company': 'L&T Construction',
      'salary': '₹25,000 - ₹30,000',
      'location': 'Mumbai',
      'profile': 'Civil Supervisor',
      'requirements': 'Diploma Civil, Site Management',
      'workType': 'Full-time',
      'duration': '1 वर्ष करार',
      'posted': '5 दिवसांपूर्वी',
      'isNew': false,
      'contactPerson': 'Project Head - L&T',
      'contactPhone': '+91 98200 22222',
      'contactEmail': 'careers@lnt.com',
    },
    {
      'title': 'Operations Head',
      'company': 'Amazon',
      'salary': '₹60,000 - ₹80,000',
      'location': 'Pune',
      'profile': 'Operations Manager',
      'requirements': 'MBA, Supply Chain, 5+ years',
      'workType': 'Full-time',
      'duration': 'Permanent',
      'posted': 'आज',
      'isNew': true,
      'contactPerson': 'Talent Team - Amazon',
      'contactPhone': '+91 98200 33333',
      'contactEmail': 'talent@amazon.in',
    },
    {
      'title': 'Electrician',
      'company': 'Reliance',
      'salary': '₹18,000 - ₹22,000',
      'location': 'Nagpur',
      'profile': 'Electrician',
      'requirements': 'ITI Electrician, 1+ years',
      'workType': 'Full-time',
      'duration': 'Permanent',
      'posted': '१ आठवड्यापूर्वी',
      'isNew': false,
      'contactPerson': 'Site Manager - Reliance',
      'contactPhone': '+91 98200 44444',
      'contactEmail': 'site@reliance.com',
    },
  ];

  // === Tab 3: Candidates (Employer side) ===
  final List<Map<String, dynamic>> _candidates = [
    {
      'name': 'राहुल शर्मा',
      'education': 'BE Mechanical',
      'jobProfile': 'Mechanical Engineer',
      'experience': '3 years',
      'salaryExpectation': '₹40,000',
      'location': 'Pune',
      'skills': 'AutoCAD, SolidWorks, Project Management',
    },
    {
      'name': 'स्नेहा पाटील',
      'education': 'MBA',
      'jobProfile': 'Operations Manager',
      'experience': '5 years',
      'salaryExpectation': '₹70,000',
      'location': 'Mumbai',
      'skills': 'Supply Chain, Team Handling, Excel',
    },
    {
      'name': 'अमित जाधव',
      'education': 'Diploma Civil',
      'jobProfile': 'Civil Supervisor',
      'experience': '2 years',
      'salaryExpectation': '₹28,000',
      'location': 'Pune',
      'skills': 'Site Management, AutoCAD',
    },
    {
      'name': 'प्रिया देशमुख',
      'education': 'ITI Electrician',
      'jobProfile': 'Electrician',
      'experience': '4 years',
      'salaryExpectation': '₹22,000',
      'location': 'Nagpur',
      'skills': 'Wiring, Repair, Safety',
    },
  ];

  // === Tab 3: Posted requirements (employer posts) ===
  final List<Map<String, dynamic>> _requirements = [];

  // === Tab 2: Resume builder controllers ===
  final _resumeFormKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _mobileCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _aadhaarCtrl = TextEditingController();
  final _panCtrl = TextEditingController();
  final _qualificationCtrl = TextEditingController();
  final _instituteCtrl = TextEditingController();
  final _passingYearCtrl = TextEditingController();
  final _companyCtrl = TextEditingController();
  final _roleCtrl = TextEditingController();
  final _expYearsCtrl = TextEditingController();
  final _salaryCtrl = TextEditingController();
  final _skillsCtrl = TextEditingController();

  bool _profileLive = false;

  // === Filters (Tab 3) ===
  String _filterEducation = 'सर्व';
  String _filterProfile = 'सर्व';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _nameCtrl.dispose();
    _mobileCtrl.dispose();
    _emailCtrl.dispose();
    _aadhaarCtrl.dispose();
    _panCtrl.dispose();
    _qualificationCtrl.dispose();
    _instituteCtrl.dispose();
    _passingYearCtrl.dispose();
    _companyCtrl.dispose();
    _roleCtrl.dispose();
    _expYearsCtrl.dispose();
    _salaryCtrl.dispose();
    _skillsCtrl.dispose();
    super.dispose();
  }

  // === Fee Dialog (₹30 Apply) ===
  void _showFeeDialog({
    required String title,
    required int amount,
    required String description,
    required VoidCallback onSuccess,
  }) {
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
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('फी:', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('₹$amount',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          fontSize: 18)),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Text('टीप: फी तुमच्या Expenses Wallet मधून कापली जाईल.',
                style: TextStyle(fontSize: 11, color: AppColors.textLight)),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('रद्द करा')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              onSuccess();
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue),
            child: Text('₹$amount भरा आणि पुढे जा',
                style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // === Job Detail + Apply ===
  void _showJobDetail(Map<String, dynamic> job) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.75,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (ctx, ctrl) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(Icons.work_outline, color: AppColors.primaryBlue),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text('नोकरीची माहिती',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(ctx)),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView(
                controller: ctrl,
                padding: const EdgeInsets.all(16),
                children: [
                  Text(job['title'],
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(job['company'],
                      style: const TextStyle(
                          fontSize: 15,
                          color: AppColors.primaryBlue,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  _infoRow('पगार', job['salary']),
                  _infoRow('जॉब प्रोफाइल', job['profile']),
                  _infoRow('लोकेशन', job['location']),
                  _infoRow('कामाचे स्वरूप', job['workType']),
                  _infoRow('कालावधी', job['duration']),
                  _infoRow('Posted', job['posted']),
                  const SizedBox(height: 8),
                  _sectionBox('📋 Job Requirement', job['requirements']),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.orange.shade200),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.lock_outline, color: Colors.orange, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'संपर्क माहिती Apply केल्यावरच दिसेल.',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(ctx);
                        _applyForJob(job);
                      },
                      icon: const Icon(Icons.send, color: Colors.white),
                      label: const Text('Apply Job (₹30)',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.successGreen,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _applyForJob(Map<String, dynamic> job) {
    _showFeeDialog(
      title: 'Apply Job',
      amount: 30,
      description:
          '"${job['title']}" साठी अर्ज करण्यासाठी ₹30 फी भरा. फी भरल्यावर नोकरी देणाऱ्याची संपर्क माहिती दिसेल.',
      onSuccess: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('✅ जॉब Apply झाला! संपर्क माहिती खाली दिली आहे.'),
              backgroundColor: Colors.green),
        );
        _showContactDialog(job);
      },
    );
  }

  void _showContactDialog(Map<String, dynamic> job) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green),
            SizedBox(width: 8),
            Text('जॉब Apply झाला ✅'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('संपर्क माहिती:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 8),
            _contactRow(Icons.person, job['contactPerson']),
            _contactRow(Icons.phone, job['contactPhone']),
            _contactRow(Icons.email, job['contactEmail']),
            const SizedBox(height: 12),
            const Text(
              'कृपया नोकरीदात्याशी थेट संपर्क साधा.',
              style: TextStyle(fontSize: 11, color: AppColors.textLight, fontStyle: FontStyle.italic),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue),
            child: const Text('ठीक आहे', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _contactRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.primaryBlue),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 13))),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 130,
              child: Text('$label:',
                  style: const TextStyle(
                      fontSize: 13, color: AppColors.textLight))),
          Expanded(
              child: Text(value,
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }

  Widget _sectionBox(String title, String content) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.lightGrey.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlue)),
          const SizedBox(height: 6),
          Text(content, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }

  // === Post Employee Requirement (Employer) ===
  void _showPostRequirementDialog() {
    final titleCtrl = TextEditingController();
    final salaryCtrl = TextEditingController();
    final profileCtrl = TextEditingController();
    final locationCtrl = TextEditingController();
    final reqCtrl = TextEditingController();
    final durationCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    final mobileCtrl = TextEditingController();
    final websiteCtrl = TextEditingController();
    final socialCtrl = TextEditingController();
    String workType = 'Full-time';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) => DraggableScrollableSheet(
          initialChildSize: 0.9,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          expand: false,
          builder: (ctx, ctrl) => Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.post_add, color: AppColors.primaryBlue),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text('नवीन Employee Requirement',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(ctx)),
                  ],
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: ListView(
                  controller: ctrl,
                  padding: const EdgeInsets.all(16),
                  children: [
                    _label('जॉब टायटल / पद'),
                    _field(titleCtrl, 'उदा. Mechanical Engineer'),
                    _label('पगार'),
                    _field(salaryCtrl, 'उदा. ₹35,000 - ₹45,000'),
                    _label('जॉब प्रोफाइल'),
                    _field(profileCtrl, 'उदा. Mechanical Engineer'),
                    _label('लोकेशन'),
                    _field(locationCtrl, 'उदा. Pune'),
                    _label('कामाचे स्वरूप'),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(10)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: workType,
                          items: ['Full-time', 'Part-time', 'Contract', 'Internship']
                              .map((e) =>
                                  DropdownMenuItem(value: e, child: Text(e)))
                              .toList(),
                          onChanged: (v) => setModalState(() => workType = v!),
                        ),
                      ),
                    ),
                    _label('कालावधी'),
                    _field(durationCtrl, 'उदा. Permanent / 6 months'),
                    _label('Job Requirement'),
                    TextField(
                      controller: reqCtrl,
                      maxLines: 3,
                      decoration: _deco('आवश्यक कौशल्य, अनुभव, इ.'),
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 8),
                    const Text('संपर्क माहिती',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    const Text('(अर्ज करणाऱ्याला हे दिसेल)',
                        style: TextStyle(
                            fontSize: 11, color: AppColors.textLight)),
                    const SizedBox(height: 8),
                    _label('E-mail'),
                    _field(emailCtrl, 'उदा. hr@company.com'),
                    _label('Mobile'),
                    _field(mobileCtrl, 'उदा. +91 98200 12345'),
                    _label('Official Website'),
                    _field(websiteCtrl, 'उदा. www.company.com'),
                    _label('Company Social Profile'),
                    _field(socialCtrl, 'LinkedIn / Facebook / Instagram'),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.info_outline, size: 16, color: Colors.blue),
                          SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              'Visiting Card upload — Stage 3 मध्ये जोडले जाईल.',
                              style: TextStyle(fontSize: 11, color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (titleCtrl.text.trim().isEmpty ||
                              salaryCtrl.text.trim().isEmpty ||
                              mobileCtrl.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'कृपया जॉब टायटल, पगार, मोबाईल भरा'),
                                  backgroundColor: Colors.red),
                            );
                            return;
                          }
                          setState(() {
                            _requirements.insert(0, {
                              'title': titleCtrl.text.trim(),
                              'salary': salaryCtrl.text.trim(),
                              'profile': profileCtrl.text.trim(),
                              'location': locationCtrl.text.trim(),
                              'requirements': reqCtrl.text.trim(),
                              'workType': workType,
                              'duration': durationCtrl.text.trim(),
                              'email': emailCtrl.text.trim(),
                              'mobile': mobileCtrl.text.trim(),
                              'website': websiteCtrl.text.trim(),
                              'social': socialCtrl.text.trim(),
                              'postedBy': 'Employer (Demo)',
                              'posted': 'आज',
                            });
                          });
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('✅ Requirement Live झाली!'),
                                backgroundColor: Colors.green),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.successGreen,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text('Post करा (Free)',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // === Tab 1: Job Search ===
  Widget _buildJobSearchTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('नवीन नोकऱ्या',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark)),
        const SizedBox(height: 4),
        const Text('नोकरीवर क्लिक करा → माहिती बघा → Apply करा',
            style: TextStyle(fontSize: 12, color: AppColors.textLight)),
        const SizedBox(height: 12),
        ..._jobs.map((job) => _buildJobCard(job)),
      ],
    );
  }

  Widget _buildJobCard(Map<String, dynamic> job) {
    return GestureDetector(
      onTap: () => _showJobDetail(job),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: job['isNew'] == true
                  ? AppColors.primaryBlue.withValues(alpha: 0.3)
                  : Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.04), blurRadius: 6)
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Text(job['title'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: AppColors.textDark))),
                if (job['isNew'] == true)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text('नवीन',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold)),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(job['company'],
                style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.primaryBlue,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.work_outline, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Expanded(
                    child: Text(job['requirements'],
                        style: const TextStyle(
                            fontSize: 12, color: AppColors.textLight))),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  const Icon(Icons.location_on, size: 14, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(job['location'],
                      style: const TextStyle(fontSize: 12)),
                ]),
                Text(job['salary'],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontSize: 14)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _showJobDetail(job),
                    style: OutlinedButton.styleFrom(
                        minimumSize: const Size(0, 40)),
                    child: const Text('Apply Job (₹30)'),
                  ),
                ),
                const SizedBox(width: 10),
                Text(job['posted'],
                    style: const TextStyle(
                        fontSize: 11, color: AppColors.textLight)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // === Tab 2: My Profile / Resume Builder ===
  Widget _buildMyProfileTab() {
    return Form(
      key: _resumeFormKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.indigo.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.indigo.shade200),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.indigo.shade700),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'तुमची resume स्वतः तयार करा — पूर्ण फ्री. Profile Live केल्यावर Employers तुम्हाला शोधू शकतील.',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          _sectionTitle('१. KYC माहिती'),
          _label('पूर्ण नाव *'),
          _field(_nameCtrl, 'तुमचे पूर्ण नाव', required: true),
          _label('मोबाईल नंबर *'),
          _field(_mobileCtrl, '+91 98XXXXXXXX', required: true, keyboard: TextInputType.phone),
          _label('E-mail'),
          _field(_emailCtrl, 'you@email.com', keyboard: TextInputType.emailAddress),
          _label('आधार नंबर'),
          _field(_aadhaarCtrl, 'XXXX XXXX XXXX', keyboard: TextInputType.number),
          _label('PAN नंबर'),
          _field(_panCtrl, 'ABCDE1234F'),

          const SizedBox(height: 16),
          _sectionTitle('२. शैक्षणिक माहिती'),
          _label('सर्वोच्च पात्रता *'),
          _field(_qualificationCtrl, 'उदा. BE Mechanical', required: true),
          _label('संस्था / कॉलेज'),
          _field(_instituteCtrl, 'उदा. COEP Pune'),
          _label('उत्तीर्ण वर्ष'),
          _field(_passingYearCtrl, 'उदा. 2022', keyboard: TextInputType.number),

          const SizedBox(height: 16),
          _sectionTitle('३. कामाचा अनुभव'),
          _label('कंपनी'),
          _field(_companyCtrl, 'उदा. XYZ Pvt Ltd'),
          _label('पद'),
          _field(_roleCtrl, 'उदा. Junior Engineer'),
          _label('एकूण वर्षे'),
          _field(_expYearsCtrl, 'उदा. 2', keyboard: TextInputType.number),

          const SizedBox(height: 16),
          _sectionTitle('४. अपेक्षित पगार'),
          _label('मासिक अपेक्षा'),
          _field(_salaryCtrl, 'उदा. ₹35,000', keyboard: TextInputType.number),

          const SizedBox(height: 16),
          _sectionTitle('५. कौशल्ये'),
          _label('Skills (स्वल्पविरामाने वेगळे करा)'),
          TextFormField(
            controller: _skillsCtrl,
            maxLines: 3,
            decoration: _deco('उदा. AutoCAD, SolidWorks, Team Management'),
          ),

          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _profileLive ? null : _goLiveProfile,
              icon: Icon(_profileLive ? Icons.check_circle : Icons.person_add_alt_1,
                  color: Colors.white),
              label: Text(
                _profileLive ? 'Profile Live आहे ✓' : 'Profile Live करा (Free)',
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    _profileLive ? Colors.grey : AppColors.successGreen,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
          const SizedBox(height: 12),
          if (_profileLive)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.green.shade300),
              ),
              child: const Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'तुमची Profile आता Live आहे — Employers तुम्हाला शोधू शकतील.',
                      style: TextStyle(fontSize: 12, color: Colors.green),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  void _goLiveProfile() {
    if (!_resumeFormKey.currentState!.validate()) return;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Profile Live करायची?'),
        content: const Text(
          'तुमची resume सर्व Employers (जे कर्मचारी शोधत आहेत) त्यांना दिसेल. Free आहे.',
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text('रद्द')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              setState(() => _profileLive = true);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('✅ Profile Live झाली!'),
                    backgroundColor: Colors.green),
              );
            },
            style:
                ElevatedButton.styleFrom(backgroundColor: AppColors.successGreen),
            child: const Text('हो, Live करा',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // === Tab 3: Employee Search ===
  List<Map<String, dynamic>> get _filteredCandidates {
    var list = _candidates;
    if (_filterEducation != 'सर्व') {
      list = list
          .where((c) => (c['education'] as String).contains(_filterEducation))
          .toList();
    }
    if (_filterProfile != 'सर्व') {
      list = list
          .where((c) => c['jobProfile'] == _filterProfile)
          .toList();
    }
    return list;
  }

  Widget _buildEmployeeSearchTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Post Requirement button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _showPostRequirementDialog,
            icon: const Icon(Icons.post_add, color: Colors.white),
            label: const Text('+ नवीन Employee Requirement Post करा',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14)),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Filters
        const Text('🔍 फिल्टर',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                initialValue: _filterEducation,
                decoration: InputDecoration(
                  labelText: 'शिक्षण',
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  isDense: true,
                ),
                items: ['सर्व', 'BE', 'MBA', 'Diploma', 'ITI']
                    .map((e) =>
                        DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => setState(() => _filterEducation = v!),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: DropdownButtonFormField<String>(
                initialValue: _filterProfile,
                decoration: InputDecoration(
                  labelText: 'जॉब प्रोफाइल',
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  isDense: true,
                ),
                items: [
                  'सर्व',
                  'Mechanical Engineer',
                  'Operations Manager',
                  'Civil Supervisor',
                  'Electrician',
                ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (v) => setState(() => _filterProfile = v!),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Posted Requirements
        if (_requirements.isNotEmpty) ...[
          const Text('📢 तुमच्या Posted Requirements',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ..._requirements.map((r) => _buildRequirementCard(r)),
          const SizedBox(height: 16),
        ],

        // Candidates
        Text('👥 Live Candidates (${_filteredCandidates.length})',
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        if (_filteredCandidates.isEmpty)
          const Center(
              child: Padding(
            padding: EdgeInsets.all(24),
            child: Text('कोणताही candidate सापडला नाही',
                style: TextStyle(color: AppColors.textLight)),
          ))
        else
          ..._filteredCandidates.map(_buildCandidateCard),
      ],
    );
  }

  Widget _buildCandidateCard(Map<String, dynamic> c) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor:
                    AppColors.primaryBlue.withValues(alpha: 0.1),
                child: Text((c['name'] as String)[0],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryBlue,
                        fontSize: 20)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(c['name'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                    Text(c['jobProfile'],
                        style: const TextStyle(
                            fontSize: 13, color: AppColors.primaryBlue)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(10)),
                child: const Text('LIVE',
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 10,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(children: [
            const Icon(Icons.school_outlined, size: 14, color: Colors.grey),
            const SizedBox(width: 4),
            Text(c['education'],
                style: const TextStyle(fontSize: 12)),
            const SizedBox(width: 12),
            const Icon(Icons.work_history_outlined,
                size: 14, color: Colors.grey),
            const SizedBox(width: 4),
            Text(c['experience'], style: const TextStyle(fontSize: 12)),
          ]),
          const SizedBox(height: 6),
          Row(children: [
            const Icon(Icons.location_on, size: 14, color: Colors.grey),
            const SizedBox(width: 4),
            Text(c['location'],
                style: const TextStyle(fontSize: 12)),
            const SizedBox(width: 12),
            const Icon(Icons.currency_rupee, size: 14, color: Colors.grey),
            const SizedBox(width: 4),
            Text(c['salaryExpectation'],
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.green)),
          ]),
          const SizedBox(height: 6),
          Text('Skills: ${c['skills']}',
              style: const TextStyle(
                  fontSize: 12, color: AppColors.textLight)),
        ],
      ),
    );
  }

  Widget _buildRequirementCard(Map<String, dynamic> r) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.teal.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(r['title'],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15)),
              ),
              const Icon(Icons.check_circle, color: Colors.green, size: 20),
            ],
          ),
          const SizedBox(height: 4),
          Text('${r['salary']} · ${r['location']} · ${r['workType']}',
              style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 4),
          Text('Duration: ${r['duration']}',
              style: const TextStyle(
                  fontSize: 11, color: AppColors.textLight)),
          const SizedBox(height: 6),
          Text('Posted by: ${r['postedBy']} (फक्त Franchise/CP/Admin ला दिसेल)',
              style: const TextStyle(
                  fontSize: 10, color: AppColors.textLight, fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }

  // === Helpers ===
  Widget _label(String text) => Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 4),
        child: Text(text,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.textLight)),
      );

  Widget _sectionTitle(String text) => Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 6),
        child: Text(text,
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryBlue)),
      );

  InputDecoration _deco(String hint) => InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      );

  Widget _field(TextEditingController ctrl, String hint,
      {bool required = false, TextInputType? keyboard}) {
    return TextFormField(
      controller: ctrl,
      keyboardType: keyboard,
      decoration: _deco(hint),
      validator: required
          ? (v) => (v == null || v.trim().isEmpty) ? 'आवश्यक' : null
          : null,
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
          labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          tabs: const [
            Tab(text: 'नोकऱ्या शोधा'),
            Tab(text: 'माझे प्रोफाइल'),
            Tab(text: 'कर्मचारी शोधा'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildJobSearchTab(),
          _buildMyProfileTab(),
          _buildEmployeeSearchTab(),
        ],
      ),
    );
  }
}