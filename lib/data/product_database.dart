import '../models/product_model.dart';

class ProductDatabase {
  static final List<ProductModel> products = [
    ProductModel(id: '1', name: 'Organic Mango', mrp: 850, stock: 50, category: 'FV', description: 'ताजे आंबे', keywords: 'mango, आंबा, फळे', isActive: true),
    ProductModel(id: '2', name: 'Fresh Onion', mrp: 35, stock: 300, category: 'FV', description: 'ताजा कांदा', keywords: 'onion, कांदा, भाजीपाला', isActive: true),
    ProductModel(id: '3', name: 'Turmeric Powder', mrp: 240, discount: 5, stock: 80, category: 'GR', description: 'शुद्ध हळद', keywords: 'turmeric, हळद, मसाले', isActive: true),
    ProductModel(id: '4', name: 'Basmati Rice', mrp: 120, discount: 10, stock: 0, category: 'GR', description: 'बासमती तांदूळ', keywords: 'rice, तांदूळ', isActive: false),
  ];

  static void addProduct(ProductModel product) => products.add(product);
  static void deleteProduct(String id) => products.removeWhere((p) => p.id == id);
  static void updateProduct(ProductModel updated) {
    final i = products.indexWhere((p) => p.id == updated.id);
    if (i != -1) products[i] = updated;
  }
  static ProductModel? getProduct(String id) {
    try { return products.firstWhere((p) => p.id == id); } catch (_) { return null; }
  }
}
