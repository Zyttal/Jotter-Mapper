import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:jotter_mapper/enum/first_instance_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesController with ChangeNotifier {
  static const String _isFirstInstance = 'isFirstInstance';

  static void initialize() {
    GetIt.instance.registerSingleton<SharedPreferencesController>(
        SharedPreferencesController());
  }

  static SharedPreferencesController get instance =>
      GetIt.instance<SharedPreferencesController>();
  static SharedPreferencesController get I =>
      GetIt.instance<SharedPreferencesController>();

  FirstInstanceEnum _runState = FirstInstanceEnum.notFirstInstance;
  FirstInstanceEnum get runState => _runState;

  setState(FirstInstanceEnum value) {
    _runState = value;
    notifyListeners();
  }

  loadRunState() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      FirstInstanceEnum savedState = FirstInstanceEnum.values[
          prefs.getInt(_isFirstInstance) ??
              FirstInstanceEnum.isFirstInstance.index];
      _runState = savedState;
      notifyListeners();
    } catch (e) {
      print("Error loading run state: $e");
    }
  }

  saveRunState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_isFirstInstance, _runState.index);

    notifyListeners();
  }

  // For Testing out the onboarding
  Future<void> resetSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    _runState = FirstInstanceEnum.isFirstInstance;
    notifyListeners();
  }
}
