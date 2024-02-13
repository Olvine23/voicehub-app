// bio_preferences_screen.dart
 

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:voice_hub/screens/home/home_screen.dart';
import 'package:voice_hub/services/authservice.dart';
import 'package:voice_hub/widgets/custom_elevated_button.dart';

import '../../core/colors.dart';

class BioPreferencesScreen extends StatelessWidget {
  final TextEditingController bioController = TextEditingController();
  final TextEditingController preferencesController = TextEditingController();
  // final AuthService authService = Get.find();
  final AuthService authServiceController = Get.put(AuthService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bio & Preferences'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  child: Lottie.asset('assets/lotti/profile.json')),
              Text(
                'Tell us more about yourself',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextField(
                controller: bioController,
                decoration: InputDecoration(
                  labelText: 'Bio',
                  hintText: 'Write a short bio...',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 20),
              Text(
                'What are your preferences? ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextField(
                controller: preferencesController,
                decoration: InputDecoration(
                  hintText:
                      'Do you prefer writing or reading? What are your favorite genres? ',
                ),
                maxLines: 2,
              ),

              Padding(
                padding:  EdgeInsets.only(top: 40),
                child: CustomElevatedButton(
                  onPressed: () {
                    submitForm();
                  },
                    text: "Submit",
                    beginColor: AppColors.primaryColor,
                    endColor: AppColors.darkBlue,
                    textColor: Colors.white),

              )

              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //       backgroundColor: AppColors.primaryColor),
              //   onPressed: () {
              //     submitForm();
              //   },
              //   child: Text(
              //     'Submit',
              //     style: TextStyle(color: Colors.white),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  void submitForm() async {
    // Get the current user's UID
    String? uid = FirebaseAuth.instance.currentUser!.uid;

    if (uid != null) {
      // Update user details in Firestore
      await authServiceController.updateUserDetails(
        uid: uid,
        bio: bioController.text,
        preferences: preferencesController.text.trim(),
      );

      Get.snackbar(
        "Success",
        "Details updated successfully.",
      );
     
      // Navigate back to the previous screen
      Get.offAll(HomeScreen());
    } else {
      // Handle the case where the UID is null (user not logged in)
      Get.snackbar("Error", "User not logged in.",
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
