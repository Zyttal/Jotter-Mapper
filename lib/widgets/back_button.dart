import 'package:flutter/material.dart';
import 'package:jotter_mapper/themes/custom_color_palette.dart';

class CustomBackButton extends StatelessWidget {
  CustomBackButton({super.key, this.func});

  VoidCallback? func;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: GestureDetector(
        onTap: func,
        child: Container(
          margin: const EdgeInsets.all(5),
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              border: Border.all(
                color: ColorPalette.dark400,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10)),
          child: const Center(
            child: Icon(
              Icons.keyboard_arrow_left_rounded,
              color: ColorPalette.washedWhite,
              size: 35,
            ),
          ),
        ),
      ),
    );
  }
}
