import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'franchise_create_ad_screen.dart';

class FranchiseAdScreen extends StatefulWidget {
  const FranchiseAdScreen({super.key});

  @override
  State<FranchiseAdScreen> createState() => _FranchiseAdScreenState();
}

class _FranchiseAdScreenState extends State<FranchiseAdScreen> {
  int _selectedTab = 0;

  final List<Map<String, dynamic>> _ads = [
    {
      'seller': 'गणेश किराणा मार्ट', 'role': 'Seller',
      'title': 'दिवाळी Sale — 20% सूट',
      'description': 'दिवाळीनिमित्त सर्व किराणा वस्तूंवर 20% सूट. ऑफर 7 दिवसांसाठी.',
      'budget': '₹500', 'days': '7 दिवस', 'status': 'प्रतीक्षेत',
      'targetArea': 'पुणे जिल्हा', 'targetAge': '18-45', 'targetGender': 'सर्व',
      'image': null,
    },
    {
      'seller': 'राज इलेक्ट्रॉनिक्स', 'role': 'Promoter',
      'title': 'नवीन Mobile Accessories',
      'description': 'नवीन मोबाईल ऍक्सेसरीज उपलब्ध. 10% सूट.',
      'budget': '₹300', 'days': '5 दिवस', 'status': 'प्रतीक्षेत',
      'targetArea': 'हडपसर', 'targetAge': '18-35', 'targetGender': 'सर्व',
      'image': null,
    },
    {
      'seller': 'श्री मेडिकल', 'role': 'Seller',
      'title': 'Generic Medicines उपलब्ध',
      'description': 'सर्व जेनेरिक औषधे उपलब्ध. 5% सूट.',
      'budget': '₹200', 'days': '3 दिवस', 'status': 'मंजूर',
      'targetArea': 'कोथरूड', 'targetAge': 'सर्व', 'targetGender': 'सर्व',
      'image': null,
    },
    {
      'seller': 'हडपसर फ्रँचाइजी', 'role': 'Franchise',
      'title': 'हडपसर स्पेशल ऑफर',
      'description': 'हडपसर भागातील ग्राहकांसाठी खास ऑफर.',
      'budget': '₹400', 'days': '10 दिवस', 'status': 'मंजूर',
      'targetArea': 'हडपसर', 'targetAge': '18-45', 'targetGender': 'सर्व',
      'image': null,
    },
  ];

  List<Map<String, dynamic>> get _pendingAds =>
      _ads.where((a) => a['status'] == 'प्रतीक्षेत').toList();
  List<Map<String, dynamic>> get _liveAds =>
      _ads.where((a) => a['status'] == 'मंजूर').toList();

  Color _statusColor(String s) {
    switch (s) {
      case 'प्रतीक्षेत': return Colors.orange;
      case 'मंजूर': return Colors.green;
      case 'नाकारले': return Colors.red;
      default: return Colors.grey;
    }
  }

