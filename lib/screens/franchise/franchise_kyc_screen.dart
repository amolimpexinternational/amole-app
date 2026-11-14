import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class FranchiseKycScreen extends StatefulWidget {
  const FranchiseKycScreen({super.key});

  @override
  State<FranchiseKycScreen> createState() => _FranchiseKycScreenState();
}

class _FranchiseKycScreenState extends State<FranchiseKycScreen> {
  String _selectedTab = 'प्रतीक्षेत';

  final List<Map<String, dynamic>> _sellers = [
    {
      'name': 'रमेश किराणा मार्ट', 'owner': 'रमेश पाटील', 'category': 'किराणा',
      'phone': '9876543210', 'altPhone': '9876543211', 'days': '2 दिवसांपूर्वी',
      'status': 'प्रतीक्षेत', 'pincode': '411001',
      'address': 'गल्ली नं. ४, हडपसर, पुणे', 'mapsLink': 'https://maps.app.goo.gl/abc',
      'aadhar': '1234 5678 9012', 'pan': 'ABCDE1234F', 'vehicle': '-', 'license': '-',
      'bankName': 'SBI', 'bankAcc': '123456789012', 'ifsc': 'SBIN0001234',
    },
    {
      'name': 'सुनील मेडिकल', 'owner': 'सुनील कदम', 'category': 'मेडिकल',
      'phone': '9765432109', 'altPhone': '-', 'days': '4 दिवसांपूर्वी',
      'status': 'प्रतीक्षेत', 'pincode': '411002',
      'address': 'मुख्य रस्ता, कोथरूड, पुणे', 'mapsLink': 'https://maps.app.goo.gl/def',
      'aadhar': '2345 6789 0123', 'pan': 'FGHIJ5678K', 'vehicle': '-', 'license': '-',
      'bankName': 'HDFC', 'bankAcc': '234567890123', 'ifsc': 'HDFC0001234',
    },
    {
      'name': 'प्रिया फॅशन', 'owner': 'प्रिया देशमुख', 'category': 'कपडे',
      'phone': '9654321098', 'altPhone': '-', 'days': '6 दिवसांपूर्वी',
      'status': 'प्रतीक्षेत', 'pincode': '411003',
      'address': 'शॉपिंग सेंटर, वडगाव, पुणे', 'mapsLink': 'https://maps.app.goo.gl/ghi',
      'aadhar': '3456 7890 1234', 'pan': 'KLMNO9012P', 'vehicle': '-', 'license': '-',
      'bankName': 'ICICI', 'bankAcc': '345678901234', 'ifsc': 'ICIC0001234',
    },
    {
      'name': 'गणेश इलेक्ट्रॉनिक्स', 'owner': 'गणेश शिंदे', 'category': 'इलेक्ट्रॉनिक',
      'phone': '9543210987', 'altPhone': '-', 'days': '3 दिवसांपूर्वी',
      'status': 'मंजूर', 'pincode': '411004',
      'address': 'मार्केट यार्ड, पुणे', 'mapsLink': 'https://maps.app.goo.gl/jkl',
      'aadhar': '4567 8901 2345', 'pan': 'PQRST3456U', 'vehicle': '-', 'license': '-',
      'bankName': 'Axis', 'bankAcc': '456789012345', 'ifsc': 'UTIB0001234',
    },
    {
      'name': 'साई बेकरी', 'owner': 'साई जोशी', 'category': 'खाद्यपदार्थ',
      'phone': '9432109876', 'altPhone': '-', 'days': '5 दिवसांपूर्वी',
      'status': 'नाकारले', 'pincode': '411005',
      'address': 'बेकरी गल्ली, पुणे', 'mapsLink': 'https://maps.app.goo.gl/mno',
      'aadhar': '5678 9012 3456', 'pan': 'VWXYZ7890A', 'vehicle': '-', 'license': '-',
      'bankName': 'SBI', 'bankAcc': '567890123456', 'ifsc': 'SBIN0005678',
    },
  ];

  List<Map<String, dynamic>> get _filtered =>
      _sellers.where((s) => s['status'] == _selectedTab).toList();

