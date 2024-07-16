import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jotter_mapper/themes/custom_color_palette.dart';

// ignore: must_be_immutable
class TextFieldWithLabel extends StatefulWidget {
  int? maxLines;

  final TextInputType keyboardType;

  TextFieldWithLabel(
      {super.key,
      required this.label,
      required this.icon,
      required this.validator,
      this.isPassword = false,
      this.obfuscatefunc,
      required this.controller,
      required this.fn,
      this.maxLines = 1,
      this.keyboardType = TextInputType.text});

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
          controller: widget.controller,
          keyboardAppearance: Brightness.dark,
          maxLines: widget.maxLines,
          keyboardType: widget.keyboardType,
          obscureText: widget.isPassword && obfuscate,
          style: Theme.of(context).textTheme.bodyMedium,
          cursorColor: ColorPalette.primary100,
          decoration: InputDecoration(
              filled: true,
              fillColor: ColorPalette.dark200,
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
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: ColorPalette.dark300, width: 2)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(color: ColorPalette.primary100, width: 2),
              ),
              errorBorder: InputBorder.none,
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(color: ColorPalette.primary100, width: 2),
              ),
              contentPadding: const EdgeInsets.all(20),
              hoverColor: ColorPalette.primary100,
              focusColor: ColorPalette.primary100),
          validator: widget.validator,
          onEditingComplete: () {},
        )
      ],
    );
  }
}