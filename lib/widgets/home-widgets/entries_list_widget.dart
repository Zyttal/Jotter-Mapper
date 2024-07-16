import 'package:flutter/material.dart';
import 'package:jotter_mapper/controllers/entries_controller.dart';
import 'package:jotter_mapper/controllers/joke_controller.dart';
import 'package:jotter_mapper/models/entries_model.dart';
import 'package:jotter_mapper/routing/router.dart';
import 'package:jotter_mapper/themes/custom_color_palette.dart';
import 'package:jotter_mapper/widgets/general-widgets/custom_button.dart';
import 'package:jotter_mapper/widgets/general-widgets/custom_card_widget.dart';

class EntriesListWidget extends StatelessWidget {
  const EntriesListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final itemCount = EntriesController.I.entries.length + 1;

    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (index == EntriesController.I.entries.length) {
          return Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: CustomButton(func: () {}, text: "Add another Entry"),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: CustomCardWidget(
                  child: Text(
                    JokeController.I.joke ?? ';((',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
            ],
          );
        }

        final Entry entry = EntriesController.I.entries[index];
        return GestureDetector(
          onTap: () {
            GlobalRouter.I.router.push('/entry/${entry.entryId}');
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: ColorPalette.dark200,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: ColorPalette.dark300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (entry.imageUrls != null && entry.imageUrls!.isNotEmpty)
                  Image.network(
                    entry.imageUrls![0],
                    width: MediaQuery.of(context).size.width,
                    height: 170,
                    fit: BoxFit.cover,
                  )
                else
                  const SizedBox(
                    height: 170,
                    child: Center(child: Text("No Images...")),
                  ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.title,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      if (entry.subtitle != null)
                        Text(
                          entry.subtitle ?? "",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: ColorPalette.dark600),
                        ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "${entry.date} at ${entry.locationName}",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
