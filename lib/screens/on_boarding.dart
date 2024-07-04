import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jotter_mapper/themes/custom_color_palette.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatefulWidget {
  static const String name = "On Boarding Screen";
  static const String route = "/on_boarding";
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController _pageController = PageController(initialPage: 0);
  final ValueNotifier<int> _currentPageNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/images/ob_graphic1.svg",
                height: 200,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Create Your Journal Entries",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Easily create journal entries with text and images based on your current location. Capture your moments and keep a detailed record of your experiences.",
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              )
            ],
          )),
      Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/images/ob_graphic2.svg",
                height: 200,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Create Your Journal Entries",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Easily create journal entries with text and images based on your current location. Capture your moments and keep a detailed record of your experiences.",
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              )
            ],
          )),
      Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/images/ob_graphic3.svg",
                height: 200,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Enrich Your Entries with Images",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Easily upload images along with your text entries to make your memories more vivid. Share your photos with your journal entries and keep a visual record of your journeys.",
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              )
            ],
          )),
    ];

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPageNotifier.value = page;
              });
            },
            children: _pages,
          )),
          SmoothPageIndicator(
            controller: _pageController,
            count: _pages.length,
            effect: const SlideEffect(
                dotHeight: 10,
                dotWidth: 10,
                spacing: 20,
                activeDotColor: ColorPalette.primary100,
                dotColor: ColorPalette.dark200),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
            child: InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                if (_currentPageNotifier.value != 2) {
                  _currentPageNotifier.value += 1;
                  _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                } else {
                  // Redirect to Login Screen
                }
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: ColorPalette.primary100,
                    borderRadius: BorderRadius.circular(50)),
                child: Center(
                  child: Text(
                    "Continue",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontSize: 16),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
