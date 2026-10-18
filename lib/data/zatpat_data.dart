class ZatPatData {
  // Demo: ज्या दुकानदाराने 'Add delivery partner' बदलले त्याची नोंद.
  // खरा डेटा Stage 3 मध्ये Firestore मधून येईल.
  static const String demoSeller = 'श्री गणेश किराणा';
  static final Map<String, bool> _overrides = {};

  static bool isOn(String seller, bool defaultValue) =>
      _overrides[seller] ?? defaultValue;

  static void setOn(String seller, bool value) {
    _overrides[seller] = value;
  }
}