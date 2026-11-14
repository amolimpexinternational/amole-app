import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../admin/admin_view_dashboard_screen.dart';
import '../admin/admin_entity_transactions_screen.dart';

class FranchiseSellerProfileScreen extends StatefulWidget {
  final Map<String, String> seller;
  const FranchiseSellerProfileScreen({super.key, required this.seller});

  @override
  State<FranchiseSellerProfileScreen> createState() => _FranchiseSellerProfileScreenState();
}

class _FranchiseSellerProfileScreenState extends State<FranchiseSellerProfileScreen> {
  late String _name, _mobile, _pincode, _address, _joined;
  // नवीन KYC फील्ड्स
  String _ownerName = 'राजेश पाटील';
  String _altMobile = '9876543211';
  String _mapsLink = 'https://maps.app.goo.gl/abc123';
  String _aadhar = '1234 5678 9012';
  String _pan = 'ABCDE1234F';
  String _vehicle = 'MH12AB1234';
  String _license = 'MH1234567890';
  String _bankName = 'SBI';
  String _bankAcc = '123456789012';
  String _ifsc = 'SBIN0001234';
  String _category = 'किराणा';

  @override
  void initState() {
    super.initState();
    _name = widget.seller['name'] ?? '-';
    _mobile = widget.seller['mobile'] ?? '-';
    _pincode = widget.seller['pincode'] ?? '-';
    _address = widget.seller['address'] ?? 'गल्ली नं. ४, मुख्य रस्ता, हडपसर, पुणे';
    _joined = widget.seller['joined'] ?? '-';
  }

