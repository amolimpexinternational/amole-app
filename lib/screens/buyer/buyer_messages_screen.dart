import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class BuyerMessagesScreen extends StatelessWidget {
  const BuyerMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> messages = [
      {
        'seller': 'श्री गणेश किराणा',
        'msg': 'तुमची ऑर्डर पाठवली आहे. उद्या सकाळी १० पर्यंत मिळेल.',
        'time': 'आज, 10:30 AM',
        'isNew': true,
        'color': Colors.orange,
      },
      {
        'seller': 'स्वाद हॉटेल',
        'msg': 'धन्यवाद! पुन्हा भेट द्या. आजची स्पेशल ऑफर बघा.',
        'time': 'काल, 4:00 PM',
        'isNew': false,
        'color': Colors.green,
      },
      {
        'seller': 'राज इलेक्ट्रॉनिक्स',
        'msg': 'नवीन मोबाईल स्टॉकमध्ये आला आहे. ५% सूट संपेपर्यंत.',
        'time': '२ दिवसांपूर्वी',
        'isNew': false,
        'color': Colors.blue,
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text('माझे मेसेज'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: messages.isEmpty
          ? const Center(child: Text('सध्या कोणतेही मेसेज नाही', style: TextStyle(color: AppColors.textLight)))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final m = messages[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: m['isNew'] ? AppColors.primaryBlue.withValues(alpha: 0.3) : Colors.grey.shade200),
                    boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6)],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: (m['color'] as Color).withValues(alpha: 0.15),
                            child: Icon(Icons.store, color: m['color'] as Color, size: 18),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(m['seller'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textDark)),
                          ),
                          if (m['isNew'])
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
                              child: const Text('नवीन', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(m['msg'], style: const TextStyle(fontSize: 13, color: AppColors.textDark)),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(m['time'], style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
