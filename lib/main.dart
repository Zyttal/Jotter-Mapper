import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jotter_mapper/controllers/auth_controller.dart';
import 'package:jotter_mapper/controllers/shared_preferences.dart';
import 'package:jotter_mapper/firebase_options.dart';
import 'package:jotter_mapper/routing/router.dart';
import 'package:jotter_mapper/themes/theme.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load Prerequisites
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Load States and Routing
  SharedPreferencesController.initialize();
  AuthController.initialize();
  GlobalRouter.initialize();

  // Load User Session
  await AuthController.I.loadSession();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: GlobalRouter.I.router,
      title: 'Jotter Mapper',
      theme: AppTheme.appTheme,
    );
  }
}
