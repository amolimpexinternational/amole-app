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
  late AdStatus _status;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.ad.title);
    _descController = TextEditingController(text: widget.ad.desc);
    _budgetController = TextEditingController(text: widget.ad.budget.toStringAsFixed(0));
    _status = widget.ad.status;
  }

  void _save() {
    setState(() {
      widget.ad.title = _titleController.text;
      widget.ad.desc = _descController.text;
      widget.ad.budget = double.tryParse(_budgetController.text) ?? widget.ad.budget;
      widget.ad.status = _status;
    });
    // TODO: Firestore document (collection: advertisements) update करा
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('जाहिरात यशस्वीरित्या Update झाली'), backgroundColor: Colors.green),
    );
    Navigator.pop(context);
  }

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
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Text('विक्रेता: ${widget.ad.sellerName}', style: const TextStyle(fontWeight: FontWeight.w600)),
          ),
          const SizedBox(height: 14),
          TextField(controller: _titleController, decoration: const InputDecoration(labelText: 'शीर्षक', border: OutlineInputBorder(), filled: true, fillColor: Colors.white)),
          const SizedBox(height: 14),
          TextField(controller: _descController, maxLines: 3, decoration: const InputDecoration(labelText: 'वर्णन', border: OutlineInputBorder(), filled: true, fillColor: Colors.white)),
          const SizedBox(height: 14),
          TextField(controller: _budgetController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'बजेट (₹)', border: OutlineInputBorder(), filled: true, fillColor: Colors.white)),
          const SizedBox(height: 14),
          const Text('स्थिती', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
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
            child: const Text('Save करा', style: TextStyle(color: Colors.white, fontSize: 15)),
          ),
        ],
      ),
    );
  }
}
