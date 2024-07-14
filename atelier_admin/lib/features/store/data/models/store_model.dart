class StoreModel {
  String title;
  String description;
  String imageUrl;
  String price;
  int stockQuantity;
  List<String> tags;
  String time;

  StoreModel({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.stockQuantity,
    required this.tags,
    required this.time,
  });

  // Factory method to create a StoreModel object from JSON
  factory StoreModel.fromMap(Map<String, dynamic> json) {
    return StoreModel(
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      price: json['price'],
      stockQuantity: json['stockQuantity'],
      tags: List<String>.from(json['tags']),
      time: json['time'],
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
      'tags': tags,
      'time': time,
    };
  }
}
