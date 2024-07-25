class CouponCodesModel {
  String code;
  bool usedOrNot;
  String userId;
  String redeemTime;

  CouponCodesModel({
    required this.code,
    required this.usedOrNot,
    required this.userId,
    required this.redeemTime,
  });

  factory CouponCodesModel.fromJson(Map<String, dynamic> json) {
    return CouponCodesModel(
      usedOrNot: json['usedOrNot'],
      userId: json['userId'],
      redeemTime: json['redeemTime'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'usedOrNot': usedOrNot,
      'userId': userId,
      'redeemTime': redeemTime,
      'code' : code
    };
  }
}
