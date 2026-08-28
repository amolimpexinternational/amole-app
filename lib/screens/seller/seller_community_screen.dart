import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class SellerCommunityScreen extends StatefulWidget {
  const SellerCommunityScreen({super.key});

  @override
  State<SellerCommunityScreen> createState() => _SellerCommunityScreenState();
}

class _SellerCommunityScreenState extends State<SellerCommunityScreen> {
  int _selectedTab = 0;
  final _messageController = TextEditingController();
  String _selectedAudience = 'सर्व ग्राहक';

  final List<Map<String, dynamic>> _customers = [
    {'name': 'अनिल जोशी', 'lastPurchase': '2 दिवसांपूर्वी', 'totalPurchase': 1200, 'avatar': 'A', 'color': 0xFF1565C0, 'selected': false},
    {'name': 'संगीता राणे', 'lastPurchase': 'आज', 'totalPurchase': 3500, 'avatar': 'S', 'color': 0xFFE91E63, 'selected': false},
    {'name': 'रमेश पाटील', 'lastPurchase': '5 दिवसांपूर्वी', 'totalPurchase': 850, 'avatar': 'R', 'color': 0xFF43A047, 'selected': false},
    {'name': 'प्रिया देशमुख', 'lastPurchase': '1 आठवड्यापूर्वी', 'totalPurchase': 450, 'avatar': 'P', 'color': 0xFFFF8F00, 'selected': false},
    {'name': 'सुनील कदम', 'lastPurchase': 'काल', 'totalPurchase': 2100, 'avatar': 'Su', 'color': 0xFF7B1FA2, 'selected': false},
  ];

  final List<Map<String, dynamic>> _sentMessages = [
    {'title': 'दिवाळी ऑफर!', 'message': 'या दिवाळीत सर्व वस्तूंवर 20% सूट. आजच खरेदी करा!', 'audience': 'सर्व ग्राहक', 'sentTo': 124, 'date': '24 Aug 2026', 'time': '10:30 AM'},
    {'title': 'नवीन Stock!', 'message': 'ताजा किराणा माल आला आहे. Order करा!', 'audience': 'नियमित ग्राहक', 'sentTo': 45, 'date': '20 Aug 2026', 'time': '3:00 PM'},
    {'title': 'बंद राहणार', 'message': 'उद्या दुकान बंद राहणार. गैरसोयीबद्दल क्षमस्व.', 'audience': 'सर्व ग्राहक', 'sentTo': 124, 'date': '15 Aug 2026', 'time': '8:00 PM'},
  ];

