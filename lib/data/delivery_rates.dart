class DeliveryRates {
  // ZatPat आणि Hotel Food साठी एकच chart
  // 3 km ₹30, 5 km ₹45, 7 km ₹60, 10 km ₹100
  static int chargeForKm(double km) {
    if (km <= 3) return 30;
    if (km <= 5) return 45;
    if (km <= 7) return 60;
    return 100;
  }

  // दुकान/हॉटेलच्या किती km मधल्या बॉयना सूचना जाते
  static const double boyRadiusKm = 5;

  static const String chartText =
      '3 km ₹30 · 5 km ₹45 · 7 km ₹60 · 10 km ₹100';
}