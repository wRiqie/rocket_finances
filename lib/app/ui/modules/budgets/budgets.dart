import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rocket_finances/app/business_logic/cubits/budgets/budgets_cubit.dart';
import 'package:rocket_finances/app/ui/modules/budgets/budgets_screen.dart';

class Budgets extends StatelessWidget {
  const Budgets({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BudgetsCubit(GetIt.I()),
      child: BudgetsScreen(),
    );
  }
}
