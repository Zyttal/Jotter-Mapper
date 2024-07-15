import 'package:flutter/material.dart';
import 'package:jotter_mapper/themes/custom_color_palette.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.func,
      required this.text,
      this.isGreyedOut = false});

  final VoidCallback func;
  final String text;
  final bool isGreyedOut;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: func,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color:
                !isGreyedOut ? ColorPalette.primary100 : ColorPalette.dark600,
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
