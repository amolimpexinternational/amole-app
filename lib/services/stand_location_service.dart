import 'dart:async';
import 'package:geolocator/geolocator.dart';

class StandLocationService {
  static Position? _standPosition;
  static StreamSubscription<Position>? _positionStream;

  static Future<void> startTracking({
    required Function() onMovedAway,
    int distanceFilterMeters = 250,
  }) async {
    // १. परवानगी तपासणे
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    // २. सध्याचे लोकेशन (Stand) सेव्ह करणे
    _standPosition = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );

    // ३. लोकेशन स्ट्रीम सुरू करणे (फक्त २५० मीटर हालचाल झाल्यावर अपडेट)
    _positionStream?.cancel();
    _positionStream = Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: distanceFilterMeters,
      ),
    ).listen((Position position) {
      if (_standPosition == null) return;

      double distance = Geolocator.distanceBetween(
        _standPosition!.latitude,
        _standPosition!.longitude,
        position.latitude,
        position.longitude,
      );

      if (distance >= distanceFilterMeters) {
        onMovedAway(); // ॲपला सांगा की स्टँड सोडला
        stopTracking(); // GPS बंद
      }
    });
  }

  static void stopTracking() {
    _positionStream?.cancel();
    _positionStream = null;
    _standPosition = null;
  }
}