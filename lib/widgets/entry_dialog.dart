import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jotter_mapper/controllers/coords_details_controller.dart';
import 'package:jotter_mapper/models/entries_model.dart';
import 'package:jotter_mapper/routing/router.dart';
import 'package:jotter_mapper/screens/content/add_entry_screen.dart';
import 'package:jotter_mapper/themes/custom_color_palette.dart';
import 'package:jotter_mapper/widgets/general-widgets/custom_button.dart';

void addEntryDialog(BuildContext context, LatLng tappedLocation) {
  final coordsDetailsController = CoordsDetailsController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return FutureBuilder<Map<String, dynamic>>(
        future: coordsDetailsController.fetchLocationDetails(tappedLocation),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CustomWaitingDialog();
          } else if (snapshot.hasError) {
            return AlertDialog(
              title: Text("Error"),
              content: Text("Failed to fetch location details"),
              actions: [
                CustomButton(
                  func: () {
                    Navigator.of(context).pop();
                  },
                  text: "Close",
                ),
              ],
            );
          } else {
            final locationDetails = snapshot.data!;
            final address = locationDetails['address'] ?? {};
            String fullAddress = '';
            if (address['road'] != null) {
              fullAddress += address['road'];
            }
            if (address['city'] != null) {
              if (fullAddress.isNotEmpty) fullAddress += ', ';
              fullAddress += address['city'];
            }
            if (address['state'] != null) {
              if (fullAddress.isNotEmpty) fullAddress += ', ';
              fullAddress += address['state'];
            }
            if (address['country'] != null) {
              if (fullAddress.isNotEmpty) fullAddress += ', ';
              fullAddress += address['country'];
            }

            return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("New Entry",
                      style: Theme.of(context).textTheme.headlineSmall),
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: ColorPalette.washedWhite,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              content: Text(
                fullAddress,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              actions: [
                CustomButton(
                  func: () {
                    final extra = {
                      'location': tappedLocation,
                      'address': fullAddress
                    };

                    Navigator.of(context).pop();
                    GlobalRouter.I.router
                        .push(AddEntryScreen.route, extra: extra);
                  },
                  text: "Add an Entry here",
                ),
              ],
            );
          }
        },
      );
    },
  );
}

class CustomWaitingDialog extends StatelessWidget {
  const CustomWaitingDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text("Doing Something...")),
      content: Container(
        height: 100,
        child: const SpinKitChasingDots(
          color: ColorPalette.primary100,
        ),
      ),
    );
  }
}

void showEntryDialog(BuildContext context, Entry entry) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(entry.title, style: Theme.of(context).textTheme.headlineSmall),
            IconButton(
              icon: const Icon(
                Icons.close,
                color: ColorPalette.washedWhite,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (entry.imageUrls != null && entry.imageUrls!.isNotEmpty)
              Container(
                padding: EdgeInsets.all(10),
                height: 300,
                width: 300,
                child: Image.network(
                  entry.imageUrls![0],
                  fit: BoxFit.cover,
                ),
              ),
            Text(
              entry.subtitle ?? '',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Text(
              "${entry.date} at ${entry.locationName}",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        actions: [
          CustomButton(
              func: () {
                Navigator.of(context).pop();
                GlobalRouter.I.router.push('/entry/${entry.entryId}');
              },
              text: "View Entry"),
        ],
      );
    },
  );
}
