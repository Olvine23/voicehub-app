import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../repositories/authentication_repository.dart';

class SignupController extends GetxController{
  static SignupController get instance => Get.find();

  //TextField Controllers to get data from TextFields
  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();
  //Call this Function from Design & it will do the rest
  void registerUser(String email, String password) {
    AuthenticationRepository.instance.createUserWithEmailAndPassword(email, password);
     
  }



}