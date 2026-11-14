import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class CpApprovalsScreen extends StatelessWidget {
  const CpApprovalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.lightGrey,
        appBar: AppBar(
          backgroundColor: AppColors.primaryBlue,
          title: const Text('Pending Approvals', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold)),
          iconTheme: const IconThemeData(color: AppColors.white),
          bottom: const TabBar(
            indicatorColor: AppColors.white,
            labelColor: AppColors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: 'पेंडिंग जाहिराती'),
              Tab(text: 'पेंडिंग ऑफर्स'),
              Tab(text: 'New On-boarding'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _AdsApprovalTab(),
            _OffersApprovalTab(),
            _OnboardingApprovalTab(),
          ],
        ),
      ),
    );
  }
}

// ==================== टॅब १ — पेंडिंग जाहिराती ====================
class _AdsApprovalTab extends StatelessWidget {
  const _AdsApprovalTab();

  final List<Map<String, dynamic>> franchiseGroups = const [
    {
      'franchise': 'हडपसर फ्रँचाइजी', 'phone': '+91 9876543210', 'pendingCount': 2,
      'ads': [
        {'title': 'पाटील किराणा स्टोअर — Photo Ad', 'sender': 'पाटील किराणा स्टोअर', 'senderPhone': '+91 9988776655', 'senderType': 'Seller', 'days': '3 दिवसांपूर्वी', 'budget': '₹300', 'fee': '₹300', 'isPaid': true},
        {'title': 'जोशी किराणा — Text Ad', 'sender': 'जोशी किराणा', 'senderPhone': '+91 9988776656', 'senderType': 'Seller', 'days': '2 दिवसांपूर्वी', 'budget': '₹200', 'fee': '₹200', 'isPaid': true},
      ],
    },
    {
      'franchise': 'कोथरूड फ्रँचाइजी', 'phone': '+91 9876543211', 'pendingCount': 1,
      'ads': [
        {'title': 'श्री साई मेडिकल — Text Ad', 'sender': 'श्री साई मेडिकल', 'senderPhone': '+91 9988776657', 'senderType': 'Seller', 'days': '1 दिवसापूर्वी', 'budget': '₹150', 'fee': '₹150', 'isPaid': true},
      ],
    },
    {'franchise': 'वडगाव फ्रँचाइजी', 'phone': '+91 9876543212', 'pendingCount': 0, 'ads': []},
  ];

