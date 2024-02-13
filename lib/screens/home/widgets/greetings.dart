import 'package:flutter/material.dart';

class Greetings extends StatelessWidget {
  const Greetings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text("Hello Olvine 👋", style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold)),
    );
  }
}
