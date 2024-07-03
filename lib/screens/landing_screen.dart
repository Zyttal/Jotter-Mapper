import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  static const String route = "/landing_screen";
  static const String name = "Landing Screen";

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Placeholder text"),
      ),
    );
  }
}
