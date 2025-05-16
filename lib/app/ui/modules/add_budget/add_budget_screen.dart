import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rocket_finances/app/business_logic/cubits/budgets/budgets_cubit.dart';
import 'package:rocket_finances/app/business_logic/cubits/budgets/budgets_state.dart';
import 'package:rocket_finances/app/core/helpers/app_helpers.dart';
import 'package:rocket_finances/app/core/helpers/session_helper.dart';
import 'package:rocket_finances/app/core/mixins/validators_mixin.dart';
import 'package:rocket_finances/app/core/values/snackbars.dart';
import 'package:rocket_finances/app/data/models/args/add_budget_args.dart';
import 'package:rocket_finances/app/data/models/budget_model.dart';
import 'package:rocket_finances/app/data/models/commands/budget/budget_add_command.dart';
import 'package:rocket_finances/app/data/models/commands/budget/budget_update_command.dart';

class AddBudgetScreen extends StatefulWidget {
  const AddBudgetScreen({super.key});

  @override
  State<AddBudgetScreen> createState() => _AddBudgetScreenState();
}

class _AddBudgetScreenState extends State<AddBudgetScreen>
    with ValidatorsMixin {
  final sessionHelper = GetIt.I<SessionHelper>();

  final formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final valueCtrl = TextEditingController();

  BudgetModel? editingBudget;

  @override
  void initState() {
    super.initState();

    scheduleMicrotask(() {
      final args = ModalRoute.of(context)?.settings.arguments as AddBudgetArgs?;

      if (args != null) {
        editingBudget = args.editingBudget;
        nameCtrl.text = editingBudget!.name;
        valueCtrl.text = AppHelpers.formatCurrency(editingBudget!.value);
      }
    });
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    valueCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BudgetsCubit, BudgetsState>(
      listener: (context, state) {
        if (state.status.isError) {
          ErrorSnackbar(context, message: state.error?.message);
        } else if (state.status.isSuccess) {
          Navigator.pop(context, true);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Adicionar orçamento'),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.fromLTRB(
              18, 20, 18, 20 + MediaQuery.paddingOf(context).bottom),
          child: SizedBox(
            height: 45,
            child: ElevatedButton(
              onPressed: _save,
              child: Text('Salvar'),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(18, 20, 18, 0),
            child: Form(
              key: formKey,
              child: Column(
                spacing: 20,
                children: [
                  Column(
                    spacing: 12,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Nome',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      TextFormField(
                        controller: nameCtrl,
                        decoration: InputDecoration(
                          hintText: 'Digite o nome',
                        ),
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.sentences,
                        validator: isNotEmpty,
                      ),
                    ],
                  ),
                  Column(
                    spacing: 12,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Valor',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      TextFormField(
                        controller: valueCtrl,
                        decoration: InputDecoration(
                          hintText: 'Digite o valor',
                        ),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        inputFormatters: [AppHelpers.currencyFormatter()],
                        validator: (value) => combine([
                          () => isNotEmpty(value),
                          () => isMoreThanZeroMoney(value),
                        ]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _save() {
    if (!(formKey.currentState?.validate() ?? false)) return;

    if (editingBudget == null) {
      final command = BudgetAddCommand(
        name: nameCtrl.text,
        value: AppHelpers.revertCurrency(valueCtrl.text) * 1.0,
        userId: sessionHelper.currentUser?.id ?? '',
      );

      BlocProvider.of<BudgetsCubit>(context).addBudget(command);
    } else {
      final command = BudgetUpdateCommand(
        id: editingBudget!.id,
        name: nameCtrl.text,
        value: AppHelpers.revertCurrency(valueCtrl.text) * 1.0,
      );

      BlocProvider.of<BudgetsCubit>(context).updateBudget(command);
    }
  }
}
