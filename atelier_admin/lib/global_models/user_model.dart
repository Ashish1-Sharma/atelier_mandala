import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final bool image;
  final String name;
  final String email;
  final DateTime time;
  UserModel({
    required this.name,
    required this.email,
    required this.time,
    required this.image,
  });

  Map<String, dynamic> toJson() => {
        'image': image,
        'name': name,
        'email': email,
        'time': time,
      };
}
