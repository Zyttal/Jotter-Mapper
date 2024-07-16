import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jotter_mapper/controllers/auth_controller.dart';
import 'package:jotter_mapper/controllers/user_data_controller.dart';
import 'package:jotter_mapper/custompainter_assets/header_painter.dart';
import 'package:jotter_mapper/themes/custom_color_palette.dart';
import 'package:jotter_mapper/widgets/general-widgets/custom_button.dart';
import 'package:jotter_mapper/widgets/general-widgets/custom_card_widget.dart';
import 'package:jotter_mapper/widgets/profile-widgets/account_information.dart';
import 'package:jotter_mapper/widgets/profile-widgets/app_information_widget.dart';
import 'package:jotter_mapper/widgets/general-widgets/text_field_with_label.dart';
import 'package:jotter_mapper/widgets/general-widgets/waiting_dialog.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static const String name = "Profile Screen";
  static const String route = "/profile";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker _picker = ImagePicker();
  String? photoURL;
  late TextEditingController name;
  late FocusNode namefn;

  @override
  void initState() {
    super.initState();
    photoURL = UserDataController.I.currentUser?.photoURL ?? '';
    UserDataController.I.addListener(_updatePhotoURL);

    name = TextEditingController();
    namefn = FocusNode();
  }

  void _updatePhotoURL() {
    setState(() {
      photoURL = UserDataController.I.currentUser?.photoURL ?? '';
    });
  }

  @override
  void dispose() {
    name.dispose();
    namefn.dispose();
    UserDataController.I.removeListener(_updatePhotoURL);
    super.dispose();
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                CustomPaint(
                  painter: HeaderPainter(),
                  size: Size(MediaQuery.of(context).size.width, 70),
                ),
                Center(
                    child: Container(
                  child: Stack(
                    children: [
                      CircleAvatar(
                          radius: 80,
                          backgroundImage:
                              photoURL != null && photoURL!.isNotEmpty
                                  ? NetworkImage(photoURL!)
                                  : const AssetImage(
                                      'assets/images/default_avatar.png')),
                      Positioned(
                        bottom: -10,
                        right: -10,
                        child: IconButton(
                            onPressed: () async {
                              final XFile? image = await _picker.pickImage(
                                  source: ImageSource.gallery);
                              if (image != null) {
                                await WaitingDialog.show(context,
                                    future: UserDataController.I
                                        .uploadImage(image));
                              }
                            },
                            icon: const Icon(
                              CupertinoIcons.camera_circle,
                              color: ColorPalette.washedWhite,
                              size: 30,
                            )),
                      )
                    ],
                  ),
                )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  AccountInformation(name: name, namefn: namefn),
                  const SizedBox(
                    height: 20,
                  ),
                  const AppInformationWidget(),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                      func: () {
                        WaitingDialog.show(context,
                            future: AuthController.I.logout());
                      },
                      text: "Sign Out")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
