class WorkshopModel {
  String title;
  String description;
  String imageUrl;
  String startDate;
  String startTime;  // Storing as HH:mm format string
  // String endDate;
  String endTime;    // Storing as HH:mm format string
  String ticketName;
  String location;
  // int? durationMinutes;
  String price;// Storing duration as total minutes
  String wId;
  int users;
  bool isPublic;

  WorkshopModel({
    required this.users,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.startDate,
    required this.startTime,
    // required this.endDate,
    required this.endTime,
    required this.ticketName,
    required this.location,
    // this.durationMinutes,
    required this.price,
    required this.wId,
    required this.isPublic
  });

  // Factory method to create a Workshop instance from a map (e.g., from JSON)
  factory WorkshopModel.fromMap(Map<String, dynamic> map) {
    return WorkshopModel(
        title: map['title'] ?? '',
        description: map['description'] ?? '',
        imageUrl: map['imageUrl'] ?? '',
        startDate: map['startDate'] ?? '',
        startTime: map['startTime'] ?? '',
        // endDate: map['endDate'] ?? '',
        endTime: map['endTime'] ?? '',
        ticketName: map['ticketName'] ?? '',
        location: map['location'] ?? '',
        // durationMinutes: map['durationMinutes'] ?? 0,
        price:  map['price'] ?? '',
        wId: map['wId'] ?? '',
        users: map['users'] ?? 0,
        isPublic: map['isPublic'] ?? false

    );
  }

  // Method to convert a Workshop instance to a map (e.g., for JSON)
  Map<String, dynamic> toMap() =>
      {
        'title': title,
        'description': description,
        'imageUrl': imageUrl,
        'startDate': startDate,
        'startTime': startTime,
        // 'endDate': endDate,
        'endTime': endTime,
        'ticketName': ticketName,
        'location': location,
        // 'durationMinutes': durationMinutes,
        'price' : price,
        'wId' : wId,
        'users' : users,
        'isPublic' : isPublic
      };

}
