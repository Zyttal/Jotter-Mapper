import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jotter_mapper/themes/custom_color_palette.dart';
import 'package:jotter_mapper/widgets/general-widgets/custom_card_widget.dart';

class AppInformationWidget extends StatelessWidget {
  const AppInformationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            "App Information",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(
            height: 15,
          ),
          const Divider(
            color: ColorPalette.dark400,
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Icon(
                    Icons.info_outline,
                    size: 30,
                    color: ColorPalette.washedWhite,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "About Us",
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                ],
              ),
              Column(
                children: [
                  const Icon(
                    Icons.settings,
                    size: 30,
                    color: ColorPalette.washedWhite,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Settings",
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                ],
              ),
              Column(
                children: [
                  const Icon(
                    CupertinoIcons.question_circle,
                    size: 30,
                    color: ColorPalette.washedWhite,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "About Us",
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
