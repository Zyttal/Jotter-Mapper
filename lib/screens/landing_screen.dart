import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jotter_mapper/controllers/shared_preferences.dart';
import 'package:jotter_mapper/enum/first_instance_enum.dart';
import 'package:jotter_mapper/routing/router.dart';
import 'package:jotter_mapper/screens/auth/login_screen.dart';
import 'package:jotter_mapper/screens/on_boarding.dart';
import 'package:jotter_mapper/themes/custom_color_palette.dart';

class LandingScreen extends StatefulWidget {
  static const String route = "/landing_screen";
  static const String name = "Landing Screen";

  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  void initState() {
    super.initState();

    // Uncomment When Presenting
    // SharedPreferencesController.I.resetSharedPreferences();

    SharedPreferencesController.I.loadRunState().then((_) {
      String initialRoute = SharedPreferencesController.instance.runState ==
              FirstInstanceEnum.isFirstInstance
          ? OnBoarding.route
          : LoginScreen.route;

      Future.delayed(const Duration(seconds: 2), () {
        GlobalRouter.I.router.go(initialRoute);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/images/logo.svg'),
            const SizedBox(
              height: 25,
            ),
            Text(
              "JOTTER MAPPER",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: ColorPalette.primary100),
            ),
          ],
        ),
      ),
    );
  }
}
