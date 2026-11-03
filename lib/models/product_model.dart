class ProductModel {
  final String id;
  String name;
  double mrp;
  double discount;
  int stock;
  String category;
  String description;
  String keywords;
  bool isActive;
  bool isReturnable;
  bool deliveryAvailable;
  bool isPromoterAdd; // नवीन ॲड केलेले फील्ड

  ProductModel({
    required this.id,
    required this.name,
    required this.mrp,
    required this.discount,
    required this.stock,
    required this.category,
    required this.description,
    required this.keywords,
    this.isActive = true,
    this.isReturnable = true,
    this.deliveryAvailable = false,
    this.isPromoterAdd = false, // डिफॉल्ट false
  });

  // ग्राहकाला दिसणारी किंमत (Selling Price)
  double get sellingPrice => mrp - (mrp * discount / 100);

  // (पुढील टप्प्यात तुम्ही इथे इमेजेस, कॅटेगरी डिटेल्स इत्यादी ॲड करू शकता)
}