  void _editSellerInfo() {
    final nameCtrl = TextEditingController(text: _name);
    final ownerCtrl = TextEditingController(text: _ownerName);
    final mobileCtrl = TextEditingController(text: _mobile);
    final altMobileCtrl = TextEditingController(text: _altMobile);
    final pincodeCtrl = TextEditingController(text: _pincode);
    final addressCtrl = TextEditingController(text: _address);
    final mapsCtrl = TextEditingController(text: _mapsLink);
    final aadharCtrl = TextEditingController(text: _aadhar);
    final panCtrl = TextEditingController(text: _pan);
    final vehicleCtrl = TextEditingController(text: _vehicle);
    final licenseCtrl = TextEditingController(text: _license);
    final bankNameCtrl = TextEditingController(text: _bankName);
    final bankAccCtrl = TextEditingController(text: _bankAcc);
    final ifscCtrl = TextEditingController(text: _ifsc);

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
              const Text('संपूर्ण KYC Edit करा', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _editField('दुकानाचे नाव', nameCtrl),
                      _editField('मालकाचे नाव', ownerCtrl),
                      _editField('मोबाईल', mobileCtrl, keyboardType: TextInputType.phone),
                      _editField('पर्यायी मोबाईल', altMobileCtrl, keyboardType: TextInputType.phone),
                      _editField('पिनकोड', pincodeCtrl, keyboardType: TextInputType.number),
                      _editField('पूर्ण पत्ता', addressCtrl, maxLines: 2),
                      _editField('Google Maps Link', mapsCtrl),
                      _editField('आधार क्रमांक', aadharCtrl, keyboardType: TextInputType.number),
                      _editField('पॅन क्रमांक', panCtrl),
                      _editField('गाडी नंबर', vehicleCtrl),
                      _editField('लायसन नंबर', licenseCtrl),
                      _editField('बँकेचे नाव', bankNameCtrl),
                      _editField('खाते क्रमांक', bankAccCtrl, keyboardType: TextInputType.number),
                      _editField('IFSC कोड', ifscCtrl),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: TextButton(onPressed: () => Navigator.pop(context), child: const Text('रद्द करा'))),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _name = nameCtrl.text;
                          _ownerName = ownerCtrl.text;
                          _mobile = mobileCtrl.text;
                          _altMobile = altMobileCtrl.text;
                          _pincode = pincodeCtrl.text;
                          _address = addressCtrl.text;
                          _mapsLink = mapsCtrl.text;
                          _aadhar = aadharCtrl.text;
                          _pan = panCtrl.text;
                          _vehicle = vehicleCtrl.text;
                          _license = licenseCtrl.text;
                          _bankName = bankNameCtrl.text;
                          _bankAcc = bankAccCtrl.text;
                          _ifsc = ifscCtrl.text;
                        });
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('✅ संपूर्ण KYC अद्ययावत झाली'), backgroundColor: AppColors.successGreen),
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

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: AppColors.primaryBlue),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
                const SizedBox(height: 2),
                Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark)),
              ],
            ),
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
        backgroundColor: AppColors.primaryBlue,
        title: Text(_name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
        actions: [
          IconButton(icon: const Icon(Icons.edit_outlined, color: Colors.white), tooltip: 'KYC Edit', onPressed: _editSellerInfo),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 40,
                backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
                child: const Icon(Icons.storefront_outlined, size: 40, color: AppColors.primaryBlue),
              ),
            ),
            const SizedBox(height: 16),
            Row(children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AdminViewDashboardScreen(
                    name: _name, roleLabel: 'Seller', headerSubtitle: 'पिनकोड: $_pincode',
                    revenueLabel: 'या महिन्यातील महसूल', revenueValue: '₹18,450', viewerLabel: 'Franchise',
                    kpis: [
                      DashboardKpi(title: 'ऑर्डर्स', value: '37', subtitle: '3 प्रतीक्षेत', icon: Icons.shopping_bag_outlined, color: Colors.orange),
                      DashboardKpi(title: 'ग्राहक', value: '124', subtitle: 'या महिन्यात', icon: Icons.people_outlined, color: Colors.purple),
                    ],
                  ))),
                  icon: const Icon(Icons.dashboard_outlined, size: 18),
                  label: const Text('डॅशबोर्ड', style: TextStyle(fontSize: 12)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AdminEntityTransactionsScreen(entityName: _name, roleLabel: 'Seller'))),
                  icon: const Icon(Icons.receipt_long_outlined, size: 18),
                  label: const Text('व्यवहार', style: TextStyle(fontSize: 12)),
                ),
              ),
            ]),
            const SizedBox(height: 16),

            // === मूलभूत माहिती ===
            _section('मूलभूत माहिती', [
              _infoRow(Icons.storefront_outlined, 'दुकानाचे नाव', _name),
              _infoRow(Icons.person_outlined, 'मालकाचे नाव', _ownerName),
              _infoRow(Icons.phone_outlined, 'मोबाईल', _mobile),
              _infoRow(Icons.phone_android_outlined, 'पर्यायी मोबाईल', _altMobile),
              _infoRow(Icons.category_outlined, 'श्रेणी', _category),
              _infoRow(Icons.location_on_outlined, 'पिनकोड', _pincode),
              _infoRow(Icons.home_outlined, 'पूर्ण पत्ता', _address),
              _infoRow(Icons.map_outlined, 'Google Maps Link', _mapsLink),
            ]),

            // === KYC माहिती ===
            _section('KYC माहिती', [
              _infoRow(Icons.badge_outlined, 'आधार क्रमांक', _aadhar),
              _infoRow(Icons.credit_card_outlined, 'पॅन क्रमांक', _pan),
              _infoRow(Icons.directions_car_outlined, 'गाडी नंबर', _vehicle),
              _infoRow(Icons.drive_eta_outlined, 'लायसन नंबर', _license),
            ]),

            // === बँक माहिती ===
            _section('बँक माहिती', [
              _infoRow(Icons.account_balance_outlined, 'बँकेचे नाव', _bankName),
              _infoRow(Icons.numbers_outlined, 'खाते क्रमांक', _bankAcc),
              _infoRow(Icons.qr_code_outlined, 'IFSC कोड', _ifsc),
            ]),

            // === स्थिती ===
            _section('स्थिती', [
              _infoRow(Icons.calendar_today_outlined, 'सामील झाल्याची तारीख', _joined),
              _infoRow(Icons.verified_outlined, 'स्टेटस', '✅ Verified'),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _section(String title, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
          const Divider(),
          ...children,
        ],
      ),
    );
  }
}
