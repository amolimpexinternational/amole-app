import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class FranchiseAdScreen extends StatefulWidget {
  const FranchiseAdScreen({super.key});

  @override
  State<FranchiseAdScreen> createState() => _FranchiseAdScreenState();
}

class _FranchiseAdScreenState extends State<FranchiseAdScreen> {
  final List<Map<String, dynamic>> _ads = [
    {
      'seller': 'गणेश किराणा मार्ट', 'title': 'दिवाळी Sale — 20% सूट',
      'description': 'दिवाळीनिमित्त सर्व किराणा वस्तूंवर 20% सूट. ऑफर 7 दिवसांसाठी.',
      'budget': '₹500', 'days': '7 दिवस', 'status': 'प्रतीक्षेत',
      'targetArea': 'पुणे जिल्हा', 'targetAge': '18-45', 'targetGender': 'सर्व',
      'image': null,
    },
    {
      'seller': 'राज इलेक्ट्रॉनिक्स', 'title': 'नवीन Mobile Accessories',
      'description': 'नवीन मोबाईल ऍक्सेसरीज उपलब्ध. 10% सूट.',
      'budget': '₹300', 'days': '5 दिवस', 'status': 'प्रतीक्षेत',
      'targetArea': 'हडपसर', 'targetAge': '18-35', 'targetGender': 'सर्व',
      'image': null,
    },
    {
      'seller': 'श्री मेडिकल', 'title': 'Generic Medicines उपलब्ध',
      'description': 'सर्व जेनेरिक औषधे उपलब्ध. 5% सूट.',
      'budget': '₹200', 'days': '3 दिवस', 'status': 'मंजूर',
      'targetArea': 'कोथरूड', 'targetAge': 'सर्व', 'targetGender': 'सर्व',
      'image': null,
    },
    {
      'seller': 'प्रिया फॅशन', 'title': 'नवीन Collection आले',
      'description': 'नवीन कलेक्शन आले आहे. 15% सूट.',
      'budget': '₹400', 'days': '10 दिवस', 'status': 'नाकारले',
      'targetArea': 'पुणे जिल्हा', 'targetAge': '18-45', 'targetGender': 'स्त्री',
      'image': null,
    },
  ];

  Color _statusColor(String s) {
    switch (s) {
      case 'प्रतीक्षेत': return Colors.orange;
      case 'मंजूर': return Colors.green;
      case 'नाकारले': return Colors.red;
      default: return Colors.grey;
    }
  }

  // === संपूर्ण जाहिरात Preview ===
  void _previewAd(int index) {
    final ad = _ads[index];
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (ctx, scrollCtrl) => Column(
          children: [
            // === Header ===
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
                      _editAd(index);
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
                  // === जाहिरात कशी दिसते (Ad Preview) ===
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
                            Text(ad['seller'], style: const TextStyle(color: Colors.white70, fontSize: 12)),
                            const SizedBox(width: 12),
                            const Icon(Icons.calendar_today, color: Colors.white70, size: 14),
                            const SizedBox(width: 4),
                            Text(ad['days'], style: const TextStyle(color: Colors.white70, fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // === जाहिरात तपशील ===
                  _section('जाहिरात तपशील', [
                    _infoRow('शीर्षक', ad['title']),
                    _infoRow('वर्णन', ad['description']),
                    _infoRow('Budget', ad['budget']),
                    _infoRow('कालावधी', ad['days']),
                  ]),

                  // === टार्गेटिंग ===
                  _section('🎯 टार्गेटिंग', [
                    _infoRow('क्षेत्र', ad['targetArea']),
                    _infoRow('वयोगट', ad['targetAge']),
                    _infoRow('लिंग', ad['targetGender']),
                  ]),

                  // === स्थिती ===
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

            // === Approve/Reject ===
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
                            const SnackBar(content: Text('✅ जाहिरात मंजूर झाली'), backgroundColor: AppColors.successGreen),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.successGreen,
                          padding: const EdgeInsets.symmetric(vertical: 14),
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

  // === संपूर्ण जाहिरात Edit ===
  void _editAd(int index) {
    final ad = _ads[index];
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

  void _deleteAd(int index) {
    setState(() => _ads.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        title: const Text('Ad Approvals', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: _ads.isEmpty
          ? const Center(child: Text('कोणतीही जाहिरात नाही'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _ads.length,
              itemBuilder: (context, index) {
                final ad = _ads[index];
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
                      Text('🏪 ${ad['seller']}', style: const TextStyle(fontSize: 13, color: AppColors.textLight)),
                      const SizedBox(height: 4),
                      Row(children: [
                        Text('💰 ${ad['budget']}', style: const TextStyle(fontSize: 13, color: AppColors.textDark)),
                        const SizedBox(width: 16),
                        Text('📅 ${ad['days']}', style: const TextStyle(fontSize: 13, color: AppColors.textDark)),
                      ]),
                      const SizedBox(height: 12),
                      // === ३ बटनं: Preview / Edit / Delete ===
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () => _previewAd(index),
                              icon: const Icon(Icons.visibility, size: 16, color: Colors.white),
                              label: const Text('Preview', style: TextStyle(color: Colors.white, fontSize: 12)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryBlue,
                                padding: const EdgeInsets.symmetric(vertical: 8),
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          IconButton(
                            icon: const Icon(Icons.edit_outlined, size: 20, color: AppColors.primaryBlue),
                            onPressed: () => _editAd(index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_outline, size: 20, color: Colors.red),
                            onPressed: () => _deleteAd(index),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
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
