import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:voice_hub/screens/auth/email_verification.dart';
import 'package:voice_hub/screens/auth/signin.dart';
import 'package:voice_hub/screens/home/home_screen.dart';
 
import 'package:voice_hub/screens/start_screen.dart';

class AuthenticationRepository extends GetxController {
   static AuthenticationRepository get instance => Get.find();
  //Variables
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  //Will be load when app launches this func will be called and set the firebaseUser state
  // @override
  // void onReady() {
  //   firebaseUser = Rx<User?>(_auth.currentUser);
  //   firebaseUser.bindStream(_auth.userChanges());
  //   ever(firebaseUser, _setInitialScreen);
  // }

  /// If we are setting initial screen from here
  /// then in the main.dart => App() add CircularProgressIndicator()
  // _setInitialScreen(User? user) {
  //   user == null
  //       ? Get.offAll(() => const StartScreen())
  //       : Get.offAll(() => HomeScreen());
  // }

   //FUNC
  Future<String?> createUserWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      Get.to(EmailVerificationScreen());
      // firebaseUser.value != null ? Get.offAll(() =>  const EmailVerificationScreen()) : Get.to(() => const StartScreen());
    } on FirebaseAuthException catch (e) {
      // final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      // return ex.message;/
    } catch (_) {
      // const ex = SignUpWithEmailAndPasswordFailure();
      // return ex.message;
    }
    return null;
  }

  Future<String?> signInWithEmailAndPassowrd(String email, String password ) async{
    print(email);
    print(password);
      try {
        await _auth
            .signInWithEmailAndPassword(
              email: email,
              password: password,
            )
            .then((value) {
              Get.off(HomeScreen());
              Get.back();
            } );
       print("sucess");
          
        
      } catch (_) {
        
      }
      return null;

  }
}
