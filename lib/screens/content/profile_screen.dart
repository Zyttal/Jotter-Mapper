import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jotter_mapper/controllers/auth_controller.dart';
import 'package:jotter_mapper/controllers/user_data_controller.dart';
import 'package:jotter_mapper/custompainter_assets/header_painter.dart';
import 'package:jotter_mapper/services/firebase_services.dart';
import 'package:jotter_mapper/themes/custom_color_palette.dart';
import 'package:jotter_mapper/widgets/custom_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static const String name = "Profile Screen";
  static const String route = "/profile";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Map<String, dynamic>? user;
  // final UserDataController = GetIt.
  final userDataController = AuthController.instance.userDataController;
  late User user;

  @override
  void initState() {
    super.initState();

    print("Email Address: ${userDataController?.currentUser?.email}");
    print("Display Name: ${userDataController?.currentUser?.displayName}");
    print("Photo URL: ${userDataController?.currentUser?.photoURL}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        backgroundColor: ColorPalette.dark200,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              CustomPaint(
                painter: HeaderPainter(),
                size: Size(MediaQuery.of(context).size.width, 70),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
