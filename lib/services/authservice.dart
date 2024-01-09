import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:voice_hub/screens/profile/profile_screen.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
        // Retrieve user details from Firestore
  Future<Map<String, dynamic>?> getCurrentUserDetails() async {
    User? user = _auth.currentUser;

    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

      return snapshot.data();
    }

    return null;
  }

  Future<void> register({
    required String email,
    required String password,
    required String nickname,
    required String bio,
 
    required String phone
  }) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await FirebaseFirestore.instance.collection('users').doc(userCredential.user?.uid).set({
        'id':userCredential.user?.uid,
        'email': email,
        'nickname': nickname,
        'bio': bio,
        'phone':phone,
        // Add more user details as needed
      });

      // If needed, you can perform additional actions after registration.
      Get.off(ProfileScreen());

      Get.snackbar("Success", "Registration successful!",
          snackPosition: SnackPosition.BOTTOM);

      
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }


  }
}
