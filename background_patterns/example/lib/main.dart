import 'package:example/configure_background_pattern.dart';
import 'package:example/custom_background.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ExampleBackgroundPatterns());
}

class ExampleBackgroundPatterns extends StatelessWidget {
  const ExampleBackgroundPatterns({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: ConfigureBackgroundPattern(),
        ));
  }
}
