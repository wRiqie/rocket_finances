import 'package:flutter/material.dart';
import 'package:rocket_finances/app/ui/modules/add_bill/add_bill.dart';
import 'package:rocket_finances/app/ui/modules/add_budget/add_budget.dart';
import 'package:rocket_finances/app/ui/modules/add_receipt/add_receipt.dart';
import 'package:rocket_finances/app/ui/modules/budgets/budgets.dart';
import 'package:rocket_finances/app/ui/modules/dashboard/dashboard.dart';
import 'package:rocket_finances/app/ui/modules/goal/goal.dart';
import 'package:rocket_finances/app/ui/modules/home/home.dart';
import 'package:rocket_finances/app/ui/modules/loading_analysis/loading_analysis.dart';
import 'package:rocket_finances/app/ui/modules/select_category/select_category.dart';
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
    AppRoutes.addBill: (context) => AddBill(),
    AppRoutes.addReceipt: (context) => AddReceipt(),
    AppRoutes.selectCategory: (context) => SelectCategory(),
    AppRoutes.budgets: (context) => Budgets(),
    AppRoutes.addBudget: (context) => AddBudget(),
    AppRoutes.loadingAnalysis: (context) => LoadingAnalysis(),
    AppRoutes.goal: (context) => Goal(),
  };
}
