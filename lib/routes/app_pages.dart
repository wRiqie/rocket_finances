import 'package:flutter/material.dart';
import 'package:rocket_finances/app/ui/modules/dashboard/dashboard.dart';
import 'package:rocket_finances/app/ui/modules/home/home.dart';
import 'package:rocket_finances/app/ui/modules/settings/settings.dart';
import 'package:rocket_finances/app/ui/modules/sign_in/sign_in.dart';
import 'package:rocket_finances/app/ui/modules/sign_up/sign_up.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static Map<String, Widget Function(BuildContext context)> pages = {
    AppRoutes.signIn: (context) => SignIn(),
    AppRoutes.signUp: (context) => SignUp(),
    AppRoutes.dashboard: (context) => Dashboard(),
    AppRoutes.home: (context) => Home(),
    AppRoutes.settings: (context) => Settings(),
  };
}
