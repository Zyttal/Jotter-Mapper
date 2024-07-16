import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jotter_mapper/controllers/auth_controller.dart';
import 'package:jotter_mapper/controllers/user_data_controller.dart';
import 'package:jotter_mapper/custompainter_assets/header_painter.dart';
import 'package:jotter_mapper/themes/custom_color_palette.dart';
import 'package:jotter_mapper/widgets/custom_button.dart';
import 'package:jotter_mapper/widgets/custom_card_widget.dart';
import 'package:jotter_mapper/widgets/waiting_dialog.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static const String name = "Profile Screen";
  static const String route = "/profile";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker _picker = ImagePicker();
  String photoURL = UserDataController.I.currentUser!.photoURL!;

  @override
  void initState() {
    super.initState();
    photoURL = UserDataController.I.currentUser?.photoURL ?? '';
    UserDataController.I.addListener(_updatePhotoURL);
  }

  void _updatePhotoURL() {
    setState(() {
      photoURL = UserDataController.I.currentUser?.photoURL ?? '';
    });
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
              Center(
                  child: Container(
                child: Stack(
                  children: [
                    CircleAvatar(
                        radius: 80,
                        backgroundImage: photoURL.isNotEmpty
                            ? NetworkImage(photoURL)
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
                                  future:
                                      UserDataController.I.uploadImage(image));
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
                CustomCardWidget(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Account Information",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.edit,
                                size: 20,
                              ))
                        ],
                      ),
                      const Divider(
                        color: ColorPalette.dark400,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Display Name",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Email Address",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                UserDataController.I.currentUser!.displayName,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                UserDataController.I.currentUser!.email,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
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
    );
  }
}

class AppInformationWidget extends StatelessWidget {
  const AppInformationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            "App Information",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(
            height: 15,
          ),
          const Divider(
            color: ColorPalette.dark400,
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Icon(
                    Icons.info_outline,
                    size: 30,
                    color: ColorPalette.washedWhite,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "About Us",
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                ],
              ),
              Column(
                children: [
                  const Icon(
                    Icons.settings,
                    size: 30,
                    color: ColorPalette.washedWhite,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Settings",
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                ],
              ),
              Column(
                children: [
                  const Icon(
                    CupertinoIcons.question_circle,
                    size: 30,
                    color: ColorPalette.washedWhite,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "About Us",
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
