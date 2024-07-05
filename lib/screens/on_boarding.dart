import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jotter_mapper/controllers/shared_preferences.dart';
import 'package:jotter_mapper/enum/first_instance_enum.dart';
import 'package:jotter_mapper/routing/router.dart';
import 'package:jotter_mapper/screens/auth/login_screen.dart';
import 'package:jotter_mapper/widgets/custom_button.dart';
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
    final List<Widget> pages = [
      Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/images/ob_graphic1.svg",
                height: 200,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Create Your Journal Entries",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(
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
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/images/ob_graphic2.svg",
                height: 200,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Create Your Journal Entries",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(
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
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/images/ob_graphic3.svg",
                height: 200,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Enrich Your Entries with Images",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(
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
            children: pages,
          )),
          SmoothPageIndicator(
            controller: _pageController,
            count: pages.length,
            effect: const SlideEffect(
                dotHeight: 10,
                dotWidth: 10,
                spacing: 20,
                activeDotColor: ColorPalette.primary100,
                dotColor: ColorPalette.mixed600),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: CustomButton(
              text: "Continue",
              func: () {
                if (_currentPageNotifier.value != 2) {
                  _currentPageNotifier.value += 1;
                  _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                } else {
                  SharedPreferencesController.I
                      .setState(FirstInstanceEnum.notFirstInstance);
                  SharedPreferencesController.I.saveRunState();
                  GlobalRouter.I.router.go(LoginScreen.route);
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
