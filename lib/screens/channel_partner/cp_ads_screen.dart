
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'cp_create_ad_screen.dart';

class CpAdsScreen extends StatefulWidget {
  const CpAdsScreen({super.key});

  @override
  State<CpAdsScreen> createState() => _CpAdsScreenState();
}

class _CpAdsScreenState extends State<CpAdsScreen> {
  // 0 = Live, 1 = Pending, 2 = Rejected
  int _selectedTab = 1;

  final List<Map<String, dynamic>> _ads = [
    {
      'owner': 'हडपसर फ्रँचाइजी',
      'role': 'Franchise',
      'franchise': 'हडपसर',
      'title': 'दिवाळी Sale — संपूर्ण जिल्हा',
      'description': 'दिवाळीनिमित्त हडपसर परिसरातील सर्व स्टोअर्सवर 20% सूट.',
      'budget': '₹1,000',
      'days': '7 दिवस',
      'status': 'प्रतीक्षेत',
      'targetArea': 'पुणे जिल्हा',
      'targetAge': '18-45',
      'targetGender': 'सर्व',
      'image': null,
      'rejectReason': '',
    },
    {
      'owner': 'गणेश किराणा मार्ट',
      'role': 'Seller',
      'franchise': 'हडपसर',
      'title': 'नवीन Mobile Accessories',
      'description': 'नवीन मोबाईल ऍक्सेसरीज उपलब्ध. 10% सूट.',
      'budget': '₹300',
      'days': '5 दिवस',
      'status': 'प्रतीक्षेत',
      'targetArea': 'हडपसर',
      'targetAge': '18-35',
      'targetGender': 'सर्व',
      'image': null,
      'rejectReason': '',
    },
    {
      'owner': 'प्रिया',
      'role': 'Promoter',
      'franchise': 'कोथरूड',
      'title': 'सणासुदीची खास ऑफर',
      'description': 'प्रमोटर मार्फत खास ऑफर — 15% सूट.',
      'budget': '₹250',
      'days': '4 दिवस',
      'status': 'प्रतीक्षेत',
      'targetArea': 'कोथरूड',
      'targetAge': '18-45',
      'targetGender': 'स्त्री',
      'image': null,
      'rejectReason': '',
    },
    {
      'owner': 'श्री मेडिकल',
      'role': 'Seller',
      'franchise': 'कोथरूड',
      'title': 'Generic Medicines उपलब्ध',
      'description': 'सर्व जेनेरिक औषधे उपलब्ध. 5% सूट.',
      'budget': '₹200',
      'days': '3 दिवस',
      'status': 'मंजूर',
      'targetArea': 'कोथरूड',
      'targetAge': 'सर्व',
      'targetGender': 'सर्व',
      'image': null,
      'rejectReason': '',
    },
    {
      'owner': 'AMOLE Channel Partner',
      'role': 'CP',
      'franchise': 'स्वतःची जाहिरात',
      'title': 'AMOLE Premium Launch',
      'description': 'AMOLE Premium सदस्यत्वाची ऑफर — संपूर्ण जिल्ह्यासाठी.',
      'budget': '₹2,000',
      'days': '10 दिवस',
      'status': 'मंजूर',
      'targetArea': 'पुणे जिल्हा',
      'targetAge': '18-45',
      'targetGender': 'सर्व',
      'image': null,
      'rejectReason': '',
    },
    {
      'owner': 'न्यू फॅशन पॉइंट',
      'role': 'Seller',
      'franchise': 'वडगाव',
      'title': 'Fashion Special Discount',
      'description': 'नवीन कलेक्शनवर खास सवलत.',
      'budget': '₹500',
      'days': '5 दिवस',
      'status': 'नाकारले',
      'targetArea': 'वडगाव',
      'targetAge': '18-40',
      'targetGender': 'सर्व',
      'image': null,
      'rejectReason': 'जाहिरातीमध्ये आवश्यक माहिती अपूर्ण आहे.',
    },
  ];

  List<Map<String, dynamic>> get _liveAds =>
      _ads.where((a) => a['status'] == 'मंजूर').toList();

  List<Map<String, dynamic>> get _pendingAds =>
      _ads.where((a) => a['status'] == 'प्रतीक्षेत').toList();

  List<Map<String, dynamic>> get _rejectedAds =>
      _ads.where((a) => a['status'] == 'नाकारले').toList();

