import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../data/ride_rates.dart';
import 'ride_status_screen.dart';

class RideBookingScreen extends StatefulWidget {
  const RideBookingScreen({super.key});

  @override
  State<RideBookingScreen> createState() => _RideBookingScreenState();
}

class _RideBookingScreenState extends State<RideBookingScreen> {
  static const String _hereText = 'हडपसर, पुणे (सध्याचे ठिकाण)';

  String _vehicle = 'bike';
  bool _pickupHere = true;
  double _km = 6;
  final TextEditingController _pickupCtrl = TextEditingController();
  final TextEditingController _dropCtrl = TextEditingController();

  @override
  void dispose() {
    _pickupCtrl.dispose();
    _dropCtrl.dispose();
    super.dispose();
  }

  IconData _iconOf(String key) {
    switch (key) {
      case 'bike':
        return Icons.two_wheeler;
      case 'rickshaw':
        return Icons.electric_rickshaw;
      case 'car5':
        return Icons.local_taxi;
      case 'car7':
        return Icons.airport_shuttle;
      case 'suv':
        return Icons.directions_car_filled;
      default:
        return Icons.directions_car;
    }
  }

  void _toast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.red),
    );
  }

  void _book() {
    final drop = _dropCtrl.text.trim();
    if (!_pickupHere && _pickupCtrl.text.trim().isEmpty) {
      _toast('प्रवास कुठून सुरू करायचा ते लिहा');
      return;
    }
    if (drop.isEmpty) {
      _toast('कुठे प्रवास करायचा ते लिहा');
      return;
    }
    final fare = RideRates.fare(_vehicle, _km);
    if (fare < 0) {
      _toast('या वाहनाचे दर लवकरच येतील');
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RideStatusScreen(
          vehicleLabel: RideRates.labelOf(_vehicle),
          pickup: _pickupHere ? _hereText : _pickupCtrl.text.trim(),
          drop: drop,
          km: _km,
          fare: fare,
        ),
      ),
    );
  }

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

  Widget _vehicleTile(Map<String, String> v) {
    final key = v['key']!;
    final selected = key == _vehicle;
    return GestureDetector(
      onTap: () => setState(() => _vehicle = key),
      child: Container(
        width: 92,
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: selected ? AppColors.primaryBlue : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: selected ? AppColors.primaryBlue : AppColors.lightGrey),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(_iconOf(key),
                size: 30,
                color: selected ? Colors.white : AppColors.primaryBlue),
            const SizedBox(height: 6),
            Text(
              v['label']!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: selected ? Colors.white : AppColors.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lines = RideRates.chartLines(_vehicle);
    final fare = RideRates.fare(_vehicle, _km);
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('🚕 राईड बुक करा',
            style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('वाहन निवडा',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark)),
          const SizedBox(height: 8),
          SizedBox(
            height: 92,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: RideRates.vehicles.map(_vehicleTile).toList(),
            ),
          ),
          const SizedBox(height: 12),
          _box(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${RideRates.labelOf(_vehicle)} भाडे',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark)),
                const SizedBox(height: 6),
                if (lines.isEmpty)
                  const Text('या वाहनाचे दर लवकरच येतील.',
                      style: TextStyle(
                          fontSize: 13, color: AppColors.textLight))
                else
                  ...lines.map((l) => Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(l,
                            style: const TextStyle(
                                fontSize: 13, color: AppColors.textDark)),
                      )),
              ],
            ),
          ),
          const Text('प्रवास कुठून सुरू करायचा?',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark)),
          const SizedBox(height: 8),
          Row(
            children: [
              ChoiceChip(
                label: const Text('आत्ता जिथे आहे तिथून'),
                selected: _pickupHere,
                onSelected: (_) => setState(() => _pickupHere = true),
              ),
              const SizedBox(width: 8),
              ChoiceChip(
                label: const Text('दुसऱ्या ठिकाणाहून'),
                selected: !_pickupHere,
                onSelected: (_) => setState(() => _pickupHere = false),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (_pickupHere)
            const Text(_hereText,
                style: TextStyle(fontSize: 13, color: AppColors.textLight))
          else
            TextField(
              controller: _pickupCtrl,
              decoration: InputDecoration(
                hintText: 'गाडी कुठून बुक करायची?',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          const SizedBox(height: 12),
          const Text('कुठे प्रवास करायचा?',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark)),
          const SizedBox(height: 8),
          TextField(
            controller: _dropCtrl,
            decoration: InputDecoration(
              hintText: 'Drop ठिकाण',
              prefixIcon: const Icon(Icons.location_on_outlined),
              filled: true,
              fillColor: Colors.white,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('अंतर (Demo)',
                  style: TextStyle(
                      fontSize: 13, color: AppColors.textLight)),
              Text('${_km.toStringAsFixed(0)} km',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryBlue)),
            ],
          ),
          Slider(
            value: _km,
            min: 1,
            max: 40,
            divisions: 39,
            activeColor: AppColors.primaryBlue,
            onChanged: (v) => setState(() => _km = v),
          ),
          const Text('खरे अंतर नकाशावरून काढणे पुढे येईल.',
              style: TextStyle(fontSize: 11, color: AppColors.textLight)),
          const SizedBox(height: 12),
          _box(
            color: AppColors.primaryBlue.withValues(alpha: 0.08),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('अंदाजे भाडे',
                    style: TextStyle(
                        fontSize: 13, color: AppColors.textLight)),
                const SizedBox(height: 4),
                Text(fare < 0 ? 'दर लवकरच' : '₹$fare',
                    style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark)),
                const SizedBox(height: 4),
                const Text(
                  'हे फक्त अंदाजे भाडे आहे. प्रवासापूर्वी ड्रायव्हरशी बोलून भाडे खात्री करून घ्या.',
                  style: TextStyle(fontSize: 12, color: AppColors.textLight),
                ),
              ],
            ),
          ),
          _box(
            color: Colors.orange.withValues(alpha: 0.1),
            child: const Text(
              'महत्त्वाचे: या प्रवासात कंपनी एकही रुपया कमिशन घेत नाही. '
              'आम्ही फक्त प्रवासी आणि ड्रायव्हर यांना एकमेकांच्या संपर्कात आणतो. '
              'पैशांचे सर्व बोलणे ड्रायव्हरसोबत व्यवस्थित करून घ्या. '
              'कोणत्याही आर्थिक व्यवहारासाठी कंपनी जबाबदार नाही.',
              style: TextStyle(fontSize: 12, color: AppColors.textDark),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _book,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('राईड बुक करा',
                  style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}