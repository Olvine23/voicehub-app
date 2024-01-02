import 'package:flutter/material.dart';
 

class GlobalMethod {
  static void showErrorDialog(
      {required String error, required BuildContext ctx}) {
    showDialog(
        context: ctx,
        builder: (context) {
          return AlertDialog(
            backgroundColor: const Color.fromARGB(255, 3, 115, 128),
            title: Column(
              children: [
                Container(
                  height: 80,
                  child:  Text("gfsgfs")
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Error Occurred",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            content: Text(
              error,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.canPop(context) ? Navigator.pop(context) : null;
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          );
        });
  }
}

// class Utils {
//   static final messengerKey = GlobalKey<ScaffoldMessengerState>();

//   static showSnackBar(String? text) {
//     if (text == null) return;
//     final snackBar =
//         SnackBar(content: Text(text), backgroundColor: Colors.white);

//     messengerKey.currentState!
//       ..removeCurrentSnackBar()
//       ..showSnackBar(snackBar);
//   }
// }
