import '../models/product_model.dart';

class ProductDatabase {
  static final List<ProductModel> products = [
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

  static void addProduct(ProductModel product) {
    products.add(product);
  }

  static void deleteProduct(String id) {
    products.removeWhere((p) => p.id == id);
  }

  static void updateProduct(ProductModel updatedProduct) {
    final index =
        products.indexWhere((p) => p.id == updatedProduct.id);

    if (index != -1) {
      products[index] = updatedProduct;
    }
  }

  static ProductModel? getProduct(String id) {
    try {
      return products.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }
}
