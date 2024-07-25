class StoreModel {
  String title;
  String description;
  String imageUrl;
  String price;
  String stockQuantity;
  int users;
  String sId;
  String date;

  StoreModel({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.stockQuantity,
    required this.sId,
    required this.users,
    required this.date
  });

  // Factory method to create a StoreModel object from JSON
  factory StoreModel.fromMap(Map<String, dynamic> json) {
    return StoreModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      price: json['price'] ?? '',
      stockQuantity: json['stockQuantity'] ?? '0',
      sId: json['sId'] ?? '',
      users: json['users'] ?? 0,
      date: json['date'] ?? '',
    );
  }

  // Method to convert a StoreModel object to JSON
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'stockQuantity': stockQuantity,
      'sId' : sId,
      'users' : users,
      'date' : date
    };
  }
}
