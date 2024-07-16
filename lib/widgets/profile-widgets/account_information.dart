import 'package:flutter/material.dart';
import 'package:jotter_mapper/controllers/user_data_controller.dart';
import 'package:jotter_mapper/themes/custom_color_palette.dart';
import 'package:jotter_mapper/widgets/general-widgets/custom_button.dart';
import 'package:jotter_mapper/widgets/general-widgets/custom_card_widget.dart';
import 'package:jotter_mapper/widgets/general-widgets/text_field_with_label.dart';

class AccountInformation extends StatelessWidget {
  const AccountInformation({
    super.key,
    required this.name,
    required this.namefn,
  });

  final TextEditingController name;
  final FocusNode namefn;

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
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
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFieldWithLabel(
                                  controller: name,
                                  fn: namefn,
                                  label: "Display Name",
                                  icon: Icon(Icons.person_2_outlined),
                                  validator: null,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                CustomButton(
                                    func: () {
                                      UserDataController.I
                                          .updateDisplayName(name.text);
                                      Navigator.pop(context);
                                    },
                                    text: "Edit name")
                              ],
                            ),
                          );
                        });
                  },
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
    );
  }
}
