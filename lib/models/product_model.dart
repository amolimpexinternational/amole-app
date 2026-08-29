class ProductModel {
  String id;
  String name;
  double mrp;
  double discount;
  int stock;
  String category;
  String image;
  String description;
  String keywords;
  bool isActive;
  bool isReturnable;
  bool deliveryAvailable;

  ProductModel({
    required this.id,
    required this.name,
    required this.mrp,
    this.discount = 0,
    required this.stock,
    required this.category,
    this.image = '',
    this.description = '',
    this.keywords = '',
    this.isActive = true,
    this.isReturnable = true,
    this.deliveryAvailable = true,
  });

  double get sellingPrice => mrp - (mrp * discount / 100);
  double get price => sellingPrice;
}
