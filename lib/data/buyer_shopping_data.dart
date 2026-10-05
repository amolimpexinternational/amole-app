class BuyerShoppingData {
  static final List<Map<String, dynamic>> cartItems = [
    {
      'id': 'श्री गणेश किराणा|तांदूळ 5kg',
      'name': 'तांदूळ 5kg',
      'price': 250.0,
      'qty': 2,
      'seller': 'श्री गणेश किराणा',
      'description': 'दर्जेदार तांदूळ',
      'image': '',
      'mrp': 280.0,
      'discount': 11,
      'stock': 20,
      'deliveryAvailable': true,
      'isReturnable': true,
    },
    {
      'id': 'साई किराणा स्टोअर|ताज्या टोमॅटो',
      'name': 'ताज्या टोमॅटो',
      'price': 30.0,
      'qty': 5,
      'seller': 'साई किराणा स्टोअर',
      'description': 'ताजे स्थानिक टोमॅटो',
      'image': '',
      'mrp': 35.0,
      'discount': 14,
      'stock': 50,
      'deliveryAvailable': true,
      'isReturnable': false,
    },
    {
      'id': 'महालक्ष्मी जनरल स्टोअर|नैसर्गिक मध',
      'name': 'नैसर्गिक मध',
      'price': 450.0,
      'qty': 1,
      'seller': 'महालक्ष्मी जनरल स्टोअर',
      'description': 'शुद्ध नैसर्गिक मध',
      'image': '',
      'mrp': 500.0,
      'discount': 10,
      'stock': 10,
      'deliveryAvailable': true,
      'isReturnable': true,
    },
  ];

  static final List<Map<String, dynamic>> favouriteItems = [
    {
      'id': 'fav-turmeric',
      'name': 'हळद पावडर',
      'price': 228.0,
      'seller': 'राज किराणा',
      'description': 'शुद्ध हळद पावडर',
      'image': '',
      'mrp': 240.0,
      'discount': 5,
      'stock': 80,
      'deliveryAvailable': true,
      'isReturnable': true,
    },
    {
      'id': 'fav-dal',
      'name': 'डाळ 1kg',
      'price': 120.0,
      'seller': 'महालक्ष्मी जनरल स्टोअर',
      'description': 'दर्जेदार डाळ',
      'image': '',
      'mrp': 130.0,
      'discount': 8,
      'stock': 30,
      'deliveryAvailable': true,
      'isReturnable': true,
    },
  ];

  static void addToCart({
    required String id,
    required String name,
    required double price,
    required int qty,
    required String seller,
    String description = '',
    String image = '',
    double mrp = 0,
    double discount = 0,
    int stock = 0,
    bool deliveryAvailable = true,
    bool isReturnable = true,
  }) {
    final index = cartItems.indexWhere((item) => item['id'] == id);

    if (index >= 0) {
      final currentQty = cartItems[index]['qty'] as int;
      cartItems[index]['qty'] = currentQty + qty;
    } else {
      cartItems.add({
        'id': id,
        'name': name,
        'price': price,
        'qty': qty,
        'seller': seller,
        'description': description,
        'image': image,
        'mrp': mrp > 0 ? mrp : price,
        'discount': discount,
        'stock': stock,
        'deliveryAvailable': deliveryAvailable,
        'isReturnable': isReturnable,
      });
    }
  }

  static void removeFromCart(String id) {
    cartItems.removeWhere((item) => item['id'] == id);
  }

  static void changeCartQuantity(String id, int delta) {
    final index = cartItems.indexWhere((item) => item['id'] == id);

    if (index == -1) return;

    final currentQty = cartItems[index]['qty'] as int;
    final stock = cartItems[index]['stock'] as int;

    final newQty = currentQty + delta;

    if (newQty < 1) return;
    if (stock > 0 && newQty > stock) return;

    cartItems[index]['qty'] = newQty;
  }

  static bool isFavourite(String id) {
    return favouriteItems.any((item) => item['id'] == id);
  }

  static void addToFavourite(Map<String, dynamic> item) {
    if (!isFavourite(item['id'] as String)) {
      favouriteItems.add(Map<String, dynamic>.from(item));
    }
  }

  static void removeFromFavourite(String id) {
    favouriteItems.removeWhere((item) => item['id'] == id);
  }

  static void toggleFavourite(Map<String, dynamic> item) {
    final id = item['id'] as String;

    if (isFavourite(id)) {
      removeFromFavourite(id);
    } else {
      addToFavourite(item);
    }
  }

  static int get cartCount {
    return cartItems.fold<int>(
      0,
      (sum, item) => sum + (item['qty'] as int),
    );
  }

  static int get favouriteCount => favouriteItems.length;

  static double get cartSubtotal {
    return cartItems.fold<double>(
      0,
      (sum, item) =>
          sum + ((item['price'] as double) * (item['qty'] as int)),
    );
  }

  static void clearCart() {
    cartItems.clear();
  }
}
