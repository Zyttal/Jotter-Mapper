import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jotter_mapper/widgets/text_field_with_label.dart';

class AddEntryScreen extends StatefulWidget {
  static const String name = "Add Entry Screen";
  static const String route = "/add-entry";

  const AddEntryScreen({super.key, required this.location});
  final LatLng location;

  @override
  State<AddEntryScreen> createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends State<AddEntryScreen> {
  TextEditingController title = TextEditingController();
  FocusNode titlefn = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        TextFieldWithLabel(
            label: "Title",
            icon: Icon(Icons.abc),
            validator: null,
            controller: title,
            fn: titlefn)
      ],
    ));
  }
}
