import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jotter_mapper/controllers/entries_controller.dart';
import 'package:jotter_mapper/models/entries_model.dart';
import 'package:jotter_mapper/routing/router.dart';
import 'package:jotter_mapper/screens/content/home_screen.dart';
import 'package:jotter_mapper/themes/custom_color_palette.dart';
import 'package:jotter_mapper/widgets/general-widgets/back_button.dart';
import 'package:jotter_mapper/widgets/general-widgets/custom_button.dart';
import 'package:jotter_mapper/widgets/general-widgets/text_field_with_label.dart';
import 'package:jotter_mapper/widgets/general-widgets/waiting_dialog.dart';

class EditEntryScreen extends StatefulWidget {
  EditEntryScreen({super.key, this.entryId});
  static const String route = '/edit-entry/:id';
  static const String name = 'Edit Entry Screen';

  String? entryId;

  @override
  State<EditEntryScreen> createState() => _EditEntryScreenState();
}

class _EditEntryScreenState extends State<EditEntryScreen> {
  late GlobalKey<FormState> formKey;
  late TextEditingController title, subtitle, content;
  late FocusNode titlefn, subtitlefn, contentfn;
  final ImagePicker _picker = ImagePicker();
  List<XFile>? _selectedImages = [];
  Entry? entry;

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

    fetchEntryDetails();
  }

  Future<void> fetchEntryDetails() async {
    final entryDetails = EntriesController.I.entries
        .firstWhere((entry) => entry.entryId == widget.entryId);

    setState(() {
      entry = entryDetails;
      title.text = entry?.title ?? '';
      subtitle.text = entry?.subtitle ?? '';
      content.text = entry?.content ?? '';
    });
  }

  Future<void> updateEntry() async {
    if (formKey.currentState?.validate() ?? false) {
      await EntriesController.I.editEntry(
          entryId: widget.entryId!,
          title: title.text,
          subtitle: subtitle.text.isEmpty ? null : subtitle.text,
          content: content.text,
          images: _selectedImages,
          location: entry!.location,
          locationName: entry!.locationName);

      GlobalRouter.I.router.go(HomeScreen.route);
    } else {
      print("Form is not validated...");
    }
  }

  @override
  Widget build(BuildContext context) {
    final entry = EntriesController.I.entries
        .firstWhere((entry) => entry.entryId == widget.entryId);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Edit Entry",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          leadingWidth: 80,
          leading: CustomBackButton(
            func: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: entry == null
            ? const Center(
                child: SpinKitChasingDots(
                  color: ColorPalette.primary100,
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(
                    children: [
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextFieldWithLabel(
                                label: "Title",
                                icon: const Icon(Icons.abc),
                                validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: "Title is required")
                                ]).call,
                                controller: title,
                                fn: titlefn),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFieldWithLabel(
                                label: "Subtitle",
                                icon: const Icon(Icons.abc),
                                validator: null,
                                controller: subtitle,
                                fn: subtitlefn),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFieldWithLabel(
                              label: "Content",
                              icon: const Icon(Icons.text_fields),
                              controller: content,
                              fn: contentfn,
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: "Content is required")
                              ]).call,
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            entry.imageUrls!.isNotEmpty &&
                                    _selectedImages!.isEmpty
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
                                        items: entry.imageUrls!.map((url) {
                                          return Builder(
                                              builder: (BuildContext context) {
                                            return Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Image.network(url,
                                                  fit: BoxFit.cover),
                                            );
                                          });
                                        }).toList()),
                                  )
                                : _selectedImages != null &&
                                        _selectedImages!.isNotEmpty
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
                                            items:
                                                _selectedImages!.map((image) {
                                              return Builder(builder:
                                                  (BuildContext context) {
                                                return Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
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
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              border: Border.all(
                                                  color: ColorPalette.dark300)),
                                          padding: const EdgeInsets.all(20),
                                          child: const Column(
                                            children: [
                                              Icon(Icons.camera_alt_outlined),
                                              SizedBox(
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
                      CustomButton(
                          func: () {
                            WaitingDialog.show(context, future: updateEntry());
                          },
                          text: "Update Entry")
                    ],
                  ),
                ),
              ));
  }
}
