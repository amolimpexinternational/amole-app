enum SubscriptionType {
  free,
  premium,
}

class SubscriptionModel {
  final SubscriptionType type;

  final int productLimit;

  final bool customerDataAccess;

  final bool bulkMessaging;

  final bool targetedAds;

  final int freeAdsPerYear;

  final bool analyticsAccess;

  const SubscriptionModel({
    required this.type,
    required this.productLimit,
    required this.customerDataAccess,
    required this.bulkMessaging,
    required this.targetedAds,
    required this.freeAdsPerYear,
    required this.analyticsAccess,
  });

  static const freePlan = SubscriptionModel(
    type: SubscriptionType.free,
    productLimit: 10,
    customerDataAccess: false,
    bulkMessaging: false,
    targetedAds: false,
    freeAdsPerYear: 0,
    analyticsAccess: false,
  );

  static const premiumPlan = SubscriptionModel(
    type: SubscriptionType.premium,
    productLimit: 100,
    customerDataAccess: true,
    bulkMessaging: true,
    targetedAds: true,
    freeAdsPerYear: 2,
    analyticsAccess: true,
  );
}
