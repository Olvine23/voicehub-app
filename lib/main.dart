import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voice_hub/bindings/image_controller_binding.dart';
import 'package:voice_hub/core/colors.dart';
import 'package:voice_hub/repositories/authentication_repository.dart';
import 'package:voice_hub/screens/start_screen.dart';
import 'package:voice_hub/services/api/firebase_api.dart';
import 'package:voice_hub/user_state.dart';
import 'firebase_options.dart';
 

Future<void> main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotifications();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: ImageControllerBinding(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        textTheme: GoogleFonts.ebGaramondTextTheme(),
        useMaterial3: true,
      ),
      home: const UserState(),
      // home: const UserState(),
    );
  }
}

 