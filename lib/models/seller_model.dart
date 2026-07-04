class SellerModel {
  final String sellerId;
  final String businessName;
  final String ownerName;

  final String category;

  final String phone;
  final String email;

  final String address;
  final String village;
  final String taluka;
  final String district;
  final String state;
  final String pinCode;

  final String gstNumber;

  final String subscription;

  final bool kycVerified;

  final String qrCode;

  final String publicUrl;

  final int productLimit;

  SellerModel({
    required this.sellerId,
    required this.businessName,
    required this.ownerName,
    required this.category,
    required this.phone,
    required this.email,
    required this.address,
    required this.village,
    required this.taluka,
    required this.district,
    required this.state,
    required this.pinCode,
    required this.gstNumber,
    required this.subscription,
    required this.kycVerified,
    required this.qrCode,
    required this.publicUrl,
    required this.productLimit,
  });
}
