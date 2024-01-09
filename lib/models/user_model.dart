import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String fullName;
  final String email;
  final String password;
  final String profileImage;
  final String authorType;
  final String preferences;
  final String bio;

  UserModel({
    this.id,
    required this.authorType,
    required this.fullName,
    required this.profileImage,
    required this.bio,
    required this.preferences,
    required this.email,
    required this.password,
  });

  toJson() {
    return {
      "fullName": fullName,
      "id": id,
      "email": email,
      "profileImage": profileImage,
      "authorType": authorType,
      "preferences": preferences,
      "bio": bio
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return UserModel(
        id: document.id,
        authorType: data!["authorType"],
        fullName: data["fullName"],
        profileImage: data["profileImage"],
        bio: data["bio"],
        preferences: data["preferences"],
        email: data["email"],
        password: data["password"]);
  }
}
