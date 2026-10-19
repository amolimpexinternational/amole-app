import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class RideFeedbackScreen extends StatefulWidget {
  final String from;
  final String to;
  final int estimatedFare;

  const RideFeedbackScreen({
    super.key,
    required this.from,
    required this.to,
    required this.estimatedFare,
  });

  @override
  State<RideFeedbackScreen> createState() => _RideFeedbackScreenState();
}

class _RideFeedbackScreenState extends State<RideFeedbackScreen> {
  final TextEditingController _fareCtrl = TextEditingController();
  final TextEditingController _noteCtrl = TextEditingController();
  int _stars = 0;
  bool _behaviourGood = true;
  bool _askedMore = false;

  @override
  void dispose() {
    _fareCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('धन्यवाद! तुमचा फीडबॅक नोंदवला.'),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.pop(context);
  }

  Widget _yesNo(String question, bool value, void Function(bool) onChanged) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.lightGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark)),
          const SizedBox(height: 8),
          Row(
            children: [
              ChoiceChip(
                label: const Text('हो'),
                selected: value,
                onSelected: (_) => onChanged(true),
              ),
              const SizedBox(width: 8),
              ChoiceChip(
                label: const Text('नाही'),
                selected: !value,
                onSelected: (_) => onChanged(false),
              ),
            ],
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
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('राईड फीडबॅक',
            style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.lightGrey),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('तुमचा प्रवास',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark)),
                const SizedBox(height: 6),
                Text('कुठून: ${widget.from}',
                    style: const TextStyle(fontSize: 13)),
                Text('कुठे: ${widget.to}',
                    style: const TextStyle(fontSize: 13)),
                Text('अंदाजे भाडे: ₹${widget.estimatedFare}',
                    style: const TextStyle(
                        fontSize: 13, color: AppColors.textLight)),
              ],
            ),
          ),
          TextField(
            controller: _fareCtrl,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'ड्रायव्हरने प्रत्यक्षात किती भाडे घेतले (₹)',
              filled: true,
              fillColor: Colors.white,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 12),
          _yesNo('ड्रायव्हरची वर्तणूक व्यवस्थित होती का?', _behaviourGood,
              (v) => setState(() => _behaviourGood = v)),
          _yesNo('ड्रायव्हरने chart पेक्षा जास्त पैसे मागितले का?', _askedMore,
              (v) => setState(() => _askedMore = v)),
          const Text('एकूण अनुभव (ऐच्छिक)',
              style: TextStyle(fontSize: 13, color: AppColors.textLight)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (i) {
              final filled = i < _stars;
              return IconButton(
                iconSize: 36,
                onPressed: () => setState(() => _stars = i + 1),
                icon: Icon(
                  filled ? Icons.star : Icons.star_border,
                  color: filled ? Colors.amber : AppColors.textLight,
                ),
              );
            }),
          ),
          TextField(
            controller: _noteCtrl,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'काही सांगायचे असेल तर इथे लिहा...',
              filled: true,
              fillColor: Colors.white,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('वगळा'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('पाठवा'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}