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

Future<UserModel> getUserDetails(String email) async {
  final snapshot = await FirebaseFirestore.instance
      .collection("usersCollection")
      .where("email", isEqualTo: email)
      .get();

  if (snapshot.docs.isNotEmpty) {
    final userData = UserModel.fromSnapshot(snapshot.docs.first);
    return userData;
  } else {
    // Handle the case where no document matches the given email
    throw Exception("No user found with the provided email");
  }
}

}
