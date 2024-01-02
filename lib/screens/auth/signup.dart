import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
 
import 'package:voice_hub/core/colors.dart';
import 'package:voice_hub/screens/auth/signin.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
        return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 12,
                ),
                   Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.greenWhite, // Shadow color
                        spreadRadius: 5, // Spread radius
                        blurRadius: 10, // Blur radius
                        offset: Offset(0, 5), // Offset
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Card(
                      borderOnForeground: false,
                      child: TextFormField(
                        decoration: InputDecoration(
          
                            prefixIcon: Icon(Icons.person,
                                    color: AppColors.darkGrey),
                            hintText: "Name",
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1.0,
                                )),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            errorBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red))),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.greenWhite, // Shadow color
                        spreadRadius: 5, // Spread radius
                        blurRadius: 10, // Blur radius
                        offset: Offset(0, 5), // Offset
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Card(
                      borderOnForeground: false,
                      child: TextFormField(
                        decoration: InputDecoration(
          
                            prefixIcon: Icon(Icons.email,
                                    color: AppColors.darkGrey),
                            hintText: "Email",
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1.0,
                                )),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            errorBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red))),
                      ),
                    ),
                  ),
                ),
                   Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.greenWhite, // Shadow color
                        spreadRadius: 5, // Spread radius
                        blurRadius: 10, // Blur radius
                        offset: Offset(0, 5), // Offset
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Card(
                      borderOnForeground: false,
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
          
                            prefixIcon: Icon(Icons.phone_android,
                                    color: AppColors.darkGrey),
                            hintText: "Phone Number",
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1.0,
                                )),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            errorBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red))),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.greenWhite, // Shadow color
                        spreadRadius: 5, // Spread radius
                        blurRadius: 10, // Blur radius
                        offset: Offset(0, 5), // Offset
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Card(
                      borderOnForeground: false,
                      child: TextFormField(
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.visibility_off),
                          prefixIcon: Icon(Icons.lock),
                            hintText: "Password",
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1.0,
                                )),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            errorBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red))),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 12,
                          ),
                        )),
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
          
                      minimumSize: const Size.fromHeight(60), //
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    )),
                    SizedBox(height: 20,),
                Row(
                  children: [
                    Checkbox(
                      value: value,
                      onChanged: (bool? value) {
                        setState(() {
                          this.value = value!;
                        });
                      },
                    ),
                    Text("I agree with the "),
                    Text(
                      "terms and conditions",
                      style: TextStyle(color: AppColors.primaryColor),
                    )
                  ],
                ),
                SizedBox(height: 20,),
                
                Center(
                  child: RichText(
                      text: TextSpan(
                    children: [
                      const TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(
                              color: Color.fromARGB(255, 65, 64, 64),
                              fontSize: 14)),
                      const TextSpan(text: '   '),
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignIn())),
                          text: 'Login',
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                    ],
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}