import 'package:flutter/material.dart';
import 'package:rocket_finances/app/routes/app_pages.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rocket finances',
      theme: ThemeData(brightness: Brightness.dark),
      initialRoute: AppRoutes.dashboard,
      routes: AppPages.pages,
    );
  }
}
