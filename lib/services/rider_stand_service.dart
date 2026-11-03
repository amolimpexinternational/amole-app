import 'dart:async';
import 'package:tracelet/tracelet.dart'; // मोफत मोशन-डिटेक्शन आणि जिओफेन्सिंग

class RiderStandService {
  static StreamSubscription? _locationSub;

  // Stand लोकेशनवर 250 मीटरचे जिओफेन्स तयार करणे
  static Future<void> startStandTracking({
    required double standLat,
    required double standLng,
    required VoidCallback onMovedAway,
  }) async {
    // १. परवानगी (Permission) आणि ट्रॅकिंग सुरू करणे
    await Tracelet.start(
      config: Config(
        // फक्त 250 मीटर हालचाल झाल्यावरच लोकेशन अपडेट होईल
        distanceFilter: 250,
        // फोन स्थिर असताना GPS बंद ठेवण्यासाठी मोशन-डिटेक्शन सुरू करा
        motionDetection: true,
      ),
    );

    // २. Stand भोवती 250 मीटरचे वर्तुळ (Geofence) तयार करणे
    await Tracelet.addGeofence(
      Geofence(
        identifier: 'RiderStand_${DateTime.now().millisecondsSinceEpoch}',
        latitude: standLat,
        longitude: standLng,
        radius: 250, // २५० मीटर
        triggers: [GeofenceTrigger.exit], // बाहेर पडल्यावरच इव्हेंट
      ),
    );

    // ३. जेव्हा रायडर २५० मीटरच्या बाहेर जाईल तेव्हा इव्हेंट ऐकणे
    _locationSub = Tracelet.onGeofence().listen((event) {
      if (event.trigger == GeofenceTrigger.exit) {
        onMovedAway(); // ॲपला सांगा की स्टँड सोडला
        stopTracking(); // ट्रॅकिंग थांबवा
      }
    });
  }

  // ट्रॅकिंग थांबवण्यासाठी
  static void stopTracking() {
    _locationSub?.cancel();
    _locationSub = null;
    Tracelet.stop();
  }
}