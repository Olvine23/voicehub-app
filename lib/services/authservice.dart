import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:voice_hub/controllers/image_controller.dart';
import 'package:voice_hub/core/colors.dart';
import 'package:voice_hub/screens/home/home_screen.dart';

import 'package:voice_hub/screens/profile/profile_screen.dart';
import 'package:voice_hub/screens/profile/setup_profile.dart';
import 'package:voice_hub/widgets/loading_screen.dart';

class AuthService {
  final ImageController imageController =
      Get.find(); // Access the ImageController
  File? imageFile;
  String? imageUrl;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Retrieve user details from Firestore
  Future<Map<String, dynamic>?> getCurrentUserDetails() async {
    User? user = _auth.currentUser;

    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(user.uid)
          .get();

      return snapshot.data();
    }

    return null;
  }

  void showImageDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Please choose an option'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    getFromCamera(context);
                  },
                  child: Row(children: const [
                    Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.camera,
                          color: const Color.fromARGB(255, 3, 115, 128),
                        )),
                    Text(
                      'Camera',
                      style: const TextStyle(fontSize: 20, color: Colors.black),
                    )
                  ]),
                ),
                const SizedBox(height: 5),
                InkWell(
                  onTap: () {
                    getFromGallery(context);
                  },
                  child: Row(children: const [
                    Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.image,
                          color: Color.fromARGB(255, 3, 115, 128),
                        )),
                    Text(
                      'Gallery',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    )
                  ]),
                ),
              ],
            ),
          );
        });
  }

  void getFromCamera(BuildContext context) async {
    XFile? PickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    Navigator.pop(context);
  }

  void getFromGallery(BuildContext context) async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageController.setImageFile(File(pickedFile.path));
      print(imageController.getImageFile);
    } else {
      print("Image not picked");
    }

    Navigator.pop(context);
  }

  Future<void> updateUserDetails({
    required String uid,
    required String bio,
    required String preferences,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'bio': bio,
        'preferences': preferences,
      });

      Get.back();
    } catch (e) {
      Get.snackbar("Error", "Failed to update details.",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> register(
      {required String email,
      required String password,
      required String nickname,
      required String bio,
      required String preferences,
      required String phone}) async {
    try {
      Get.to(LoadingScreen());
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Use the ImageController to get the selected image
      File? imageFile = imageController.getImageFile;

      if (imageFile != null) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('userImages')
            .child('${userCredential.user?.uid}.jpg');
        await ref.putFile(imageFile);
        imageUrl = await ref.getDownloadURL();
        print(imageUrl);
      } else {
        print("Image not picked");
      }

      final ref = FirebaseStorage.instance
          .ref()
          .child('userImages')
          .child('${userCredential.user?.uid}.jpg');
      //.child(uid + '.jpg');
      await ref.putFile(imageFile!);
      imageUrl = await ref.getDownloadURL();
      print(imageUrl);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user?.uid)
          .set({
        'id': userCredential.user?.uid,
        'email': email,
        'nickname': nickname,
        'bio': bio,
        'phone': phone,
        'image': imageUrl
        // Add more user details as needed
      });

      // If needed, you can perform additional actions after registration.
      Get.off(BioPreferencesScreen());

      Get.snackbar("Success", "Registration successful!",
          backgroundColor: AppColors.primaryColor,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }
}
