class TakeawayItemModel {
  String code;
  bool usedOrNot;
  String userId;
  String redeemTime;

  TakeawayItemModel({
    required this.code,
    required this.usedOrNot,
    required this.userId,
    required this.redeemTime,
  });

  factory TakeawayItemModel.fromJson(Map<String, dynamic> json) {
    return TakeawayItemModel(
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
