import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:voice_hub/widgets/bottom_navbar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(FirebaseAuth.instance.currentUser?.uid);
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
      appBar: AppBar(
        title: Text('Voice Hub Home'),
      ),
      body: Center(
        child: Lottie.network('https://lottie.host/1bdf73fd-2d36-45ef-942e-c1237d61ea0a/sHHiV8hOoL.json'),
      ),
    );
  }
}
