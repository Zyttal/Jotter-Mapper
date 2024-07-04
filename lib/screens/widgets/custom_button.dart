import 'package:flutter/material.dart';
import 'package:jotter_mapper/themes/custom_color_palette.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.func, required this.text});

  final VoidCallback func;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: func,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: ColorPalette.primary100,
            borderRadius: BorderRadius.circular(50)),
        child: Center(
          child: Text(
            text,
            style:
                Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
