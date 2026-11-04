class ProductModel {
  final String id;
  final String sellerId;
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
  bool isPromoterAdd;

  // नवीन फील्ड्स (एरर दुरुस्तीसाठी)
  String brand;
  String sellerName;
  String image;
  double productWeight;
  String weightUnit;
  double shippingWeight;
  double packageLength;
  double packageWidth;
  double packageHeight;
  String dimensionUnit;
  String sku;
  int minimumOrderQty;
  int packageCount;
  double volumetricWeight;
  bool amoleDelivery;
  bool sellerSelfDelivery;
  bool courierDelivery;
  bool localDelivery;
  bool interCityDelivery;
  String processingTime;
  bool fragile;
  bool liquid;
  bool perishable;
  bool oversized;
  bool codEligible;
  bool reversePickup;

  ProductModel({
    required this.id,
    this.sellerId = '',
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
    this.isPromoterAdd = false,
    this.brand = '',
    this.sellerName = '',
    this.image = '',
    this.productWeight = 0,
    this.weightUnit = 'kg',
    this.shippingWeight = 0,
    this.packageLength = 0,
    this.packageWidth = 0,
    this.packageHeight = 0,
    this.dimensionUnit = 'cm',
    this.sku = '',
    this.minimumOrderQty = 1,
    this.packageCount = 1,
    this.volumetricWeight = 0,
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
}