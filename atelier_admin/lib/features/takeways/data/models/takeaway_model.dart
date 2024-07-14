class TakeawayModel {
  String title;
  String description;
  String imageUrl;
  String price;
  String date;
  String category;

  TakeawayModel({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.category,
    required this.date,
  });

  // Factory method to create an AddTakeaway object from JSON
  factory TakeawayModel.fromMap(Map<String, dynamic> json) {
    return TakeawayModel(
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      price: json['price'],
      category: json['category'], date: json['date'],
    );
  }

  // Method to convert an AddTakeaway object to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'category': category,
      'date': date,
    };
  }
}
