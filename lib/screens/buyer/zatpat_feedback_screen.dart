import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class ZatPatFeedbackScreen extends StatefulWidget {
  final String orderId;
  const ZatPatFeedbackScreen({super.key, this.orderId = ''});

  @override
  State<ZatPatFeedbackScreen> createState() => _ZatPatFeedbackScreenState();
}

class _ZatPatFeedbackScreenState extends State<ZatPatFeedbackScreen> {
  int _stars = 0;
  final TextEditingController _ctrl = TextEditingController();

  @override
  void dispose() {
    _ctrl.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('फीडबॅक',
            style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('🎉 ऑर्डर पोहोचली!',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark)),
          const SizedBox(height: 6),
          const Text('तुमचा अनुभव कसा होता? (ऐच्छिक)',
              style: TextStyle(fontSize: 13, color: AppColors.textLight)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (i) {
              final filled = i < _stars;
              return IconButton(
                iconSize: 38,
                onPressed: () => setState(() => _stars = i + 1),
                icon: Icon(
                  filled ? Icons.star : Icons.star_border,
                  color: filled ? Colors.amber : AppColors.textLight,
                ),
              );
            }),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _ctrl,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'काही सांगायचे असेल तर इथे लिहा...',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
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
                  onPressed: _stars == 0 && _ctrl.text.trim().isEmpty
                      ? null
                      : _submit,
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