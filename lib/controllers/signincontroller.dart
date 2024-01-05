import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voice_hub/repositories/authentication_repository.dart';

class SignInController extends GetxController{
  static SignInController get instance => Get.find();
   final email = TextEditingController();
  final password = TextEditingController();

  void signInUser(String email, String password){
    AuthenticationRepository.instance.signInWithEmailAndPassowrd(email, password);
  }

}