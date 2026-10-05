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

  // Seller information
  String sellerId;
  String sellerName;
  String brand;
  String sku;

  // Order / quantity
  int minimumOrderQty;

  // Weight information
  double productWeight;
  String weightUnit;
  double shippingWeight;
  int packageCount;

  // Package dimensions
  double packageLength;
  double packageWidth;
  double packageHeight;
  String dimensionUnit;

  // Delivery / transport eligibility
  bool isActive;
  bool isReturnable;
  bool deliveryAvailable;
  bool amoleDelivery;
  bool sellerSelfDelivery;
  bool courierDelivery;
  bool localDelivery;
  bool interCityDelivery;
  String processingTime;

  // Special handling / delivery calculation factors
  bool fragile;
  bool liquid;
  bool perishable;
  bool oversized;
  bool codEligible;
  bool reversePickup;

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

    this.sellerId = '',
    this.sellerName = '',
    this.brand = '',
    this.sku = '',

    this.minimumOrderQty = 1,

    this.productWeight = 0,
    this.weightUnit = 'g',
    this.shippingWeight = 0,
    this.packageCount = 1,

    this.packageLength = 0,
    this.packageWidth = 0,
    this.packageHeight = 0,
    this.dimensionUnit = 'cm',

    this.isActive = true,
    this.isReturnable = true,
    this.deliveryAvailable = true,
    this.amoleDelivery = true,
    this.sellerSelfDelivery = false,
    this.courierDelivery = true,
    this.localDelivery = true,
    this.interCityDelivery = true,
    this.processingTime = '1-2 दिवस',

    this.fragile = false,
    this.liquid = false,
    this.perishable = false,
    this.oversized = false,
    this.codEligible = true,
    this.reversePickup = true,
  });

  double get sellingPrice => mrp - (mrp * discount / 100);

  double get price => sellingPrice;

  double get volumetricWeight {
    if (packageLength <= 0 ||
        packageWidth <= 0 ||
        packageHeight <= 0) {
      return 0;
    }

    return (packageLength * packageWidth * packageHeight) / 5000;
  }
}
