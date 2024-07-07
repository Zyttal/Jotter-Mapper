import 'package:flutter/material.dart';
import 'package:jotter_mapper/themes/custom_color_palette.dart';

class Info {
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      showSnackbarMessage(BuildContext context,
          {required String message,
          String? label,
          String actionLabel = "Close",
          void Function()? onCloseTapped,
          Duration duration = const Duration(seconds: 3)}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 2,
        behavior: SnackBarBehavior.floating,
        backgroundColor: ColorPalette.primary500,
        content: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (label != null)
                    Text(
                      label,
                    ),
                  Text(
                    message,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: ColorPalette.dark200),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //       backgroundColor: ColorPalette.primary100,
            //       foregroundColor: ColorPalette.washedWhite),
            //   onPressed: () {
            //     if (onCloseTapped != null) {
            //       onCloseTapped();
            //     } else {
            //       ScaffoldMessenger.of(context).clearSnackBars();
            //     }
            //   },
            //   child: Text(
            //     actionLabel,
            //     style: Theme.of(context).textTheme.bodyMedium,
            //   ),
            // )
          ],
        ),
        duration: duration,
      ),
    );
  }
}
