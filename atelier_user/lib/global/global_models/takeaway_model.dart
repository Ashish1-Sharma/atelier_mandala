class TakeawayModel {
  String title;
  String description;
  String imageUrl;
  String price;
  String date;
  // String category;
  int users;
  String tId;
  // String duration;
  // String quantity;
  String location;
  bool isPublic;
  List<dynamic> pickUpTimings;

  TakeawayModel({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    // required this.category,
    required this.date,
    required this.users,
    required this.tId,
    // required this.duration,/
    // required this.quantity,
    required this.location,
    required this.isPublic,
    required this.pickUpTimings
  });

  // Factory method to create an AddTakeaway object from JSON
  factory TakeawayModel.fromMap(Map<String, dynamic> json) {
    return TakeawayModel(
        title: json['title'],
        description: json['description'],
        imageUrl: json['imageUrl'],
        price: json['price'],
        // category: json['category'],
        date: json['date'],
        users: json['users'],
        tId: json['tId'],
        // duration: json['duration'],
        // quantity: json['quantity'],
        location: json['location'],
        isPublic: json['isPublic'],
        pickUpTimings: json['pickUpTimings']
    );
  }

  // Method to convert an AddTakeaway object to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      // 'category': category,
      'date': date,
      'users' : users,
      'tId' : tId,
      // 'duration' : duration,
      // 'quantity' : quantity,
      'location':location,
      'isPublic' : isPublic,
      'pickUpTimings' : pickUpTimings
    };
  }
}
