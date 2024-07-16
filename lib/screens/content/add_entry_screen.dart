import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jotter_mapper/controllers/entries_controller.dart';
import 'package:jotter_mapper/routing/router.dart';
import 'package:jotter_mapper/screens/content/home_screen.dart';
import 'package:jotter_mapper/themes/custom_color_palette.dart';
import 'package:jotter_mapper/widgets/back_button.dart';
import 'package:jotter_mapper/widgets/custom_button.dart';
import 'package:jotter_mapper/widgets/text_field_with_label.dart';
import 'package:jotter_mapper/widgets/waiting_dialog.dart';

class AddEntryScreen extends StatefulWidget {
  static const String name = "Add Entry Screen";
  static const String route = "/add-entry";

  AddEntryScreen({super.key, required this.location, required this.address});
  final LatLng location;
  final String address;

  @override
  State<AddEntryScreen> createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends State<AddEntryScreen> {
  late GlobalKey<FormState> formKey;
  late TextEditingController title, subtitle, content;
  late FocusNode titlefn, subtitlefn, contentfn;
  final ImagePicker _picker = ImagePicker();
  List<XFile>? _selectedImages = [];

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();

    title = TextEditingController();
    subtitle = TextEditingController();
    content = TextEditingController();

    titlefn = FocusNode();
    subtitlefn = FocusNode();
    contentfn = FocusNode();
  }

  Future<void> createEntry() async {
    if (formKey.currentState?.validate() ?? false) {
      await EntriesController.I.uploadEntry(
          title: title.text,
          subtitle: subtitle.text.isEmpty ? null : subtitle.text,
          content: content.text,
          images: _selectedImages,
          location: widget.location,
          locationName: widget.address);

      GlobalRouter.I.router.go(HomeScreen.route);
    } else {
      print("Form is not validated...");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 80,
          leading: CustomBackButton(
            func: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Add Entry",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFieldWithLabel(
                          label: "Title",
                          icon: Icon(Icons.abc),
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Title is required")
                          ]).call,
                          controller: title,
                          fn: titlefn),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldWithLabel(
                          label: "Subtitle",
                          icon: Icon(Icons.abc),
                          validator: null,
                          controller: subtitle,
                          fn: subtitlefn),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldWithLabel(
                        label: "Content",
                        icon: Icon(Icons.text_fields),
                        controller: content,
                        fn: contentfn,
                        validator: MultiValidator([
                          RequiredValidator(errorText: "Content is required")
                        ]).call,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      _selectedImages != null && _selectedImages!.isNotEmpty
                          ? GestureDetector(
                              onTap: () async {
                                final List<XFile>? images =
                                    await _picker.pickMultiImage();
                                if (images != null) {
                                  setState(() {
                                    _selectedImages = images;
                                  });
                                }
                              },
                              child: CarouselSlider(
                                  options: CarouselOptions(
                                      height: 300,
                                      enableInfiniteScroll: false,
                                      viewportFraction: 1),
                                  items: _selectedImages!.map((image) {
                                    return Builder(
                                        builder: (BuildContext context) {
                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Image.file(
                                          File(image.path),
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    });
                                  }).toList()),
                            )
                          : GestureDetector(
                              onTap: () async {
                                final List<XFile>? images =
                                    await _picker.pickMultiImage();
                                if (images != null) {
                                  setState(() {
                                    _selectedImages = images;
                                  });
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: ColorPalette.dark200,
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(
                                        color: ColorPalette.dark300)),
                                padding: EdgeInsets.all(20),
                                child: const Column(
                                  children: [
                                    Icon(Icons.camera_alt_outlined),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text("Add Pictures?")
                                  ],
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                    func: () async {
                      WaitingDialog.show(context, future: createEntry());
                    },
                    text: "Create Entry"),
              ],
            ),
          ),
        ));
  }
}
