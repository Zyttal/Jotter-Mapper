import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jotter_mapper/services/information_services.dart';
import 'package:jotter_mapper/themes/custom_color_palette.dart';

class WaitingDialog extends StatelessWidget {
  static Future<T?> show<T>(BuildContext context,
      {required Future<T> future, String? prompt, Color? color}) async {
    try {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (dCon) {
            return WaitingDialog(prompt: prompt);
          });
      T result = await future;
      if (context.mounted) {
        Navigator.of(context, rootNavigator: true).pop();
      }
      return result;
    } catch (e, st) {
      if (context.mounted) {
        print(st);
        Navigator.of(context, rootNavigator: true).pop();
        Info.showSnackbarMessage(context, actionLabel: "Copy",
            onCloseTapped: () {
          Clipboard.setData(ClipboardData(text: e.toString()));
          Info.showSnackbarMessage(context, message: "Copied to clipboard");
        }, message: e.toString(), duration: const Duration(seconds: 10));
      }
      return null;
    }
  }

  final String? prompt;

  const WaitingDialog({super.key, this.prompt});

  @override
  Widget build(BuildContext context) {
    return LoadingWidget(prompt: prompt);
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
    this.prompt,
  });

  final String? prompt;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(20),
      elevation: 0,
      backgroundColor: ColorPalette.dark200,
      child: Center(
        child: SizedBox(
          height: 125,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SpinKitChasingDots(
                color: ColorPalette.primary100,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                prompt ?? "Please wait . . .",
                style: TextStyle(color: ColorPalette.washedWhite),
              )
            ],
          ),
        ),
      ),
    );
  }
}
