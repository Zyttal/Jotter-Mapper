import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jotter_mapper/static_data.dart';
import 'package:jotter_mapper/themes/custom_color_palette.dart';
import 'package:jotter_mapper/widgets/back_button.dart';

class EntryDetailsScreen extends StatelessWidget {
  EntryDetailsScreen({super.key, this.entryId});
  static const String route = '/entry/:id';
  static const String name = 'EntryDetails';

  String? entryId;

  @override
  Widget build(BuildContext context) {
    final entry =
        StaticData.entries.firstWhere((entry) => entry.entryId == entryId);

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
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: ColorPalette.dark300,
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.edit_outlined,
                            color: ColorPalette.washedWhite,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Edit",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ],
                      ),
                    )
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
                SizedBox(
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
