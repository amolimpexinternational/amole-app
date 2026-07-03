class ProductModel {
  String id;
  String name;
  double price;
  int stock;
  String category;
  String image;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
    required this.category,
    this.image = '',
  });
}
