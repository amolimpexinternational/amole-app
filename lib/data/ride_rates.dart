class RideRates {
  // शहर. खरी निवड Stage 3 मध्ये येईल.
  static const String defaultCity = 'पुणे';

  static const List<Map<String, String>> vehicles = [
    {'key': 'bike', 'label': 'बाईक'},
    {'key': 'rickshaw', 'label': 'रिक्षा'},
    {'key': 'car5', 'label': 'कार 5 seater'},
    {'key': 'car7', 'label': 'कार 7 seater'},
    {'key': 'suv', 'label': 'SUV'},
    {'key': 'sedan', 'label': 'Special Sedan'},
  ];

  // [0 ते 2 km फिक्स, 2 ते 5 km प्रति km, 5 ते 10 km प्रति km, 10 km नंतर प्रति km]
  static const Map<String, List<double>> _defaults = {
    'bike': [25.0, 15.0, 12.0, 10.0],
    'rickshaw': [35.0, 20.0, 17.0, 15.0],
    'car5': [50.0, 25.0, 22.0, 20.0],
    'car7': [90.0, 35.0, 30.0, 27.0],
    'sedan': [70.0, 30.0, 28.0, 25.0],
    // 'suv': दर अजून मिळालेले नाहीत
  };

  // फ्रँचाईजी / चॅनल पार्टनर / Admin शहरासाठी दर बदलू शकतील (पुढे screen जोडू)
  static final Map<String, Map<String, List<double>>> _cityOverrides = {};

  static List<double>? ratesFor(String vehicle, {String? city}) {
    final c = city ?? defaultCity;
    final over = _cityOverrides[c]?[vehicle];
    return over ?? _defaults[vehicle];
  }

  static void setRates(String city, String vehicle, List<double> rates) {
    _cityOverrides.putIfAbsent(city, () => {});
    _cityOverrides[city]![vehicle] = rates;
  }

  static String labelOf(String key) {
    for (final v in vehicles) {
      if (v['key'] == key) return v['label']!;
    }
    return key;
  }

  // भाडे slab नुसार. दर न मिळाल्यास -1
  static int fare(String vehicle, double km, {String? city}) {
    final r = ratesFor(vehicle, city: city);
    if (r == null) return -1;
    double total = r[0];
    if (km > 2) total += ((km > 5 ? 5.0 : km) - 2) * r[1];
    if (km > 5) total += ((km > 10 ? 10.0 : km) - 5) * r[2];
    if (km > 10) total += (km - 10) * r[3];
    return total.round();
  }

  static List<String> chartLines(String vehicle, {String? city}) {
    final r = ratesFor(vehicle, city: city);
    if (r == null) return [];
    return [
      '0 ते 2 km: ₹${r[0].toStringAsFixed(0)} फिक्स',
      '2 ते 5 km: ₹${r[1].toStringAsFixed(0)} प्रति km',
      '5 ते 10 km: ₹${r[2].toStringAsFixed(0)} प्रति km',
      '10 km नंतर: ₹${r[3].toStringAsFixed(0)} प्रति km',
    ];
  }

  // रायडरच्या रिचार्जमधून प्रत्येक confirm केलेल्या राईडला कपात
  static const int rideFee = 5;
  static const int lowBalance = 20;
  static const double riderRadiusKm = 3;
}