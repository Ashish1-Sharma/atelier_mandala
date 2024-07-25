class UserModel {
  final String name;
  final String email;
  final String uid;
  final String img;
  final List<String> wIds;
  final List<String> tIds;
  final List<String> sIds;
  final List<String> gIds;

  UserModel({
    required this.name,
    required this.email,
    required this.uid,
    required this.img,
    required this.wIds,
    required this.tIds,
    required this.sIds,
    required this.gIds,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      uid: json['uid'],
      img: json['img'],
      wIds: List<String>.from(json['wIds']),
      tIds: List<String>.from(json['tIds']),
      sIds: List<String>.from(json['sIds']),
      gIds: List<String>.from(json['gIds']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'uid': uid,
      'img': img,
      'wIds': wIds,
      'tIds': tIds,
      'sIds': sIds,
      'gIds': gIds,
    };
  }
}