  List<Map<String, dynamic>> get _selectedAds {
    switch (_selectedTab) {
      case 0:
        return _liveAds;
      case 1:
        return _pendingAds;
      case 2:
        return _rejectedAds;
      default:
        return [];
    }
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'प्रतीक्षेत':
        return Colors.orange;
      case 'मंजूर':
        return Colors.green;
      case 'नाकारले':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _approveAd(Map<String, dynamic> ad) {
    setState(() {
      ad['status'] = 'मंजूर';
      ad['rejectReason'] = '';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('✅ जाहिरात मंजूर झाली आणि थेट Live झाली.'),
        backgroundColor: AppColors.successGreen,
      ),
    );
  }

  Future<void> _rejectAd(Map<String, dynamic> ad) async {
    final reasonCtrl = TextEditingController();

    final reason = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('जाहिरात नाकारा'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('जाहिरात: ${ad['title']}'),
            const SizedBox(height: 12),
            TextField(
              controller: reasonCtrl,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'नाकारण्याचे कारण',
                hintText: 'कारण लिहा...',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('रद्द'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(dialogContext, reasonCtrl.text.trim());
            },
            child: const Text('नकार द्या'),
          ),
        ],
      ),
    );

    reasonCtrl.dispose();

    if (!mounted || reason == null) return;