  List<Map<String, dynamic>> get _selectedCustomers =>
      _customers.where((c) => c['selected'] == true).toList();

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Message लिहा')),
      );
      return;
    }
    final count = _selectedAudience == 'निवडक ग्राहक'
        ? _selectedCustomers.length
        : 124;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Message पाठवायचा का?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Audience: $_selectedAudience'),
            Text('एकूण ग्राहक: $count जण'),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(8)),
              child: Text(_messageController.text, style: const TextStyle(fontSize: 13)),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('रद्द करा')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _sentMessages.insert(0, {
                  'title': 'नवीन Message',
                  'message': _messageController.text,
                  'audience': _selectedAudience,
                  'sentTo': count,
                  'date': 'आज',
                  'time': 'आत्ता',
                });
                _messageController.clear();
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Message $count ग्राहकांना पाठवला!'), backgroundColor: Colors.green),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue),
            child: const Text('पाठवा', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        title: const Text('Community'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(46),
          child: Container(
            color: AppColors.primaryBlue,
            child: Row(
              children: [
                Expanded(child: GestureDetector(
                  onTap: () => setState(() => _selectedTab = 0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(border: Border(bottom: BorderSide(color: _selectedTab == 0 ? AppColors.cyan : Colors.transparent, width: 3))),
                    child: Text('Message पाठवा', textAlign: TextAlign.center, style: TextStyle(color: _selectedTab == 0 ? Colors.white : Colors.white60, fontWeight: _selectedTab == 0 ? FontWeight.bold : FontWeight.normal, fontSize: 13)),
                  ),
                )),
                Expanded(child: GestureDetector(
                  onTap: () => setState(() => _selectedTab = 1),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(border: Border(bottom: BorderSide(color: _selectedTab == 1 ? AppColors.cyan : Colors.transparent, width: 3))),
                    child: Text('ग्राहक यादी', textAlign: TextAlign.center, style: TextStyle(color: _selectedTab == 1 ? Colors.white : Colors.white60, fontWeight: _selectedTab == 1 ? FontWeight.bold : FontWeight.normal, fontSize: 13)),
                  ),
                )),
                Expanded(child: GestureDetector(
                  onTap: () => setState(() => _selectedTab = 2),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(border: Border(bottom: BorderSide(color: _selectedTab == 2 ? AppColors.cyan : Colors.transparent, width: 3))),
                    child: Text('पाठवलेले', textAlign: TextAlign.center, style: TextStyle(color: _selectedTab == 2 ? Colors.white : Colors.white60, fontWeight: _selectedTab == 2 ? FontWeight.bold : FontWeight.normal, fontSize: 13)),
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
      body: _selectedTab == 0 ? _buildSendMessage() : _selectedTab == 1 ? _buildCustomerList() : _buildSentMessages(),
    );
  }

  Widget _buildSendMessage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Audience निवडा', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  children: ['सर्व ग्राहक', 'नियमित ग्राहक', 'नवीन ग्राहक', 'निवडक ग्राहक'].map((a) =>
                    ChoiceChip(
                      label: Text(a),
                      selected: _selectedAudience == a,
                      selectedColor: AppColors.primaryBlue,
                      labelStyle: TextStyle(color: _selectedAudience == a ? Colors.white : AppColors.textDark, fontSize: 12),
                      onSelected: (_) => setState(() => _selectedAudience = a),
                    )
                  ).toList(),
                ),
                if (_selectedAudience == 'निवडक ग्राहक') ...[
                  const SizedBox(height: 10),
                  const Text('ग्राहक निवडा:', style: TextStyle(fontSize: 13, color: AppColors.textLight)),
                  const SizedBox(height: 6),
                  ..._customers.map((c) => CheckboxListTile(
                    value: c['selected'] as bool,
                    onChanged: (v) => setState(() => c['selected'] = v),
                    title: Text(c['name'], style: const TextStyle(fontSize: 13)),
                    subtitle: Text('शेवटची खरेदी: ${c['lastPurchase']}', style: const TextStyle(fontSize: 11)),
                    controlAffinity: ListTileControlAffinity.leading,
                    dense: true,
                    activeColor: AppColors.primaryBlue,
                  )),
                  if (_selectedCustomers.isNotEmpty)
                    Text('${_selectedCustomers.length} ग्राहक निवडले', style: const TextStyle(fontSize: 12, color: AppColors.primaryBlue, fontWeight: FontWeight.bold)),
                ],
              ],
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Message लिहा', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                const SizedBox(height: 10),
                TextField(
                  controller: _messageController,
                  maxLines: 5,
                  maxLength: 300,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: 'तुमचा message इथे लिहा... (कमाल 300 अक्षरे)',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.primaryBlue, width: 2)),
                  ),
                ),
                const SizedBox(height: 4),
                const Text('⚠️ ग्राहकांचे मोबाईल नंबर दिसणार नाहीत — फक्त in-app message पाठवला जाईल (Blueprint ५.९)', style: TextStyle(fontSize: 10, color: AppColors.textLight)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton.icon(
              onPressed: _messageController.text.isNotEmpty ? _sendMessage : null,
              icon: const Icon(Icons.send, color: Colors.white),
              label: const Text('Message पाठवा', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _customers.length,
      itemBuilder: (context, index) {
        final c = _customers[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)]),
          child: Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: Color(c['color'] as int).withOpacity(0.15),
                child: Text(c['avatar'], style: TextStyle(color: Color(c['color'] as int), fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(c['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textDark)),
                    Text('शेवटची खरेदी: ${c['lastPurchase']}', style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
                    Text('एकूण खरेदी: ₹${c['totalPurchase']}', style: const TextStyle(fontSize: 12, color: AppColors.textDark)),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() => _selectedTab = 0);
                  setState(() {
                    _selectedAudience = 'निवडक ग्राहक';
                    for (var cu in _customers) { cu['selected'] = false; }
                    c['selected'] = true;
                  });
                },
                icon: const Icon(Icons.message_outlined, color: AppColors.primaryBlue),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSentMessages() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _sentMessages.length,
      itemBuilder: (context, index) {
        final m = _sentMessages[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.message, color: AppColors.primaryBlue, size: 18),
                  const SizedBox(width: 8),
                  Expanded(child: Text(m['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textDark))),
                  Text(m['date'], style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
                ],
              ),
              const SizedBox(height: 8),
              Text(m['message'], style: const TextStyle(fontSize: 13, color: AppColors.textDark)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(color: AppColors.primaryBlue.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                    child: Text(m['audience'], style: const TextStyle(fontSize: 11, color: AppColors.primaryBlue)),
                  ),
                  const SizedBox(width: 8),
                  Text('${m['sentTo']} ग्राहकांना पाठवला', style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
                  const Spacer(),
                  Text(m['time'], style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
