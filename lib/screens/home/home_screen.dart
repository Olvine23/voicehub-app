import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:voice_hub/controllers/profilecontroller.dart';
import 'package:voice_hub/screens/poems/add_poem.dart';
import 'package:voice_hub/screens/poems/poem_detail.dart';
import 'package:voice_hub/screens/poems/poems_list_screen.dart';
import 'package:voice_hub/services/authservice.dart';
import 'package:voice_hub/widgets/bottom_navbar.dart';

import '../../models/user_model.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   final AuthService authService = AuthService();

  Map<String, dynamic>? currentUserDetails;

  @override
  void initState() {
    super.initState();
    loadCurrentUserDetails();
  }

  Future<void> loadCurrentUserDetails() async {
    Map<String, dynamic>? details = await authService.getCurrentUserDetails();

    setState(() {
      currentUserDetails = details;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(currentUserDetails?['email']);
      print(currentUserDetails?['phone']);
    print(FirebaseAuth.instance.currentUser?.uid);
    var user = FirebaseAuth.instance.currentUser?.email;
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
      appBar: AppBar(
        title: Text('Voice Hub Home'),
      ),
      body:  Center(child: 
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Logged in as ... $user"),
          ElevatedButton(onPressed: (){

            Get.to(AddPoemScreen());

          }, child: Text("Add a poem")),

           ElevatedButton(onPressed: (){

            Get.to(PoemListScreen());

          }, child: Text("See poems")),

           ElevatedButton(onPressed: (){

            Get.to(RealTimePoemListScreen());

          }, child: Text("See other poems"))
        ],
      ),)
    );
  }
}
