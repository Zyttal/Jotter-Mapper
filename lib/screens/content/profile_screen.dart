import 'package:flutter/material.dart';
import 'package:jotter_mapper/custompainter_assets/header_painter.dart';
import 'package:jotter_mapper/themes/custom_color_palette.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static const String name = "Profile Screen";
  static const String route = "/profile";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        backgroundColor: ColorPalette.dark200,
      ),
      body: Stack(
        children: [
          CustomPaint(
            painter: HeaderPainter(),
            size: Size(MediaQuery.of(context).size.width, 70),
          ),
        ],
      ),
    );
  }
}
