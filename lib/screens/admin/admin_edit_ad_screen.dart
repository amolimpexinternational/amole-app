import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../models/ad_model.dart';

class AdminEditAdScreen extends StatefulWidget {
  final AdModel ad;
  const AdminEditAdScreen({super.key, required this.ad});

  @override
  State<AdminEditAdScreen> createState() => _AdminEditAdScreenState();
}

class _AdminEditAdScreenState extends State<AdminEditAdScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descController;
  late TextEditingController _budgetController;
  late TextEditingController _pollQuestionController;
  
  late AdStatus _status;
  
  // नवीन ॲड केलेले टार्गेट ऑडियन्स व्हेरिएबल्स
  String _location = 'तालुका';
  String _ageGroup = 'सर्व वयोगट';
  String _gender = 'सर्व';

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.ad.title);
    _descController = TextEditingController(text: widget.ad.desc);
    _budgetController = TextEditingController(text: widget.ad.budget.toStringAsFixed(0));
    _pollQuestionController = TextEditingController(text: "तुम्ही या जाहिरातीत इंटरेस्टेड आहात का?"); // डिफॉल्ट किंवा मॉडेलमधून
    _status = widget.ad.status;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _budgetController.dispose();
    _pollQuestionController.dispose();
    super.dispose();
  }

  void _save() {
    setState(() {
      widget.ad.title = _titleController.text;
      widget.ad.desc = _descController.text;
      widget.ad.budget = double.tryParse(_budgetController.text) ?? widget.ad.budget;
      widget.ad.status = _status;
      // TODO: Firestore मध्ये pollQuestion आणि targetAudience (location, age, gender) सुद्धा अपडेट करा
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('जाहिरात यशस्वीरित्या Update झाली'), backgroundColor: Colors.green),
    );
    Navigator.pop(context);
  }

  Widget _label(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 6, top: 12),
        child: Text(text, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark)),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        title: const Text('जाहिरात Edit करा'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Seller Info
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                const Icon(Icons.store, color: AppColors.primaryBlue),
                const SizedBox(width: 8),
                Text('विक्रेता: ${widget.ad.sellerName}', style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Basic Info
          TextField(controller: _titleController, decoration: const InputDecoration(labelText: 'शीर्षक', border: OutlineInputBorder(), filled: true, fillColor: Colors.white)),
          const SizedBox(height: 14),
          TextField(controller: _descController, maxLines: 3, decoration: const InputDecoration(labelText: 'वर्णन (Description)', border: OutlineInputBorder(), filled: true, fillColor: Colors.white)),
          const SizedBox(height: 14),
          TextField(controller: _budgetController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'बजेट (₹)', border: OutlineInputBorder(), filled: true, fillColor: Colors.white)),
          
          // Poll Question
          _label('पोल प्रश्न (Poll Question)'),
          TextField(
            controller: _pollQuestionController, 
            decoration: const InputDecoration(
              hintText: 'तुम्ही या जाहिरातीत इंटरेस्टेड आहात का?', 
              border: OutlineInputBorder(), 
              filled: true, 
              fillColor: Colors.white
            )
          ),

          // Target Audience
          _label('ऑडियन्स टार्गेटिंग'),
          DropdownButtonFormField<String>(
            initialValue: _location,
            decoration: const InputDecoration(labelText: 'Location', border: OutlineInputBorder(), filled: true, fillColor: Colors.white),
            items: ['तालुका', 'जिल्हा', 'राज्य', 'देशभर'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: (v) => setState(() => _location = v!),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: _ageGroup,
            decoration: const InputDecoration(labelText: 'Age Group', border: OutlineInputBorder(), filled: true, fillColor: Colors.white),
            items: ['सर्व वयोगट', '13-23', '24-40', '40-60', '60+'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: (v) => setState(() => _ageGroup = v!),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: _gender,
            decoration: const InputDecoration(labelText: 'Gender', border: OutlineInputBorder(), filled: true, fillColor: Colors.white),
            items: ['सर्व', 'स्त्री', 'पुरुष'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: (v) => setState(() => _gender = v!),
          ),

          // Status
          _label('स्थिती (Status)'),
          SegmentedButton<AdStatus>(
            segments: const [
              ButtonSegment(value: AdStatus.live, label: Text('Live')),
              ButtonSegment(value: AdStatus.paused, label: Text('Paused')),
              ButtonSegment(value: AdStatus.expired, label: Text('Expired')),
            ],
            selected: {_status},
            onSelectionChanged: (v) => setState(() => _status = v.first),
          ),
          
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _save,
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue, padding: const EdgeInsets.symmetric(vertical: 14)),
            child: const Text('Save करा', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}