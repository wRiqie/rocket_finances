import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rocket_finances/app/business_logic/cubits/receipts/receipts_cubit.dart';
import 'package:rocket_finances/app/business_logic/cubits/receipts/receipts_state.dart';
import 'package:rocket_finances/app/core/helpers/app_helpers.dart';
import 'package:rocket_finances/app/core/helpers/session_helper.dart';
import 'package:rocket_finances/app/core/mixins/validators_mixin.dart';
import 'package:rocket_finances/app/core/values/snackbars.dart';
import 'package:rocket_finances/app/data/models/args/add_receipt_args.dart';
import 'package:rocket_finances/app/data/models/commands/receipt/receipt_add_command.dart';
import 'package:rocket_finances/app/data/models/commands/receipt/receipt_update_command.dart';
import 'package:rocket_finances/app/data/models/receipt_model.dart';

class AddReceiptScreen extends StatefulWidget {
  const AddReceiptScreen({super.key});

  @override
  State<AddReceiptScreen> createState() => _AddReceiptScreenState();
}

class _AddReceiptScreenState extends State<AddReceiptScreen>
    with ValidatorsMixin {
  final sessionHelper = GetIt.I<SessionHelper>();

  final formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final valueCtrl = TextEditingController();

  ReceiptModel? editingReceipt;

  @override
  void initState() {
    super.initState();

    scheduleMicrotask(
      () {
        final args =
            ModalRoute.of(context)?.settings.arguments as AddReceiptArgs?;

        if (args != null) {
          editingReceipt = args.editingReceipt;
          nameCtrl.text = editingReceipt!.name;
          valueCtrl.text = AppHelpers.formatCurrency(editingReceipt!.value);
        }
      },
    );
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    valueCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReceiptsCubit, ReceiptsState>(
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
              title: Text('Adicionar recebimento'),
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
                            keyboardType: TextInputType.number,
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
                            inputFormatters: [AppHelpers.currencyFormatter()],
                            keyboardType: TextInputType.number,
                            validator: (value) => combine([
                              () => isNotEmpty(value),
                              () => isMoreThanZero(value),
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
          BlocBuilder<ReceiptsCubit, ReceiptsState>(
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

  void _save() {
    if (!(formKey.currentState?.validate() ?? false)) return;

    if (editingReceipt == null) {
      final command = ReceiptAddCommand(
        name: nameCtrl.text,
        value: AppHelpers.revertCurrency(valueCtrl.text) * 1.0,
        userId: sessionHelper.currentUser?.id ?? '',
      );

      BlocProvider.of<ReceiptsCubit>(context).addReceipt(command);
    } else {
      final command = ReceiptUpdateCommand(
        id: editingReceipt!.id,
        name: nameCtrl.text,
        value: AppHelpers.revertCurrency(valueCtrl.text) * 1.0,
      );

      BlocProvider.of<ReceiptsCubit>(context).updateReceipt(command);
    }
  }
}
