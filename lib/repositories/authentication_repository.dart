import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:voice_hub/screens/splash/splash_screen.dart';
import 'package:voice_hub/screens/start_screen.dart';

class AuthenticationRepository extends GetxController {
   static AuthenticationRepository get instance => Get.find();
  //Variables
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  //Will be load when app launches this func will be called and set the firebaseUser state
  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  /// If we are setting initial screen from here
  /// then in the main.dart => App() add CircularProgressIndicator()
  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const StartScreen())
        : Get.offAll(() => HomeScreen());
  }

   //FUNC
  Future<String?> createUserWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      firebaseUser.value != null ? Get.offAll(() =>  HomeScreen()) : Get.to(() => const StartScreen());
    } on FirebaseAuthException catch (e) {
      // final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      // return ex.message;
    } catch (_) {
      // const ex = SignUpWithEmailAndPasswordFailure();
      // return ex.message;
    }
    return null;
  }
}
