import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi{

  final _firebaseMessaging = FirebaseMessaging.instance;
  
  //initialize notifications

  Future<void> initNotifications() async{

    await _firebaseMessaging.requestPermission();

    //fetch token
    final fCMToken = await _firebaseMessaging.getToken();

    print("Token >>>> $fCMToken");



  }

}