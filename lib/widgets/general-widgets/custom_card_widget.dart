import 'package:flutter/cupertino.dart';
import 'package:jotter_mapper/themes/custom_color_palette.dart';

// ignore: must_be_immutable
class CustomCardWidget extends StatelessWidget {
  Widget child;

  CustomCardWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            color: ColorPalette.dark200,
            border: Border.all(color: ColorPalette.dark300),
            borderRadius: BorderRadius.circular(10)),
        child: child);
  }
}
