import '../models/product_model.dart';

class ProductDatabase {
  static List<ProductModel> products = [
    ProductModel(
      id: '1',
      name: 'Organic Mango',
      price: 850,
      stock: 50,
      category: 'Fruits',
    ),
    ProductModel(
      id: '2',
      name: 'Fresh Onion',
      price: 35,
      stock: 300,
      category: 'Vegetables',
    ),
    ProductModel(
      id: '3',
      name: 'Turmeric Powder',
      price: 240,
      stock: 80,
      category: 'Spices',
    ),
  ];
}
