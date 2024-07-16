import 'package:flutter/material.dart';
import 'package:jotter_mapper/controllers/entries_controller.dart';
import 'package:jotter_mapper/controllers/joke_controller.dart';
import 'package:jotter_mapper/controllers/user_data_controller.dart';
import 'package:jotter_mapper/custompainter_assets/header_painter.dart';
import 'package:jotter_mapper/models/entries_model.dart';
import 'package:jotter_mapper/routing/router.dart';
import 'package:jotter_mapper/screens/content/map_screen.dart';

import 'package:jotter_mapper/themes/custom_color_palette.dart';
import 'package:jotter_mapper/widgets/custom_button.dart';
import 'package:jotter_mapper/widgets/custom_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String name = "Home Screen";
  static const String route = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  late String userId;

  @override
  void initState() {
    super.initState();
    userId = UserDataController.I.currentUser?.uid ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            pinned: true,
            floating: false,
            expandedHeight: 100,
            backgroundColor: Colors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Positioned.fill(
                    child: CustomPaint(
                      painter: HeaderPainter(),
                    ),
                  ),
                  Positioned(
                      top: 30,
                      left: 20,
                      child: Text(
                        "Home",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ))
                ],
              ),
            ),
          ),
        ],
        body: FutureBuilder<void>(
          future: EntriesController.I.fetchEntries(userId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error loading entries'));
            } else {
              return EntriesController.I.entries.isEmpty
                  ? const EmptyEntriesWidget()
                  : const EntriesListWidget();
            }
          },
        ),
      ),
    );
  }
}

class EntriesListWidget extends StatelessWidget {
  const EntriesListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: EntriesController.I.entries.length,
      itemBuilder: (context, index) {
        if (index == EntriesController.I.entries.length) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: CustomCardWidget(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    JokeController.I.joke ?? ';((',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      JokeController.I.joke ?? ';((',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