  Color _statusColor(String status) {
    switch (status) {
      case 'प्रतीक्षेत': return Colors.orange;
      case 'मंजूर': return Colors.green;
      case 'नाकारले': return Colors.red;
      default: return Colors.grey;
    }
  }

  void _showKycDetail(Map<String, dynamic> seller) {
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
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(seller['name'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, color: AppColors.primaryBlue),
                    tooltip: 'KYC Edit',
                    onPressed: () {
                      Navigator.pop(ctx);
                      _editKyc(seller);
                    },
                  ),
                  IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx)),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView(
                controller: scrollCtrl,
                padding: const EdgeInsets.all(16),
                children: [
                  // === मूलभूत ===
                  _section('मूलभूत माहिती', [
                    _infoRow(Icons.storefront_outlined, 'दुकानाचे नाव', seller['name']),
                    _infoRow(Icons.person_outlined, 'मालक', seller['owner']),
                    _infoRow(Icons.category_outlined, 'श्रेणी', seller['category']),
                    _infoRow(Icons.phone_outlined, 'मोबाईल', seller['phone']),
                    _infoRow(Icons.phone_android_outlined, 'पर्यायी मोबाईल', seller['altPhone']),
                    _infoRow(Icons.location_on_outlined, 'पिनकोड', seller['pincode']),
                    _infoRow(Icons.home_outlined, 'पूर्ण पत्ता', seller['address']),
                    _infoRow(Icons.map_outlined, 'Google Maps Link', seller['mapsLink']),
                  ]),
                  // === KYC ===
                  _section('KYC माहिती', [
                    _infoRow(Icons.badge_outlined, 'आधार क्रमांक', seller['aadhar']),
                    _infoRow(Icons.credit_card_outlined, 'पॅन क्रमांक', seller['pan']),
                    _infoRow(Icons.directions_car_outlined, 'गाडी नंबर', seller['vehicle']),
                    _infoRow(Icons.drive_eta_outlined, 'लायसन नंबर', seller['license']),
                  ]),
                  // === बँक ===
                  _section('बँक माहिती', [
                    _infoRow(Icons.account_balance_outlined, 'बँकेचे नाव', seller['bankName']),
                    _infoRow(Icons.numbers_outlined, 'खाते क्रमांक', seller['bankAcc']),
                    _infoRow(Icons.qr_code_outlined, 'IFSC', seller['ifsc']),
                  ]),
                  // === फोटो (डमी) ===
                  _section('फोटो', [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _photoThumb('दुकानाचा फोटो', Icons.storefront),
                        _photoThumb('सेल्फी', Icons.person),
                      ],
                    ),
                  ]),
                  // === स्थिती ===
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _statusColor(seller['status']).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: _statusColor(seller['status'])),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.access_time, color: _statusColor(seller['status'])),
                        const SizedBox(width: 8),
                        Text('अर्ज: ${seller['days']}', style: TextStyle(color: _statusColor(seller['status']), fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (seller['status'] == 'प्रतीक्षेत')
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() => seller['status'] = 'नाकारले');
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('❌ KYC नाकारली'), backgroundColor: Colors.red),
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
                          setState(() => seller['status'] = 'मंजूर');
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('✅ KYC मंजूर झाली'), backgroundColor: AppColors.successGreen),
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

  void _editKyc(Map<String, dynamic> seller) {
    final nameCtrl = TextEditingController(text: seller['name']);
    final ownerCtrl = TextEditingController(text: seller['owner']);
    final mobileCtrl = TextEditingController(text: seller['phone']);
    final altMobileCtrl = TextEditingController(text: seller['altPhone']);
    final pincodeCtrl = TextEditingController(text: seller['pincode']);
    final addressCtrl = TextEditingController(text: seller['address']);
    final mapsCtrl = TextEditingController(text: seller['mapsLink']);
    final aadharCtrl = TextEditingController(text: seller['aadhar']);
    final panCtrl = TextEditingController(text: seller['pan']);
    final vehicleCtrl = TextEditingController(text: seller['vehicle']);
    final licenseCtrl = TextEditingController(text: seller['license']);
    final bankNameCtrl = TextEditingController(text: seller['bankName']);
    final bankAccCtrl = TextEditingController(text: seller['bankAcc']);
    final ifscCtrl = TextEditingController(text: seller['ifsc']);

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
              const Text('KYC Edit करा', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _editField('दुकानाचे नाव', nameCtrl),
                      _editField('मालक', ownerCtrl),
                      _editField('मोबाईल', mobileCtrl, keyboardType: TextInputType.phone),
                      _editField('पर्यायी मोबाईल', altMobileCtrl, keyboardType: TextInputType.phone),
                      _editField('पिनकोड', pincodeCtrl, keyboardType: TextInputType.number),
                      _editField('पत्ता', addressCtrl, maxLines: 2),
                      _editField('Google Maps Link', mapsCtrl),
                      _editField('आधार क्रमांक', aadharCtrl, keyboardType: TextInputType.number),
                      _editField('पॅन क्रमांक', panCtrl),
                      _editField('गाडी नंबर', vehicleCtrl),
                      _editField('लायसन नंबर', licenseCtrl),
                      _editField('बँकेचे नाव', bankNameCtrl),
                      _editField('खाते क्रमांक', bankAccCtrl, keyboardType: TextInputType.number),
                      _editField('IFSC', ifscCtrl),
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
                          seller['name'] = nameCtrl.text;
                          seller['owner'] = ownerCtrl.text;
                          seller['phone'] = mobileCtrl.text;
                          seller['altPhone'] = altMobileCtrl.text;
                          seller['pincode'] = pincodeCtrl.text;
                          seller['address'] = addressCtrl.text;
                          seller['mapsLink'] = mapsCtrl.text;
                          seller['aadhar'] = aadharCtrl.text;
                          seller['pan'] = panCtrl.text;
                          seller['vehicle'] = vehicleCtrl.text;
                          seller['license'] = licenseCtrl.text;
                          seller['bankName'] = bankNameCtrl.text;
                          seller['bankAcc'] = bankAccCtrl.text;
                          seller['ifsc'] = ifscCtrl.text;
                        });
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('✅ KYC अद्ययावत झाली'), backgroundColor: AppColors.successGreen),
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

  Widget _editField(String label, TextEditingController ctrl, {TextInputType? keyboardType, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: ctrl,
        keyboardType: keyboardType,
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

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.textLight),
          const SizedBox(width: 8),
          Text('$label: ', style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
          Expanded(
            child: Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark)),
          ),
        ],
      ),
    );
  }

  Widget _photoThumb(String label, IconData icon) {
    return Column(
      children: [
        Container(
          width: 100, height: 80,
          decoration: BoxDecoration(
            color: AppColors.primaryBlue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.primaryBlue.withOpacity(0.3)),
          ),
          child: Icon(icon, size: 40, color: AppColors.primaryBlue),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 11)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final tabs = ['प्रतीक्षेत', 'मंजूर', 'नाकारले'];
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        title: const Text('Seller KYC', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              children: tabs.map((tab) {
                final isSelected = _selectedTab == tab;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedTab = tab),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? _statusColor(tab).withOpacity(0.1) : Colors.transparent,
                        border: Border.all(color: isSelected ? _statusColor(tab) : AppColors.lightGrey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(tab, textAlign: TextAlign.center, style: TextStyle(color: isSelected ? _statusColor(tab) : AppColors.textLight, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, fontSize: 13)),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: _filtered.isEmpty
                ? const Center(child: Text('कोणतेही अर्ज नाहीत', style: TextStyle(color: AppColors.textLight)))
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filtered.length,
                    itemBuilder: (context, index) {
                      final s = _filtered[index];
                      return GestureDetector(
                        onTap: () => _showKycDetail(s),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6, offset: const Offset(0, 2))],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 48, height: 48,
                                decoration: BoxDecoration(color: AppColors.primaryBlue.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                                child: const Icon(Icons.storefront_outlined, color: AppColors.primaryBlue),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(s['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textDark)),
                                    Text('${s['category']} • ${s['days']}', style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(color: _statusColor(s['status']).withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                                child: Text(s['status'], style: TextStyle(color: _statusColor(s['status']), fontSize: 12, fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
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
