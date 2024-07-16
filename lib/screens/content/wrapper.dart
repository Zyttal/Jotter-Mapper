import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jotter_mapper/routing/router.dart';
import 'package:jotter_mapper/screens/content/home_screen.dart';
import 'package:jotter_mapper/screens/content/profile_screen.dart';
import 'package:jotter_mapper/themes/custom_color_palette.dart';

import 'map_screen.dart';

class AppWrapper extends StatefulWidget {
  const AppWrapper({super.key, this.child});
  final Widget? child;

  @override
  State<AppWrapper> createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> {
  int index = 0;

  final List<String> routes = [
    HomeScreen.route,
    MapScreen.route,
    ProfileScreen.route
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child ?? const Placeholder(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: ColorPalette.primary100,
        selectedLabelStyle: const TextStyle(color: ColorPalette.primary100),
        unselectedItemColor: ColorPalette.washedWhite,
        unselectedLabelStyle: const TextStyle(color: ColorPalette.washedWhite),
        useLegacyColorScheme: false,
        backgroundColor: ColorPalette.dark200,
        currentIndex: index,
        onTap: (i) {
          setState(() {
            index = i;
          });

          GlobalRouter.I.router.go(routes[i]);
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.map), label: "Map"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined), label: "Profile")
        ],
      ),
    );
  }
}
