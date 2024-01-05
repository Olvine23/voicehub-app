import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voice_hub/models/user_model.dart';
import 'package:voice_hub/repositories/user_repository/user_repository.dart';
import 'package:voice_hub/screens/home/home_screen.dart';

import '../repositories/authentication_repository.dart';

class SignupController extends GetxController{
  static SignupController get instance => Get.find();

  //TextField Controllers to get data from TextFields
  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();

  final userRepo = Get.put(UserRepository());
  
    Future<void> createUser(UserModel user)  async{
   
    registerUser(user.email, user.password);
    print(FirebaseAuth.instance.currentUser?.uid);
    await userRepo.createUser(user);
    Get.to(HomeScreen());
  }

  //Call this Function from Design & it will do the rest
  void registerUser(String email, String password) {
    AuthenticationRepository.instance.createUserWithEmailAndPassword(email, password);
     
  }



}