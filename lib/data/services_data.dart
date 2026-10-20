import 'package:flutter/material.dart';

// Demo डेटा. खरा डेटा Stage 3 मध्ये येईल.
class ServiceData {
  static const List<Map<String, dynamic>> categories = [
    {'name': 'प्लंबर', 'icon': Icons.plumbing},
    {'name': 'इलेक्ट्रिशियन', 'icon': Icons.electrical_services},
    {'name': 'AC / फ्रिज', 'icon': Icons.ac_unit},
    {'name': 'मोबाईल दुरुस्ती', 'icon': Icons.smartphone},
    {'name': 'TV दुरुस्ती', 'icon': Icons.tv},
    {'name': 'सुतार', 'icon': Icons.carpenter},
    {'name': 'पेंटर', 'icon': Icons.format_paint},
    {'name': 'वॉशिंग मशीन', 'icon': Icons.local_laundry_service},
    {'name': 'गाडी दुरुस्ती', 'icon': Icons.car_repair},
    {'name': 'पेस्ट कंट्रोल', 'icon': Icons.pest_control},
    {'name': 'घर स्वच्छता', 'icon': Icons.cleaning_services},
    {'name': 'संगणक दुरुस्ती', 'icon': Icons.computer},
    {'name': 'डिलिव्हरी बॉय', 'icon': Icons.delivery_dining},
    {'name': 'RO / वॉटर प्युरिफायर', 'icon': Icons.water_drop},
    {'name': 'फोटोग्राफर', 'icon': Icons.camera_alt},
    {'name': 'इव्हेंट / डेकोरेशन', 'icon': Icons.celebration},
    {'name': 'शिकवणी (Tutor)', 'icon': Icons.school},
    {'name': 'सलून / ब्युटी', 'icon': Icons.content_cut},
    {'name': 'ड्रायव्हर', 'icon': Icons.directions_car},
    {'name': 'CCTV / सिक्युरिटी', 'icon': Icons.videocam},
  ];

  // paid = ज्याने सशुल्क plan घेतला आहे. फक्त हेच शोधात दिसतात.
  static const List<Map<String, dynamic>> providers = [
    {'name': 'गणेश प्लंबिंग सर्व्हिस', 'service': 'प्लंबर', 'km': 1.2, 'rating': '4.7', 'phone': '9833000001', 'paid': true},
    {'name': 'साईराज इलेक्ट्रिकल्स', 'service': 'इलेक्ट्रिशियन', 'km': 2.0, 'rating': '4.5', 'phone': '9833000002', 'paid': true},
    {'name': 'कूल केअर', 'service': 'AC / फ्रिज', 'km': 3.4, 'rating': '4.6', 'phone': '9833000003', 'paid': true},
    {'name': 'मोबाईल क्लिनिक', 'service': 'मोबाईल दुरुस्ती', 'km': 0.9, 'rating': '4.4', 'phone': '9833000004', 'paid': true},
    {'name': 'शिवशक्ती कारपेंटर', 'service': 'सुतार', 'km': 2.8, 'rating': '4.3', 'phone': '9833000005', 'paid': false},
    {'name': 'रंगोली पेंटर्स', 'service': 'पेंटर', 'km': 4.1, 'rating': '4.5', 'phone': '9833000006', 'paid': true},
    {'name': 'क्लीन होम', 'service': 'घर स्वच्छता', 'km': 3.0, 'rating': '4.8', 'phone': '9833000007', 'paid': true},
    {'name': 'न्यू लुक TV सर्व्हिस', 'service': 'TV दुरुस्ती', 'km': 1.7, 'rating': '4.2', 'phone': '9833000008', 'paid': false},
  ];
}

// ग्राहकांनी पोस्ट केलेल्या requirements. प्रोव्हायडरची screen पुढच्या भागात हीच वाचेल.
class ServiceRequests {
  static final List<Map<String, dynamic>> posted = [];
}