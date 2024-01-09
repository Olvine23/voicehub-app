import 'package:get/get.dart';
import 'package:voice_hub/repositories/authentication_repository.dart';
import 'package:voice_hub/repositories/user_repository/user_repository.dart';

class ProfileController extends GetxController{
  static ProfileController get instance => Get.find();
   
  final authRepo = Get.put(AuthenticationRepository());
  final userRepo = Get.put(UserRepository());


  getUserData(){

    final email = authRepo.firebaseUser.value!.email;
    if(email !=  null){

    return userRepo.getUserDetails(email);
      
    } else{
      Get.snackbar("Error", "Login to proceed");
    }
    
  }

}