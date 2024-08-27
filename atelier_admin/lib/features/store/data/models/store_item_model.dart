class StoreItemModel {
  String code;
  bool usedOrNot;
  String userId;
  String redeemTime;

  StoreItemModel({
    required this.code,
    required this.usedOrNot,
    required this.userId,
    required this.redeemTime,
  });

  factory StoreItemModel.fromJson(Map<String, dynamic> json) {
    return StoreItemModel(
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
