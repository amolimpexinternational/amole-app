class BusinessProfileModel {
  final String businessId;

  final String businessName;
  final String ownerName;

  final String category;
  final String description;

  final String phone;
  final String email;
  final String website;

  final String address;
  final String village;
  final String taluka;
  final String district;
  final String state;
  final String pinCode;

  final String openingTime;
  final String closingTime;

  final bool homeDelivery;
  final bool onlineOrder;

  final String logo;
  final List<String> gallery;

  BusinessProfileModel({
    required this.businessId,
    required this.businessName,
    required this.ownerName,
    required this.category,
    required this.description,
    required this.phone,
    required this.email,
    required this.website,
    required this.address,
    required this.village,
    required this.taluka,
    required this.district,
    required this.state,
    required this.pinCode,
    required this.openingTime,
    required this.closingTime,
    required this.homeDelivery,
    required this.onlineOrder,
    required this.logo,
    required this.gallery,
  });
}
