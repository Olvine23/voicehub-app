import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:voice_hub/screens/auth/signin.dart';
import 'package:voice_hub/screens/home/home_screen.dart';

class UserState extends StatelessWidget {
  const UserState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, userSnapshot) {
          if (userSnapshot.data == null) {
            if (kDebugMode) {
              print('user is not logged in yet');
            }
            return const  SigninScreen();
          } else if (userSnapshot.hasData) {
            if (kDebugMode) {
              print('user is already logged in');
            }
            // return ComingSoon();
            return HomeScreen();
          } else if (userSnapshot.hasError) {
            return const Scaffold(
              body:
                  Center(child: Text('An error has occurred, try again later')),
            );
          } else if (userSnapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          return const Scaffold(
            body: Center(
              child: Text('Something went wrong'),
            ),
          );
        });
  }
}
