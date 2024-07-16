import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jotter_mapper/controllers/entries_controller.dart';
import 'package:jotter_mapper/controllers/joke_controller.dart';
import 'package:jotter_mapper/controllers/user_data_controller.dart';
import 'package:jotter_mapper/custompainter_assets/header_painter.dart';
import 'package:jotter_mapper/models/entries_model.dart';
import 'package:jotter_mapper/routing/router.dart';
import 'package:jotter_mapper/screens/content/map_screen.dart';

import 'package:jotter_mapper/themes/custom_color_palette.dart';
import 'package:jotter_mapper/widgets/general-widgets/custom_button.dart';
import 'package:jotter_mapper/widgets/general-widgets/custom_card_widget.dart';
import 'package:jotter_mapper/widgets/home-widgets/empty_entries_widget.dart';
import 'package:jotter_mapper/widgets/home-widgets/entries_list_widget.dart';

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

  Future<void> _refreshEntries() async {
    setState(() {
      isLoading = true;
    });
    await EntriesController.I.fetchEntries(userId);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshEntries,
        color: ColorPalette.primary100,
        child: NestedScrollView(
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
                        )),
                    Positioned(
                        top: 20,
                        right: 20,
                        child: IconButton(
                          icon: Icon(Icons.refresh_outlined),
                          onPressed: _refreshEntries,
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
                return const Center(
                    child: SpinKitChasingDots(
                  color: ColorPalette.primary100,
                ));
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error loading entries'));
              } else {
                return EntriesController.I.entries.isEmpty
                    ? const EmptyEntriesWidget()
                    : const EntriesListWidget();
              }
            },
          ),
        ),
      ),
    );
  }
}
