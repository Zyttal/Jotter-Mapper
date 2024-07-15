import 'package:flutter/material.dart';
import 'package:jotter_mapper/controllers/joke_controller.dart';
import 'package:jotter_mapper/custompainter_assets/header_painter.dart';
import 'package:jotter_mapper/static_data.dart';
import 'package:jotter_mapper/themes/custom_color_palette.dart';
import 'package:jotter_mapper/widgets/custom_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String name = "Home Screen";
  static const String route = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? joke;
  bool isLoading = true;
  final JokeController jokeController = JokeController();

  Future<void> fetchQuote() async {
    try {
      final jokeData = await jokeController.fetchJoke();
      setState(() {
        joke = jokeData['joke'];
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        joke = 'Failed to Load Quote...';
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchQuote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            pinned: true,
            floating: false,
            expandedHeight: 125,
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
                      top: 25,
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
        body: ListView.builder(
          itemCount: StaticData.posts.length + 1,
          itemBuilder: (context, index) {
            if (index == StaticData.posts.length) {
              return Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: CustomCardWidget(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          joke ?? ';((',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            final Post post = StaticData.posts[index];
            return Container(
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
                  Image.network(
                    post.imageUrl,
                    width: MediaQuery.of(context).size.width,
                    height: 170,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.title,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          post.content,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: ColorPalette.dark600),
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(post.date),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
