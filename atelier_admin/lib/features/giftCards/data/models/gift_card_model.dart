class GiftCardModel {
  String title;
  String description;
  String imageUrl;
  String expiryDate;
  String price;
  String gId;
  bool isPublic;
  String code;
  // List<String> codes;


  GiftCardModel({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.gId,
    required this.isPublic,
    required this.expiryDate,
    required this.code
    // required this.codes
  });

  // Factory method to create a GiftCardModel object from JSON
  factory GiftCardModel.fromMap(Map<String, dynamic> json) {
    return GiftCardModel(
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      price: json['price'],
      gId: json['gId'],
      isPublic: json['isPublic'],
        expiryDate:json['expiryDate'],
      code: json['code']
      // codes: json['codes'],
    );
  }

  // Method to convert a GiftCardModel object to JSON
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'gId' : gId,
      'isPublic' : isPublic,
      'expiryDate': expiryDate,
      'code' : code

    };
  }
}