  @override
  Widget build(BuildContext context) {
    final totalPending = franchiseGroups.fold<int>(0, (sum, g) => sum + (g['pendingCount'] as int));

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.orange.shade200)),
          child: Row(children: [
            Icon(Icons.pending_actions, color: Colors.orange.shade700, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('एकूण $totalPending जाहिराती अप्रूव्हलसाठी प्रतीक्षेत', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.orange.shade900)),
                Text('${franchiseGroups.where((g) => (g['pendingCount'] as int) > 0).length} फ्रँचायझींकडून', style: TextStyle(fontSize: 12, color: Colors.orange.shade700)),
              ]),
            ),
          ]),
        ),
        ...franchiseGroups.map((group) {
          final count = group['pendingCount'] as int;
          final ads = group['ads'] as List;
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: count > 0 ? Colors.orange.shade200 : Colors.grey.shade200), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6)]),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: count > 0 ? Colors.orange.shade50 : Colors.grey.shade50, borderRadius: const BorderRadius.vertical(top: Radius.circular(14))),
                child: Row(children: [
                  Icon(Icons.business, color: count > 0 ? Colors.orange.shade700 : Colors.grey, size: 22),
                  const SizedBox(width: 10),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(group['franchise'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.textDark)),
                    Row(children: [
                      const Icon(Icons.phone, size: 12, color: AppColors.primaryBlue),
                      const SizedBox(width: 4),
                      Text(group['phone'] as String, style: const TextStyle(fontSize: 12, color: AppColors.primaryBlue, fontWeight: FontWeight.w600)),
                    ]),
                  ])),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: count > 0 ? Colors.orange : Colors.green, borderRadius: BorderRadius.circular(12)),
                    child: Text('$count पेंडिंग', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ]),
              ),
              if (ads.isEmpty)
                const Padding(padding: EdgeInsets.all(14), child: Text('कोणतेही पेंडिंग नाही', style: TextStyle(fontSize: 12, color: AppColors.textLight)))
              else
                ...ads.map<Widget>((ad) => _adRow(context, ad as Map<String, dynamic>)),
            ]),
          );
        }),
      ],
    );
  }

  Widget _adRow(BuildContext context, Map<String, dynamic> ad) {
    return GestureDetector(
      onTap: () => _showAdPreview(context, ad),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey.shade200))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            const Icon(Icons.campaign_outlined, color: AppColors.primaryBlue, size: 18),
            const SizedBox(width: 8),
            Expanded(child: Text(ad['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.textDark))),
            const Icon(Icons.chevron_right, color: AppColors.textLight, size: 18),
          ]),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(6)),
            child: Row(children: [
              const Icon(Icons.person, size: 14, color: Colors.blue),
              const SizedBox(width: 6),
              Expanded(child: Text('${ad['sender']} (${ad['senderType']})', style: const TextStyle(fontSize: 11, color: Colors.blue, fontWeight: FontWeight.w600))),
              const Icon(Icons.phone, size: 12, color: Colors.blue),
              const SizedBox(width: 2),
              Text(ad['senderPhone'], style: const TextStyle(fontSize: 11, color: Colors.blue, fontWeight: FontWeight.bold)),
            ]),
          ),
          const SizedBox(height: 6),
          Row(children: [
            Text('${ad['days']} • बजेट: ${ad['budget']}', style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(color: ad['isPaid'] == true ? Colors.purple.shade50 : Colors.green.shade50, borderRadius: BorderRadius.circular(6)),
              child: Text('फी: ${ad['fee']}', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: ad['isPaid'] == true ? Colors.purple : Colors.green)),
            ),
          ]),
        ]),
      ),
    );
  }

  void _showAdPreview(BuildContext context, Map<String, dynamic> ad) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (ctx, scrollCtrl) => Column(children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(children: [
              const Icon(Icons.visibility, color: AppColors.primaryBlue),
              const SizedBox(width: 8),
              const Expanded(child: Text('जाहिरात Preview', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
              IconButton(icon: const Icon(Icons.edit, color: AppColors.primaryBlue), onPressed: () { Navigator.pop(ctx); _editAd(context, ad); }),
              IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx)),
            ]),
          ),
          const Divider(height: 1),
          Expanded(child: ListView(controller: scrollCtrl, padding: const EdgeInsets.all(16), children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(gradient: LinearGradient(colors: [AppColors.primaryBlue, AppColors.royalBlue]), borderRadius: BorderRadius.circular(14)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(height: 140, decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(10)), child: const Center(child: Icon(Icons.image, color: Colors.white70, size: 50))),
                const SizedBox(height: 12),
                Text(ad['title'], style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('${ad['sender']} · ${ad['days']}', style: const TextStyle(color: Colors.white70, fontSize: 12)),
              ]),
            ),
            const SizedBox(height: 16),
            _infoRow('पाठवणारा', '${ad['sender']} (${ad['senderType']})'),
            _infoRow('फोन', ad['senderPhone']),
            _infoRow('बजेट', ad['budget']),
            _infoRow('फी', ad['fee']),
            _infoRow('कालावधी', ad['days']),
          ])),
          if (ad['status'] == null || ad['status'] == 'pending')
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(children: [
                Expanded(child: OutlinedButton(
                  onPressed: () { ad['status'] = 'rejected'; Navigator.pop(ctx); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('❌ नाकारली'), backgroundColor: Colors.red)); },
                  style: OutlinedButton.styleFrom(foregroundColor: Colors.red, side: const BorderSide(color: Colors.red), padding: const EdgeInsets.symmetric(vertical: 14)),
                  child: const Text('❌ नाकारा'),
                )),
                const SizedBox(width: 12),
                Expanded(child: ElevatedButton(
                  onPressed: () { ad['status'] = 'approved'; Navigator.pop(ctx); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('✅ मंजूर'), backgroundColor: AppColors.successGreen)); },
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.successGreen, padding: const EdgeInsets.symmetric(vertical: 14)),
                  child: const Text('✅ मंजूर', style: TextStyle(color: Colors.white)),
                )),
              ]),
            ),
        ]),
      ),
    );
  }

  void _editAd(BuildContext context, Map<String, dynamic> ad) {
    final titleCtrl = TextEditingController(text: ad['title']);
    final feeCtrl = TextEditingController(text: ad['fee']);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('जाहिरात Edit करा'),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(controller: titleCtrl, decoration: const InputDecoration(labelText: 'शीर्षक')),
          const SizedBox(height: 10),
          TextField(controller: feeCtrl, decoration: const InputDecoration(labelText: 'फी'), keyboardType: TextInputType.number),
        ]),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('रद्द')),
          ElevatedButton(onPressed: () { ad['title'] = titleCtrl.text; ad['fee'] = feeCtrl.text; Navigator.pop(context); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('✅ अद्ययावत'))); }, child: const Text('जतन')),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(padding: const EdgeInsets.only(bottom: 8), child: Row(children: [
      Text('$label: ', style: const TextStyle(fontSize: 13, color: AppColors.textLight)),
      Expanded(child: Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark))),
    ]));
  }
}

