import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';

class LocationController with ChangeNotifier {
  static void initialize() {
    GetIt.instance.registerSingleton<LocationController>(LocationController());
    instance.checkAndRequestPermissions();
  }

  static LocationController get instance =>
      GetIt.instance<LocationController>();
  static LocationController get I => GetIt.instance<LocationController>();

  bool _serviceEnabled = false;
  LocationPermission _permission = LocationPermission.denied;
  Position? _currentPosition;

  bool get serviceEnabled => _serviceEnabled;
  LocationPermission get permission => _permission;
  Position? get currentPosition => _currentPosition;

  Future<void> checkAndRequestPermissions() async {
    try {
      _serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!_serviceEnabled) {
        return Future.error('Location services are disabled.');
      }

      _permission = await Geolocator.checkPermission();
      if (_permission == LocationPermission.denied) {
        _permission = await Geolocator.requestPermission();
        if (_permission == LocationPermission.denied) {
          return Future.error('Location Permissions are denied');
        }
      }

      if (_permission == LocationPermission.deniedForever) {
        return Future.error('Location Perimssions are permanently denied...');
      }
    } catch (e) {
      print("Error checking/requesting permissions: $e");
    }
  }

  Future<void> getCurrentLocation() async {
    try {
      _currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      print("Current Location: ${_currentPosition}");
      notifyListeners();
    } catch (e) {
      print("Error getting current Location: $e");
    }
  }
}
