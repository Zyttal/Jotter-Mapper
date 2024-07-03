import 'package:flutter/material.dart';
import 'package:jotter_mapper/routing/router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GlobalRouter.initialize();
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
    );
  }
}
