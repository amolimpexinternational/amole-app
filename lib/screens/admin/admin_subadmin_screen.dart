import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class AdminSubAdminScreen extends StatefulWidget {
  const AdminSubAdminScreen({super.key});

  @override
  State<AdminSubAdminScreen> createState() => _AdminSubAdminScreenState();
}

class _AdminSubAdminScreenState extends State<AdminSubAdminScreen> {
  // Stage 2: Demo / local data.
  // Stage 3 मध्ये Firestore (collection: sub_admins) जोडले जाईल.
  final List<Map<String, dynamic>> _subAdmins = [
    {
      'name': 'अमित पाटील',
      'mobile': '+91 98765 10001',
      'code': 'AM-SUB-000001',
      'active': true,
    },
    {
      'name': 'स्नेहा देशमुख',
      'mobile': '+91 98765 10002',
      'code': 'AM-SUB-000002',
      'active': true,
    },
    {
      'name': 'रोहित शिंदे',
      'mobile': '+91 98765 10003',
      'code': 'AM-SUB-000003',
      'active': false,
    },
  ];

  void _showAddSubAdminDialog() {
    final nameController = TextEditingController();
    final mobileController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Row(
          children: [
            Icon(
              Icons.admin_panel_settings_outlined,
              color: AppColors.primaryBlue,
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text('नवीन Sub-Admin नियुक्त करा'),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  labelText: 'नाव',
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: mobileController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'मोबाईल नंबर',
                  prefixIcon: const Icon(Icons.phone_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withValues(alpha: 0.07),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 20,
                      color: AppColors.primaryBlue,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Sub-Admin ला Admin प्रमाणे सर्व अधिकार असतील. '
                        'तो/ती मुख्य Admin च्या अंतर्गत काम करेल.',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textDark,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('रद्द करा'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
            ),
            onPressed: () {
              final name = nameController.text.trim();
              final mobile = mobileController.text.trim();

              if (name.isEmpty || mobile.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('नाव आणि मोबाईल नंबर भरा'),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }

              setState(() {
                _subAdmins.add({
                  'name': name,
                  'mobile': mobile,
                  'code':
                      'AM-SUB-${(_subAdmins.length + 1).toString().padLeft(6, '0')}',
                  'active': true,
                });
              });

              Navigator.pop(dialogContext);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('✅ नवीन Sub-Admin नियुक्त झाला'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text(
              'नियुक्त करा',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditSubAdminDialog(int index) {
    final admin = _subAdmins[index];

    final nameController = TextEditingController(
      text: admin['name'] as String,
    );
    final mobileController = TextEditingController(
      text: admin['mobile'] as String,
    );

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Row(
          children: [
            Icon(
              Icons.edit_outlined,
              color: AppColors.primaryBlue,
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text('Sub-Admin माहिती Edit'),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                labelText: 'नाव',
                prefixIcon: const Icon(Icons.person_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: mobileController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'मोबाईल नंबर',
                prefixIcon: const Icon(Icons.phone_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('रद्द करा'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
            ),
            onPressed: () {
              final name = nameController.text.trim();
              final mobile = mobileController.text.trim();

              if (name.isEmpty || mobile.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('नाव आणि मोबाईल नंबर भरा'),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }

              setState(() {
                _subAdmins[index]['name'] = name;
                _subAdmins[index]['mobile'] = mobile;
              });

              Navigator.pop(dialogContext);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('✅ Sub-Admin माहिती अपडेट झाली'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text(
              'जतन करा',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _toggleSubAdmin(int index, bool value) {
    setState(() {
      _subAdmins[index]['active'] = value;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          value
              ? '✅ Sub-Admin सक्रिय करण्यात आला'
              : 'Sub-Admin निष्क्रिय करण्यात आला',
        ),
        backgroundColor: value ? Colors.green : Colors.orange,
      ),
    );
  }

  void _showRightsDialog(int index) {
    final admin = _subAdmins[index];

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            const Icon(
              Icons.security_outlined,
              color: AppColors.primaryBlue,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text('${admin['name']} — अधिकार'),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.admin_panel_settings_outlined,
                    color: AppColors.primaryBlue,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Sub-Admin ला Admin प्रमाणे सर्व अधिकार आहेत.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            _permissionRow('Dashboard / KPI'),
            _permissionRow('CP / Franchise / Seller व्यवस्थापन'),
            _permissionRow('Ads / Offers व्यवस्थापन'),
            _permissionRow('Approvals'),
            _permissionRow('Notifications'),
            _permissionRow('Accounting / Ecosystem'),
            _permissionRow('Admin-level management'),
          ],
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
            ),
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text(
              'बंद करा',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _permissionRow(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            size: 18,
            color: Colors.green,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        title: const Text(
          'Sub-Admins',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: _subAdmins.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.admin_panel_settings_outlined,
                      size: 64,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'अजून कोणताही Sub-Admin नाही',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      '"नवीन Sub-Admin" बटण दाबून नियुक्त करा',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textLight,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _summaryCard(),
                const SizedBox(height: 16),
                const Text(
                  'Sub-Admin यादी',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 8),
                ...List.generate(
                  _subAdmins.length,
                  (index) => _subAdminCard(index),
                ),
                const SizedBox(height: 80),
              ],
            ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primaryBlue,
        onPressed: _showAddSubAdminDialog,
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        label: const Text(
          'नवीन Sub-Admin',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _summaryCard() {
    final activeCount =
        _subAdmins.where((admin) => admin['active'] == true).length;
    final inactiveCount =
        _subAdmins.where((admin) => admin['active'] == false).length;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _summaryItem(
              activeCount.toString(),
              'Active',
              Colors.green,
            ),
          ),
          Container(
            width: 1,
            height: 38,
            color: Colors.grey.shade300,
          ),
          Expanded(
            child: _summaryItem(
              inactiveCount.toString(),
              'Inactive',
              Colors.orange,
            ),
          ),
          Container(
            width: 1,
            height: 38,
            color: Colors.grey.shade300,
          ),
          Expanded(
            child: _summaryItem(
              _subAdmins.length.toString(),
              'Total',
              AppColors.primaryBlue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryItem(String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: AppColors.textLight,
          ),
        ),
      ],
    );
  }

  Widget _subAdminCard(int index) {
    final admin = _subAdmins[index];
    final bool isActive = admin['active'] == true;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isActive
              ? Colors.green.withValues(alpha: 0.15)
              : Colors.orange.withValues(alpha: 0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 7,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor:
                    AppColors.primaryBlue.withValues(alpha: 0.1),
                child: const Icon(
                  Icons.admin_panel_settings_outlined,
                  color: AppColors.primaryBlue,
                  size: 26,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      admin['name'] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      admin['mobile'] as String,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textLight,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      admin['code'] as String,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textLight,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Switch(
                    value: isActive,
                    activeThumbColor: Colors.green,
                    onChanged: (value) => _toggleSubAdmin(index, value),
                  ),
                  Text(
                    isActive ? 'ON' : 'OFF',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: isActive ? Colors.green : Colors.orange,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(9),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.verified_user_outlined,
                  size: 17,
                  color: AppColors.primaryBlue,
                ),
                SizedBox(width: 7),
                Expanded(
                  child: Text(
                    'Admin सारखे सर्व अधिकार • Admin च्या अंतर्गत',
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.textDark,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _showRightsDialog(index),
                  icon: const Icon(
                    Icons.security_outlined,
                    size: 17,
                  ),
                  label: const Text(
                    'अधिकार',
                    style: TextStyle(fontSize: 12),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primaryBlue,
                    side: BorderSide(
                      color: AppColors.primaryBlue.withValues(alpha: 0.35),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _showEditSubAdminDialog(index),
                  icon: const Icon(
                    Icons.edit_outlined,
                    size: 17,
                  ),
                  label: const Text(
                    'Edit',
                    style: TextStyle(fontSize: 12),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primaryBlue,
                    side: BorderSide(
                      color: AppColors.primaryBlue.withValues(alpha: 0.35),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}