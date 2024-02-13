import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserController extends GetxController {
  RxMap userData = {}.obs; // RxMap to observe changes

 RxMap userProfile = {}.obs;

 void updateUserProfile(Map<String, dynamic> profile) {
    userProfile = profile.obs;
    update();
  }


  // Function to fetch user information
  Future<void> fetchUserData(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('users').doc(userId).get();

      // Update userData with the fetched data
      userData = snapshot.data().obs as RxMap;
    } catch (e) {
      // Handle error, e.g., show error message
      print("Error fetching user data: $e");
    }
  }
}
