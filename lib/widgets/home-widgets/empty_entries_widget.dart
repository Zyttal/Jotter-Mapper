import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jotter_mapper/controllers/joke_controller.dart';
import 'package:jotter_mapper/routing/router.dart';
import 'package:jotter_mapper/screens/content/map_screen.dart';
import 'package:jotter_mapper/widgets/general-widgets/custom_button.dart';
import 'package:jotter_mapper/widgets/general-widgets/custom_card_widget.dart';

class EmptyEntriesWidget extends StatelessWidget {
  const EmptyEntriesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/images/ob_graphic3.svg",
              height: 150,
            ),
            Text(
              'No entries found.',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 10),
            Text(
              'Go to the map screen to add an entry.',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 20),
            CustomButton(
                func: () {
                  GlobalRouter.I.router.go(MapScreen.route);
                },
                text: "To Map Screen"),
            const SizedBox(height: 20),
            if (JokeController.I.joke != null)
              CustomCardWidget(
                child: Text(
                  JokeController.I.joke ?? ';((',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
