import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:voice_hub/core/colors.dart';
import 'package:voice_hub/models/poetry_model.dart';
import 'package:voice_hub/screens/home/home_screen.dart';
import 'package:voice_hub/services/authservice.dart';
 

class PoetryController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addPoem({
    
    required String title,
    required String imageUrl,
    required String body,
  }) async {
    try {

      final AuthService authService = AuthService();
      

      await _firestore.collection('poems').add(
        PoetryModel(
          uploadedBy: FirebaseAuth.instance.currentUser!.email.toString(),
          title: title,
          imageUrl: imageUrl,
          body: body,
        ).toMap(),
      );
      Get.snackbar("Success", "Your poem has been added successfully", backgroundColor: AppColors.primaryColor, colorText: Colors.white);

      Get.offAll(HomeScreen());
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }
}
