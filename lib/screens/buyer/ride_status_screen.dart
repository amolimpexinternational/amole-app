import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'ride_feedback_screen.dart';

class RideStatusScreen extends StatefulWidget {
  final String vehicleLabel;
  final String pickup;
  final String drop;
  final double km;
  final int fare;

  const RideStatusScreen({
    super.key,
    required this.vehicleLabel,
    required this.pickup,
    required this.drop,
    required this.km,
    required this.fare,
  });

  @override
  State<RideStatusScreen> createState() => _RideStatusScreenState();
}

class _RideStatusScreenState extends State<RideStatusScreen> {
  // 0 = रायडर शोधत आहे, 1 = ड्रायव्हर confirm, 2 = cancel
  int _stage = 0;

  Widget _box({required Widget child, Color? color}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.lightGrey),
      ),
      child: child,
    );
  }

  void _openFeedback() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RideFeedbackScreen(
          from: widget.pickup,
          to: widget.drop,
          estimatedFare: widget.fare,
        ),
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
        title: const Text('🚕 तुमची राईड',
            style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _box(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _stage == 0
                      ? '⏳ जवळचे रायडर शोधत आहोत...'
                      : _stage == 1
                          ? '✅ ड्रायव्हरने राईड स्वीकारली'
                          : '❌ राईड cancel झाली',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark),
                ),
                if (_stage == 0) ...[
                  const SizedBox(height: 4),
                  const Text(
                    'तुमच्या pickup च्या 3 km मधील रायडरना सूचना गेली आहे.',
                    style: TextStyle(
                        fontSize: 12, color: AppColors.textLight),
                  ),
                ],
              ],
            ),
          ),
          _box(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${widget.vehicleLabel} · ${widget.km.toStringAsFixed(0)} km',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark)),
                const SizedBox(height: 6),
                Text('कुठून: ${widget.pickup}',
                    style: const TextStyle(fontSize: 13)),
                const SizedBox(height: 2),
                Text('कुठे: ${widget.drop}',
                    style: const TextStyle(fontSize: 13)),
                const SizedBox(height: 6),
                Text('अंदाजे भाडे: ₹${widget.fare}',
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryBlue)),
              ],
            ),
          ),
          if (_stage == 1)
            _box(
              color: Colors.green.withValues(alpha: 0.08),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ड्रायव्हर प्रोफाइल',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark)),
                  SizedBox(height: 6),
                  Text('नाव: संतोष गायकवाड'),
                  Text('गाडी: MH 12 AB 1234'),
                  Text('रेटिंग: 4.6 ⭐'),
                  SizedBox(height: 6),
                  Text('मोबाईल: 9822222222',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryBlue)),
                  SizedBox(height: 6),
                  Text(
                    'ड्रायव्हरला तुमचा नंबर दिसला आहे. भाडे आणि वेळ फोनवर खात्री करून घ्या.',
                    style: TextStyle(
                        fontSize: 12, color: AppColors.textLight),
                  ),
                ],
              ),
            ),
          if (_stage == 1)
            _box(
              color: AppColors.primaryBlue.withValues(alpha: 0.08),
              child: const Text(
                'प्रवास संपल्यावर 15 मिनिटांनी तुम्हाला फीडबॅकसाठी सूचना येईल. '
                'ऑनलाइन पेमेंट केले तर Reward Points मिळतील.',
                style: TextStyle(fontSize: 12, color: AppColors.textDark),
              ),
            ),
          if (_stage == 0) ...[
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => setState(() => _stage = 1),
                child: const Text('Demo: रायडरने स्वीकारले'),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => setState(() => _stage = 2),
                child: const Text('राईड cancel करा',
                    style: TextStyle(color: Colors.red)),
              ),
            ),
          ],
          if (_stage == 1)
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: _openFeedback,
                child: const Text('Demo: 15 मिनिटे झाली, फीडबॅक'),
              ),
            ),
        ],
      ),
    );
  }
}