// ==================== टॅब २ — पेंडिंग ऑफर्स ====================
class _OffersApprovalTab extends StatelessWidget {
  const _OffersApprovalTab();

  final List<Map<String, dynamic>> _offers = const [
    {'title': 'दिवाळी 20% सूट', 'seller': 'श्री गणेश किराणा', 'type': 'Seller', 'isPaid': false, 'fee': '₹0', 'validity': '7 दिवस', 'desc': 'दिवाळीनिमित्त 20% सूट', 'under': 'हडपसर फ्रँचाइजी'},
    {'title': 'मोबाईल 10% सूट', 'seller': 'राज इलेक्ट्रॉनिक्स', 'type': 'Seller', 'isPaid': true, 'fee': '₹500', 'validity': '10 दिवस', 'desc': 'नवीन मोबाईलवर 10% सूट', 'under': 'हडपसर फ्रँचाइजी'},
    {'title': 'थाळी ₹99', 'seller': 'स्वाद हॉटेल', 'type': 'Seller', 'isPaid': false, 'fee': '₹0', 'validity': '5 दिवस', 'desc': 'स्पेशल थाळी ₹99', 'under': 'कोथरूड फ्रँचाइजी'},
  ];

  @override
  Widget build(BuildContext context) {
    final freeCount = _offers.where((o) => o['isPaid'] == false).length;
    final paidCount = _offers.where((o) => o['isPaid'] == true).length;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.purple.shade200)),
          child: Row(children: [
            Icon(Icons.local_offer, color: Colors.purple.shade700, size: 28),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('एकूण ${_offers.length} ऑफर्स प्रतीक्षेत', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.purple.shade900)),
              Text('$freeCount फ्री • $paidCount पेड', style: TextStyle(fontSize: 12, color: Colors.purple.shade700)),
            ])),
          ]),
        ),
        ..._offers.map((o) => _offerCard(context, o)),
      ],
    );
  }

  Widget _offerCard(BuildContext context, Map<String, dynamic> o) {
    final isPaid = o['isPaid'] == true;
    return GestureDetector(
      onTap: () => _showOfferDetail(context, o),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: isPaid ? Colors.purple.shade200 : Colors.green.shade200), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6)]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(color: isPaid ? Colors.purple.shade50 : Colors.green.shade50, borderRadius: BorderRadius.circular(6)),
              child: Text(isPaid ? 'पेड' : 'फ्री', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: isPaid ? Colors.purple : Colors.green)),
            ),
            const SizedBox(width: 8),
            Expanded(child: Text(o['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textDark))),
            const Icon(Icons.chevron_right, color: AppColors.textLight, size: 18),
          ]),
          const SizedBox(height: 6),
          Text('${o['seller']} (${o['type']}) · ${o['under']}', style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
          const SizedBox(height: 4),
          Row(children: [
            Text('वैधता: ${o['validity']}', style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
            const Spacer(),
            if (isPaid) Text('फी: ${o['fee']}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.purple)),
          ]),
        ]),
      ),
    );
  }

  void _showOfferDetail(BuildContext context, Map<String, dynamic> o) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(o['title']),
        content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('विक्रेता: ${o['seller']} (${o['type']})'),
          Text('अंडर: ${o['under']}'),
          Text('वैधता: ${o['validity']}'),
          Text('फी: ${o['fee']}'),
          const Divider(),
          Text(o['desc']),
        ]),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('बंद')),
          ElevatedButton(onPressed: () { Navigator.pop(context); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('✅ मंजूर'), backgroundColor: AppColors.successGreen)); }, child: const Text('मंजूर')),
        ],
      ),
    );
  }
}

// ==================== टॅब ३ — New On-boarding ====================
class _OnboardingApprovalTab extends StatelessWidget {
  const _OnboardingApprovalTab();

