class ParcelVehicle {
  final String key;
  final String label;
  final int fee; // कार्गो सेलरच्या wallet मधून कपात
  final bool temp; // true = तात्पुरते दर
  const ParcelVehicle(this.key, this.label, this.fee, {this.temp = false});
}

class ParcelData {
  static const String defaultCity = 'पुणे';
  static const double radiusKm = 10; // pickup च्या 10 km मधले कार्गो सेलर

  static const List<ParcelVehicle> vehicles = [
    ParcelVehicle('bike', 'Two Wheeler', 20),
    ParcelVehicle('three', 'Three Wheeler', 30),
    ParcelVehicle('ton1', '1 टन छोटी गाडी', 50),
    ParcelVehicle('ton2', '2 टन पिकअप', 70, temp: true),
    ParcelVehicle('tempo', '2 टन+ टेम्पो', 100, temp: true),
    ParcelVehicle('truck5', '5 टन+ ट्रक', 200, temp: true),
    ParcelVehicle('truck9', '9 टन+ ट्रक', 300, temp: true),
    ParcelVehicle('container', 'कंटेनर', 500, temp: true),
  ];

  // [पहिल्या 5 km फिक्स, 5 ते 25 प्रति km, 25 ते 100 प्रति km, 100 नंतर प्रति km]
  static const Map<String, List<double>> _defaults = {
    'bike': [45.0, 10.0, 8.0, 7.0],
    'three': [100.0, 15.0, 13.0, 10.0],
    'ton1': [150.0, 20.0, 17.0, 15.0],
    'ton2': [220.0, 26.0, 22.0, 19.0],
    'tempo': [300.0, 32.0, 27.0, 23.0],
    'truck5': [500.0, 45.0, 38.0, 32.0],
    'truck9': [800.0, 65.0, 55.0, 46.0],
    'container': [1500.0, 100.0, 85.0, 70.0],
  };

  // फ्रँचाईजी / चॅनल पार्टनर / Admin शहरासाठी दर बदलू शकतील (पुढे screen जोडू)
  static final Map<String, Map<String, List<double>>> _cityOverrides = {};

  static List<double>? ratesFor(String key, {String? city}) {
    final c = city ?? defaultCity;
    return _cityOverrides[c]?[key] ?? _defaults[key];
  }

  static void setRates(String city, String key, List<double> rates) {
    _cityOverrides.putIfAbsent(city, () => {});
    _cityOverrides[city]![key] = rates;
  }

  static ParcelVehicle vehicleOf(String key) =>
      vehicles.firstWhere((v) => v.key == key);

  static String labelOf(String key) => vehicleOf(key).label;
  static int feeOf(String key) => vehicleOf(key).fee;

  // भाडे slab नुसार: पहिले 5 km फिक्स, मग 5 ते 25, 25 ते 100, 100 नंतर
  static int fare(String key, double km, {String? city}) {
    final r = ratesFor(key, city: city);
    if (r == null) return -1;
    double total = r[0];
    if (km > 5) total += ((km > 25 ? 25.0 : km) - 5) * r[1];
    if (km > 25) total += ((km > 100 ? 100.0 : km) - 25) * r[2];
    if (km > 100) total += (km - 100) * r[3];
    return total.round();
  }

  static List<String> chartLines(String key, {String? city}) {
    final r = ratesFor(key, city: city);
    if (r == null) return [];
    return [
      'पहिले 5 km: ₹${r[0].toStringAsFixed(0)} फिक्स',
      '5 ते 25 km: ₹${r[1].toStringAsFixed(0)} प्रति km',
      '25 ते 100 km: ₹${r[2].toStringAsFixed(0)} प्रति km',
      '100 km नंतर: ₹${r[3].toStringAsFixed(0)} प्रति km',
    ];
  }

  static const int lowBalanceMin = 100;
}

// ग्राहकांनी पोस्ट केलेल्या requirements. कार्गो सेलरची screen हीच वाचेल.
class ParcelRequests {
  static final List<Map<String, dynamic>> posted = [];
}