    setState(() {
      ad['status'] = 'नाकारले';
      ad['rejectReason'] = reason.isEmpty
          ? 'कारण नमूद केलेले नाही.'
          : reason;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('❌ जाहिरात नाकारली.'),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _previewAd(Map<String, dynamic> ad) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (ctx, scrollCtrl) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(
                    Icons.visibility,
                    color: AppColors.primaryBlue,
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'जाहिरात Preview',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: AppColors.primaryBlue,
                    ),
                    tooltip: 'Edit',
                    onPressed: () {
                      Navigator.pop(sheetContext);
                      _editAd(ad);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(sheetContext),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView(
                controller: scrollCtrl,
                padding: const EdgeInsets.all(16),
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primaryBlue,
                          AppColors.royalBlue,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 140,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ad['image'] != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    ad['image'],
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.image,
                                        color: Colors.white70,
                                        size: 50,
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'जाहिरात फोटो',
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          ad['title'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          ad['description'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${ad['owner']} (${ad['role']})',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _section('जाहिरात तपशील', [
                    _infoRow('शीर्षक', ad['title']),
                    _infoRow('वर्णन', ad['description']),
                    _infoRow('जाहिरातदार', ad['owner']),
                    _infoRow('प्रकार', ad['role']),
                    _infoRow('Franchise', ad['franchise']),
                    _infoRow('Budget', ad['budget']),
                    _infoRow('कालावधी', ad['days']),
                  ]),
                  _section('🎯 Targeting', [
                    _infoRow('क्षेत्र', ad['targetArea']),
                    _infoRow('वयोगट', ad['targetAge']),
                    _infoRow('लिंग', ad['targetGender']),
                  ]),
                  if (ad['status'] == 'नाकारले')
                    _section('नाकारण्याचे कारण', [
                      _infoRow(
                        'कारण',
                        ad['rejectReason'] ?? 'कारण नमूद केलेले नाही.',
                      ),
                    ]),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _statusColor(ad['status']).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: _statusColor(ad['status']),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: _statusColor(ad['status']),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'स्थिती: ${ad['status']}',
                          style: TextStyle(
                            color: _statusColor(ad['status']),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (ad['status'] == 'प्रतीक्षेत')
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(sheetContext);
                          _rejectAd(ad);
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          side: const BorderSide(color: Colors.red),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text('❌ नाकारा'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(sheetContext);
                          _approveAd(ad);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.successGreen,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text(
                          '✅ मंजूर करा',
                          style: TextStyle(color: Colors.white),
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

  Future<void> _editAd(Map<String, dynamic> ad) async {
    final titleCtrl = TextEditingController(text: ad['title']);
    final descCtrl = TextEditingController(text: ad['description']);
    final budgetCtrl = TextEditingController(text: ad['budget']);
    final daysCtrl = TextEditingController(text: ad['days']);
    final areaCtrl = TextEditingController(text: ad['targetArea']);
    final ageCtrl = TextEditingController(text: ad['targetAge']);
    final genderCtrl = TextEditingController(text: ad['targetGender']);

    await showDialog<void>(
      context: context,
      builder: (dialogContext) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: Container(
          constraints: const BoxConstraints(maxHeight: 600),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'जाहिरात Edit करा',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _editField('शीर्षक', titleCtrl),
                      _editField('वर्णन', descCtrl, maxLines: 3),
                      _editField('Budget', budgetCtrl),
                      _editField('कालावधी', daysCtrl),
                      _editField('क्षेत्र', areaCtrl),
                      _editField('वयोगट', ageCtrl),
                      _editField('लिंग', genderCtrl),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(dialogContext),
                      child: const Text('रद्द'),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          ad['title'] = titleCtrl.text.trim();
                          ad['description'] = descCtrl.text.trim();
                          ad['budget'] = budgetCtrl.text.trim();
                          ad['days'] = daysCtrl.text.trim();
                          ad['targetArea'] = areaCtrl.text.trim();
                          ad['targetAge'] = ageCtrl.text.trim();
                          ad['targetGender'] = genderCtrl.text.trim();
                        });

                        Navigator.pop(dialogContext);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('✅ जाहिरात अद्ययावत झाली.'),
                            backgroundColor: AppColors.successGreen,
                          ),
                        );
                      },
                      child: const Text('जतन करा'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    titleCtrl.dispose();
    descCtrl.dispose();
    budgetCtrl.dispose();
    daysCtrl.dispose();
    areaCtrl.dispose();
    ageCtrl.dispose();
    genderCtrl.dispose();
  }

  void _deleteAd(Map<String, dynamic> ad) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text('जाहिरात हटवायची?'),
        content: Text('"${ad['title']}" हटवली जाईल.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('रद्द'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() => _ads.remove(ad));
              Navigator.pop(dialogContext);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('🗑️ जाहिरात हटवली.'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text(
              'हटवा',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(Map<String, dynamic> ad) {
    final statusColor = _statusColor(ad['status']);

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  ad['title'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: AppColors.textDark,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  ad['status'],
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '🏪 ${ad['owner']} (${ad['role']})',
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textLight,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '🏢 Franchise: ${ad['franchise']}',
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textLight,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                '💰 ${ad['budget']}',
                style: const TextStyle(fontSize: 13),
              ),
              const SizedBox(width: 16),
              Text(
                '📅 ${ad['days']}',
                style: const TextStyle(fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (ad['status'] == 'प्रतीक्षेत')
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _previewAd(ad),
                    icon: const Icon(
                      Icons.visibility,
                      size: 16,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Preview',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () => _editAd(ad),
                  icon: const Icon(
                    Icons.edit_outlined,
                    color: AppColors.primaryBlue,
                  ),
                  tooltip: 'Edit',
                ),
              ],
            )
          else
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _previewAd(ad),
                    icon: const Icon(Icons.visibility, size: 16),
                    label: const Text('Preview'),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () => _editAd(ad),
                  icon: const Icon(
                    Icons.edit_outlined,
                    color: AppColors.primaryBlue,
                  ),
                  tooltip: 'Edit',
                ),
                IconButton(
                  onPressed: () => _deleteAd(ad),
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  ),
                  tooltip: 'Delete',
                ),
              ],
            ),
          if (ad['status'] == 'नाकारले')
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                'कारण: ${ad['rejectReason']}',
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _section(String title, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.lightGrey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryBlue,
            ),
          ),
          const SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textLight,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _editField(
    String label,
    TextEditingController ctrl, {
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: ctrl,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          isDense: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ads = _selectedAds;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        title: const Text(
          'जाहिरात विभाग',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            tooltip: 'नवीन जाहिरात',
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CpCreateAdScreen(),
                ),
              );

              if (mounted) setState(() {});
            },
            icon: const Icon(Icons.add_circle_outline),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            color: AppColors.primaryBlue,
            child: Row(
              children: [
                _tabButton('Live', _liveAds.length, 0),
                _tabButton('Pending', _pendingAds.length, 1),
                _tabButton('Rejected', _rejectedAds.length, 2),
              ],
            ),
          ),
        ),
      ),
      body: ads.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.campaign_outlined,
                    size: 48,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _selectedTab == 0
                        ? 'कोणतीही Live जाहिरात नाही'
                        : _selectedTab == 1
                            ? 'कोणतीही Pending जाहिरात नाही'
                            : 'कोणतीही Rejected जाहिरात नाही',
                    style: const TextStyle(
                      color: AppColors.textLight,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: ads.length,
              itemBuilder: (context, index) => _buildCard(ads[index]),
            ),
    );
  }

  Widget _tabButton(String title, int count, int index) {
    final isSelected = _selectedTab == index;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 13),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? AppColors.cyan : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Text(
            '$title ($count)',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white60,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