  final List<Map<String, dynamic>> _requests = const [
    {'title': 'न्यू फॅशन पॉईंट', 'type': 'Seller', 'phone': '+91 9988776655', 'days': '1 दिवसापूर्वी', 'under': 'हडपसर फ्रँचाइजी', 'owner': 'राजेश पाटील', 'aadhar': '1234 5678 9012', 'pan': 'ABCDE1234F', 'bank': 'SBI - 123456789012', 'address': 'गल्ली 4, हडपसर, पुणे'},
    {'title': 'जोशी किराणा', 'type': 'Seller', 'phone': '+91 9988776656', 'days': '2 दिवसांपूर्वी', 'under': 'हडपसर फ्रँचाइजी', 'owner': 'जोशी', 'aadhar': '2345 6789 0123', 'pan': 'FGHIJ5678K', 'bank': 'HDFC - 234567890123', 'address': 'मुख्य रस्ता, हडपसर, पुणे'},
    {'title': 'श्री साई मेडिकल', 'type': 'Seller', 'phone': '+91 9988776657', 'days': '4 दिवसांपूर्वी', 'under': 'कोथरूड फ्रँचाइजी', 'owner': 'साई', 'aadhar': '3456 7890 1234', 'pan': 'KLMNO9012P', 'bank': 'ICICI - 345678901234', 'address': 'मार्केट, कोथरूड, पुणे'},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.blue.shade200)),
          child: Row(children: [
            Icon(Icons.person_add_alt_1, color: Colors.blue.shade700, size: 28),
            const SizedBox(width: 12),
            Expanded(child: Text('एकूण ${_requests.length} On-boarding विनंत्या प्रतीक्षेत', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue.shade900))),
          ]),
        ),
        ..._requests.map((req) => _requestCard(context, req)),
      ],
    );
  }

  Widget _requestCard(BuildContext context, Map<String, dynamic> req) {
    return GestureDetector(
      onTap: () => _showKycDetail(context, req),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.blue.shade200), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6)]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            const Icon(Icons.storefront_outlined, color: Colors.teal, size: 18),
            const SizedBox(width: 8),
            Expanded(child: Text(req['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textDark))),
            const Icon(Icons.chevron_right, color: AppColors.textLight, size: 18),
          ]),
          const SizedBox(height: 6),
          Text('${req['type']} · ${req['under']} · ${req['days']}', style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(6)),
            child: Row(children: [
              const Icon(Icons.phone, size: 14, color: Colors.teal),
              const SizedBox(width: 6),
              Text(req['phone'], style: const TextStyle(fontSize: 11, color: Colors.teal, fontWeight: FontWeight.bold)),
            ]),
          ),
        ]),
      ),
    );
  }

  void _showKycDetail(BuildContext context, Map<String, dynamic> req) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        expand: false,
        builder: (ctx, scrollCtrl) => Column(children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(children: [
              const Icon(Icons.person, color: AppColors.primaryBlue),
              const SizedBox(width: 8),
              Expanded(child: Text(req['title'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
              IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx)),
            ]),
          ),
          const Divider(height: 1),
          Expanded(child: ListView(controller: scrollCtrl, padding: const EdgeInsets.all(16), children: [
            _info('मालक', req['owner']),
            _info('फोन', req['phone']),
            _info('आधार', req['aadhar']),
            _info('पॅन', req['pan']),
            _info('बँक', req['bank']),
            _info('पत्ता', req['address']),
            _info('अंडर', req['under']),
            _info('अर्ज', req['days']),
          ])),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(children: [
              Expanded(child: OutlinedButton(onPressed: () => Navigator.pop(ctx), style: OutlinedButton.styleFrom(foregroundColor: Colors.red, side: const BorderSide(color: Colors.red), padding: const EdgeInsets.symmetric(vertical: 14)), child: const Text('नाकारा'))),
              const SizedBox(width: 12),
              Expanded(child: ElevatedButton(onPressed: () { Navigator.pop(ctx); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('✅ मंजूर'), backgroundColor: AppColors.successGreen)); }, style: ElevatedButton.styleFrom(backgroundColor: AppColors.successGreen, padding: const EdgeInsets.symmetric(vertical: 14)), child: const Text('मंजूर', style: TextStyle(color: Colors.white)))),
            ]),
          ),
        ]),
      ),
    );
  }

  Widget _info(String label, String value) {
    return Padding(padding: const EdgeInsets.only(bottom: 8), child: Row(children: [
      Text('$label: ', style: const TextStyle(fontSize: 13, color: AppColors.textLight)),
      Expanded(child: Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark))),
    ]));
  }
}
