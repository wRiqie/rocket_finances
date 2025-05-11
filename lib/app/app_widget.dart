import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rocket_finances/app/core/helpers/session_helper.dart';
import 'package:rocket_finances/routes/app_pages.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rocket finances',
      theme: ThemeData(brightness: Brightness.dark).copyWith(
        appBarTheme: AppBarTheme(centerTitle: true),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      initialRoute: GetIt.I<SessionHelper>().isSignedIn
          ? AppRoutes.dashboard
          : AppRoutes.signIn,
      routes: AppPages.pages,
    );
  }
}
