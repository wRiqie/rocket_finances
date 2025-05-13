import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rocket_finances/app/business_logic/cubits/bills/bills_cubit.dart';
import 'package:rocket_finances/app/business_logic/cubits/bills/bills_state.dart';
import 'package:rocket_finances/app/core/helpers/app_helpers.dart';
import 'package:rocket_finances/app/core/helpers/session_helper.dart';
import 'package:rocket_finances/app/core/mixins/validators_mixin.dart';
import 'package:rocket_finances/app/core/values/snackbars.dart';
import 'package:rocket_finances/app/data/models/args/add_bill_args.dart';
import 'package:rocket_finances/app/data/models/bill_model.dart';
import 'package:rocket_finances/app/data/models/commands/bill/bill_add_command.dart';
import 'package:rocket_finances/app/data/models/commands/bill/bill_update_command.dart';
import 'package:rocket_finances/app/data/models/results/select_category_result.dart';
import 'package:rocket_finances/routes/app_pages.dart';

class AddBillScreen extends StatefulWidget {
  const AddBillScreen({super.key});

  @override
  State<AddBillScreen> createState() => _AddBillScreenState();
}

class _AddBillScreenState extends State<AddBillScreen> with ValidatorsMixin {
  final sessionHelper = GetIt.I<SessionHelper>();

  final formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final valueCtrl = TextEditingController();
  final categoryCtrl = TextEditingController();

  BillModel? editingBill;

  int? selectedCategoryId;
  final isRecurring = ValueNotifier(false);

  @override
  void initState() {
    super.initState();

    scheduleMicrotask(() {
      final args = ModalRoute.of(context)?.settings.arguments as AddBillArgs?;

      if (args != null) {
        editingBill = args.editingBill;
        nameCtrl.text = editingBill!.name;
        valueCtrl.text = AppHelpers.formatCurrency(editingBill!.value);
        selectedCategoryId = editingBill!.categoryId;
        categoryCtrl.text = editingBill!.categoryName;

        isRecurring.value = editingBill!.isRecurring;

        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    valueCtrl.dispose();
    categoryCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocListener<BillsCubit, BillsState>(
      listener: (context, state) {
        if (state.status.isError) {
          ErrorSnackbar(context, message: state.error?.message);
        } else if (state.status.isSuccess) {
          Navigator.pop(context, true);
        }
      },
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: Text('Adicionar gasto'),
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
                              () => isMoreThanZero(value),
                            ]),
                          ),
                        ],
                      ),
                      Column(
                        spacing: 12,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Categoria',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          TextFormField(
                            controller: categoryCtrl,
                            readOnly: true,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.category_outlined),
                              hintText: 'Selecione a categoria',
                              suffixIcon: Icon(Icons.chevron_right),
                            ),
                            onTap: _selectCategory,
                            validator: isNotEmpty,
                          ),
                        ],
                      ),
                      Visibility(
                        visible: editingBill == null,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'É recorrente?',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  'Marque se tem o gasto todos os meses',
                                  style: TextStyle(
                                    color: colorScheme.onSurface
                                        .withValues(alpha: .6),
                                  ),
                                ),
                              ],
                            ),
                            ValueListenableBuilder(
                              valueListenable: isRecurring,
                              builder: (context, value, child) {
                                return Switch(
                                  value: value,
                                  onChanged: (value) {
                                    isRecurring.value = !isRecurring.value;
                                  },
                                  thumbIcon: WidgetStateProperty.resolveWith(
                                    (states) {
                                      if (states
                                          .contains(WidgetState.selected)) {
                                        return Icon(Icons.check);
                                      } else {
                                        return Icon(Icons.close);
                                      }
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          BlocBuilder<BillsCubit, BillsState>(
            builder: (context, state) {
              return Visibility(
                visible: state.status.isLoading,
                child: Container(
                  color: Colors.black26,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _selectCategory() async {
    final result = await Navigator.pushNamed(context, AppRoutes.selectCategory);

    if (result is SelectCategoryResult) {
      setState(() {
        selectedCategoryId = result.category.id;
        categoryCtrl.text = result.category.name;
      });
    }
  }

  void _save() {
    if (!(formKey.currentState?.validate() ?? false)) return;

    if (editingBill == null) {
      final command = BillAddCommand(
        name: nameCtrl.text,
        value: AppHelpers.revertCurrency(valueCtrl.text) * 1.0,
        isRecurring: isRecurring.value,
        categoryId: selectedCategoryId ?? -1,
        userId: sessionHelper.currentUser?.id ?? '',
      );
      BlocProvider.of<BillsCubit>(context).addBill(command);
    } else {
      final command = BillUpdateCommand(
        id: editingBill!.id,
        name: nameCtrl.text,
        value: AppHelpers.revertCurrency(valueCtrl.text) * 1.0,
        isRecurring: isRecurring.value,
        categoryId: selectedCategoryId ?? -1,
      );
      BlocProvider.of<BillsCubit>(context).updateBill(command);
    }
  }
}
