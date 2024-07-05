import 'package:flutter/material.dart';
import 'package:jotter_mapper/custompainter_assets/header_painter.dart';
import 'package:jotter_mapper/themes/custom_color_palette.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String name = "Home Screen";
  static const String route = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
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
