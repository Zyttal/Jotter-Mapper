import 'package:flutter/material.dart';
import 'package:jotter_mapper/custompainter_assets/header_painter.dart';
import 'package:jotter_mapper/themes/custom_color_palette.dart';

class EntriesScreen extends StatefulWidget {
  const EntriesScreen({super.key});
  static const String name = "Entries Screen";
  static const String route = "/entries";

  @override
  State<EntriesScreen> createState() => _EntriesScreenState();
}

class _EntriesScreenState extends State<EntriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Entries",
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
