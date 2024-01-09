import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:voice_hub/models/poetry_model.dart';
 

class PoetryController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addPoem({
    required String title,
    required String imageUrl,
    required String body,
  }) async {
    try {
      await _firestore.collection('poems').add(
        PoetryModel(
          uploadedBy: FirebaseAuth.instance.currentUser!.email.toString(),
          title: title,
          imageUrl: imageUrl,
          body: body,
        ).toMap(),
      );
      Get.snackbar("Success", "Your poem has been added successfull?");
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }
}
