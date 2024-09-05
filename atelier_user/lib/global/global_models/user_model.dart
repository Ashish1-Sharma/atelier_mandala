class UserModel {
  final String name;
  final String email;
  final String uid;
  final String img;


  UserModel({
    required this.name,
    required this.email,
    required this.uid,
    required this.img,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      uid: json['uid'],
      img: json['img'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'uid': uid,
      'img': img,
    };
  }
}

