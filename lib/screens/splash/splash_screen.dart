 import 'dart:async';

import 'package:flutter/material.dart';
 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      // Your other configurations...
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulating a delay (e.g., loading assets, data, etc.)
    Timer(Duration(seconds: 20), () {
      // Navigate to the next screen (e.g., home screen)
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Add your artistic visual (SVG or any image)
            const Image(
            image: NetworkImage(
                'https://images.pexels.com/photos/39348/musician-trumpet-metal-snowman-39348.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
          ),
          // Optional: You can overlay a logo or app name on top
          Positioned(
            top: 200.0,
            child: Text(
              'Voice Hub',
              style: TextStyle(
                fontSize: 32.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voice Hub Home'),
      ),
      body: Center(
        child: Text('Welcome to Voice Hub!'),
      ),
    );
  }
}
