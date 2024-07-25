class GiftCardModel {
  String title;
  String description;
  String imageUrl;
  String expiryDate;
  String quantity;
  bool status;
  String price;
  String gId;
  // List<String> codes;


  GiftCardModel({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.expiryDate,
    required this.quantity,
    required this.status,
    required this.price,
    required this.gId,
    // required this.codes
  });

  // Factory method to create a GiftCardModel object from JSON
  factory GiftCardModel.fromMap(Map<String, dynamic> json) {
    return GiftCardModel(
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      expiryDate: json['expiryDate'],
      quantity: json['quantity'] ?? '1',
      status: json['status'],
      price: json['price'],
      gId: json['gId'],
      // codes: json['codes'],
    );
  }

  // Method to convert a GiftCardModel object to JSON
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'expiryDate': expiryDate,
      'quantity': quantity,
      'status': status,
      'price': price,
      'gId' : gId,

    };
  }
}
