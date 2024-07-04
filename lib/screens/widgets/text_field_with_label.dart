import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jotter_mapper/themes/custom_color_palette.dart';

class TextFieldWithLabel extends StatefulWidget {
  TextFieldWithLabel(
      {super.key,
      required this.label,
      required this.icon,
      required this.validator,
      this.isPassword = false,
      this.obfuscatefunc,
      required this.controller,
      required this.fn});

  final String label;
  final Widget icon;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final FocusNode fn;

  VoidCallback? obfuscatefunc;
  bool isPassword = false;

  @override
  State<TextFieldWithLabel> createState() => _TextFieldWithLabelState();
}

class _TextFieldWithLabelState extends State<TextFieldWithLabel> {
  bool obfuscate = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          keyboardAppearance: Brightness.dark,
          keyboardType:
              !widget.isPassword ? null : TextInputType.visiblePassword,
          obscureText: obfuscate,
          decoration: InputDecoration(
              prefixIcon: widget.icon,
              suffixIcon: !widget.isPassword
                  ? null
                  : IconButton(
                      onPressed: () {
                        setState(() {
                          obfuscate = !obfuscate;
                        });
                      },
                      icon: Icon(obfuscate
                          ? Icons.remove_red_eye_outlined
                          : CupertinoIcons.eye_slash)),
              hintText: "Enter your ${widget.label}",
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: ColorPalette.dark600),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              focusColor: ColorPalette.primary100),
          validator: widget.validator,
          onEditingComplete: () {},
        )
      ],
    );
  }
}