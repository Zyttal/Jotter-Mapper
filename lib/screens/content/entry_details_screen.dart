import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jotter_mapper/controllers/entries_controller.dart';
import 'package:jotter_mapper/routing/router.dart';
import 'package:jotter_mapper/screens/content/home_screen.dart';
import 'package:jotter_mapper/static_data.dart';
import 'package:jotter_mapper/themes/custom_color_palette.dart';
import 'package:jotter_mapper/widgets/general-widgets/back_button.dart';
import 'package:jotter_mapper/widgets/general-widgets/waiting_dialog.dart';

class EntryDetailsScreen extends StatelessWidget {
  EntryDetailsScreen({super.key, this.entryId});
  static const String route = '/entry/:id';
  static const String name = 'EntryDetails';

  String? entryId;

  @override
  Widget build(BuildContext context) {
    final entry = EntriesController.I.entries
        .firstWhere((entry) => entry.entryId == entryId);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          entry.title,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        leadingWidth: 80,
        leading: CustomBackButton(
          func: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          if (entry.imageUrls != null && entry.imageUrls!.isNotEmpty)
            CarouselSlider(
              options: CarouselOptions(
                  height: 300,
                  enableInfiniteScroll: false,
                  viewportFraction: 1),
              items: entry.imageUrls!.map((url) {
                return Builder(builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(url, fit: BoxFit.cover),
                  );
                });
              }).toList(),
            )
          else
            const SizedBox(
              height: 300,
              child: Center(
                child: Text("No Image..."),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      entry.title,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: ColorPalette.dark300,
                              borderRadius: BorderRadius.circular(15)),
                          child: const Icon(
                            Icons.edit_outlined,
                            color: ColorPalette.washedWhite,
                            size: 20,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await WaitingDialog.show(context,
                                future:
                                    EntriesController.I.deleteEntry(entryId!));
                            GlobalRouter.I.router.go(HomeScreen.route);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: ColorPalette.dark300,
                                borderRadius: BorderRadius.circular(15)),
                            child: const Icon(
                              Icons.delete_outline_outlined,
                              color: ColorPalette.washedWhite,
                              size: 20,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Text(
                  entry.subtitle ?? "",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: ColorPalette.dark400),
                ),
                Text(
                  "${entry.date} at ${entry.locationName}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  entry.content,
                  style: Theme.of(context).textTheme.bodySmall,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