  // === संपूर्ण जाहिरात Preview ===
  void _previewAd(Map<String, dynamic> ad) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => DraggableScrollableSheet(
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
                  const Icon(Icons.visibility, color: AppColors.primaryBlue),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text('जाहिरात Preview', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, color: AppColors.primaryBlue),
                    tooltip: 'Edit',
                    onPressed: () {
                      Navigator.pop(ctx);
                      _editAd(ad);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(ctx),
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
                  // जाहिरात कशी दिसते
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.primaryBlue, AppColors.royalBlue],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
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
                              ? ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.file(ad['image'], fit: BoxFit.cover))
                              : const Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.image, color: Colors.white70, size: 50),
                                      SizedBox(height: 8),
                                      Text('जाहिरात फोटो', style: TextStyle(color: Colors.white70, fontSize: 12)),
                                    ],
                                  ),
                                ),
                        ),
                        const SizedBox(height: 12),
                        Text(ad['title'], style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text(ad['description'], style: const TextStyle(color: Colors.white, fontSize: 13)),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Icons.storefront, color: Colors.white70, size: 14),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                '${ad['seller']} (${ad['role']})',
                                style: const TextStyle(color: Colors.white70, fontSize: 12),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Icon(Icons.calendar_today, color: Colors.white70, size: 14),
                            const SizedBox(width: 4),
                            Text(ad['days'], style: const TextStyle(color: Colors.white70, fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  _section('जाहिरात तपशील', [
                    _infoRow('शीर्षक', ad['title']),
                    _infoRow('वर्णन', ad['description']),
                    _infoRow('कोणी टाकली', '${ad['seller']} (${ad['role']})'),
                    _infoRow('Budget', ad['budget']),
                    _infoRow('कालावधी', ad['days']),
                  ]),

                  _section('🎯 टार्गेटिंग', [
                    _infoRow('क्षेत्र', ad['targetArea']),
                    _infoRow('वयोगट', ad['targetAge']),
                    _infoRow('लिंग', ad['targetGender']),
                  ]),

                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _statusColor(ad['status']).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: _statusColor(ad['status'])),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, color: _statusColor(ad['status'])),
                        const SizedBox(width: 8),
                        Text('स्थिती: ${ad['status']}', style: TextStyle(color: _statusColor(ad['status']), fontWeight: FontWeight.bold)),
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
                          setState(() => ad['status'] = 'नाकारले');
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('❌ जाहिरात नाकारली'), backgroundColor: Colors.red),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          side: const BorderSide(color: Colors.red),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          minimumSize: const Size(0, 44),
                        ),
                        child: const Text('❌ नाकारा'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() => ad['status'] = 'मंजूर');
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('✅ जाहिरात मंजूर झाली — Live'), backgroundColor: AppColors.successGreen),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.successGreen,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          minimumSize: const Size(0, 44),
                        ),
                        child: const Text('✅ मंजूर करा', style: TextStyle(color: Colors.white)),
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

  // === जाहिरात Edit ===
  void _editAd(Map<String, dynamic> ad) {
    final titleCtrl = TextEditingController(text: ad['title']);
    final descCtrl = TextEditingController(text: ad['description']);
    final budgetCtrl = TextEditingController(text: ad['budget']);
    final daysCtrl = TextEditingController(text: ad['days']);
    final areaCtrl = TextEditingController(text: ad['targetArea']);
    final ageCtrl = TextEditingController(text: ad['targetAge']);
    final genderCtrl = TextEditingController(text: ad['targetGender']);

    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: Container(
          constraints: const BoxConstraints(maxHeight: 600),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('जाहिरात Edit करा', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
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
                  Expanded(child: TextButton(onPressed: () => Navigator.pop(context), child: const Text('रद्द'))),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          ad['title'] = titleCtrl.text;
                          ad['description'] = descCtrl.text;
                          ad['budget'] = budgetCtrl.text;
                          ad['days'] = daysCtrl.text;
                          ad['targetArea'] = areaCtrl.text;
                          ad['targetAge'] = ageCtrl.text;
                          ad['targetGender'] = genderCtrl.text;
                        });
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('✅ जाहिरात अद्ययावत झाली'), backgroundColor: AppColors.successGreen),
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
  }

  void _deleteAd(Map<String, dynamic> ad) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('जाहिरात हटवायची?'),
        content: Text('"${ad['title']}" कायमची हटवली जाईल.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('रद्द')),
          ElevatedButton(
            onPressed: () {
              setState(() => _ads.remove(ad));
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('🗑️ जाहिरात हटवली'), backgroundColor: Colors.red),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('हटवा', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(Map<String, dynamic> ad, {required bool isPending}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(ad['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.textDark))),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: _statusColor(ad['status']).withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                child: Text(ad['status'], style: TextStyle(color: _statusColor(ad['status']), fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text('🏪 ${ad['seller']} (${ad['role']})', style: const TextStyle(fontSize: 13, color: AppColors.textLight)),
          const SizedBox(height: 4),
          Row(children: [
            Text('💰 ${ad['budget']}', style: const TextStyle(fontSize: 13, color: AppColors.textDark)),
            const SizedBox(width: 16),
            Text('📅 ${ad['days']}', style: const TextStyle(fontSize: 13, color: AppColors.textDark)),
            const SizedBox(width: 16),
            Expanded(child: Text('🎯 ${ad['targetArea']}', style: const TextStyle(fontSize: 13, color: AppColors.textLight), overflow: TextOverflow.ellipsis)),
          ]),
          const SizedBox(height: 12),
          Row(
            children: [
              if (isPending)
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _previewAd(ad),
                    icon: const Icon(Icons.visibility, size: 16, color: Colors.white),
                    label: const Text('Preview', style: TextStyle(color: Colors.white, fontSize: 12)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      minimumSize: const Size(0, 36),
                    ),
                  ),
                )
              else
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _editAd(ad),
                    icon: const Icon(Icons.edit, size: 16, color: Colors.white),
                    label: const Text('Edit', style: TextStyle(color: Colors.white, fontSize: 12)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      minimumSize: const Size(0, 36),
                    ),
                  ),
                ),
              const SizedBox(width: 6),
              IconButton(
                icon: const Icon(Icons.edit_outlined, size: 20, color: AppColors.primaryBlue),
                onPressed: () => _editAd(ad),
                tooltip: 'Edit',
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, size: 20, color: Colors.red),
                onPressed: () => _deleteAd(ad),
                tooltip: 'Delete',
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ads = _selectedTab == 0 ? _pendingAds : _liveAds;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        title: const Text('जाहिरात विभाग', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          TextButton.icon(
            onPressed: () async {
              await Navigator.push(context, MaterialPageRoute(builder: (_) => const FranchiseCreateAdScreen()));
              if (mounted) setState(() {});
            },
            icon: const Icon(Icons.add_circle_outline, color: Colors.white, size: 20),
            label: const Text(
              '+ नवीन जाहिरात बनवा',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ),
          const SizedBox(width: 8),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(46),
          child: Container(
            color: AppColors.primaryBlue,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedTab = 0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: _selectedTab == 0 ? AppColors.cyan : Colors.transparent, width: 3)),
                      ),
                      child: Text(
                        'Approval Pending (${_pendingAds.length})',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _selectedTab == 0 ? Colors.white : Colors.white60,
                          fontWeight: _selectedTab == 0 ? FontWeight.bold : FontWeight.normal,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedTab = 1),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: _selectedTab == 1 ? AppColors.cyan : Colors.transparent, width: 3)),
                      ),
                      child: Text(
                        'Live जाहिराती (${_liveAds.length})',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _selectedTab == 1 ? Colors.white : Colors.white60,
                          fontWeight: _selectedTab == 1 ? FontWeight.bold : FontWeight.normal,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: ads.isEmpty
          ? Center(
              child: Text(
                _selectedTab == 0 ? 'कोणतीही पेंडिंग जाहिरात नाही' : 'कोणतीही Live जाहिरात नाही',
                style: const TextStyle(color: AppColors.textLight),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: ads.length,
              itemBuilder: (context, index) => _buildCard(ads[index], isPending: _selectedTab == 0),
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
          Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
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
        children: [
          Text('$label: ', style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark))),
        ],
      ),
    );
  }

  Widget _editField(String label, TextEditingController ctrl, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: ctrl,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          isDense: true,
        ),
      ),
    );
  }
}