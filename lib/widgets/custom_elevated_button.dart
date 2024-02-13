import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final Color beginColor;
  final Color endColor;
  final Color textColor;
  final Function()? onPressed;

  const CustomElevatedButton(
      {Key? key,
      required this.text,
      required this.beginColor,
      required this.endColor,
      required this.textColor,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor.withAlpha(50),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(2, 2),
            )
          ],
          gradient: LinearGradient(colors: [beginColor, endColor])),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          minimumSize: const Size.fromHeight(50),
          elevation: 0,
          fixedSize: const Size(150, 30),
        ),
        onPressed: onPressed,
        child: Container(
          
          width: double.infinity,
          child: Center(
            child:
                Text(text, style: TextStyle(fontSize: 20, color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
