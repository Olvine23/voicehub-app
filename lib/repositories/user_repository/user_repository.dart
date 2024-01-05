import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:voice_hub/models/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

 

   Future<void> createUser(UserModel user) async {
    try {
      await FirebaseFirestore.instance.collection('usersCollection').add(user.toJson());
      Get.snackbar("Success", "Account created");
    } catch (error, stackTrace) {
      print("Error creating user: $error");
      print("Stack trace: $stackTrace");
      Get.snackbar("Error", "An error occurred while creating the account");
    }
  }
}
