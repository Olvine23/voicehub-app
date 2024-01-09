import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voice_hub/services/authservice.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: currentUserDetails != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Email: ${currentUserDetails!['email']}'),
                  Text('Nickname: ${currentUserDetails!['nickname']}'),
                  Text('Bio: ${currentUserDetails!['bio']}'),
                  Text('Preferences: ${currentUserDetails!['phone']}'),
                  // Add more details as needed
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
