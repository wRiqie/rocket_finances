import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rocket_finances/app/business_logic/cubits/bills/bills_cubit.dart';
import 'package:rocket_finances/app/business_logic/cubits/bills/bills_state.dart';
import 'package:rocket_finances/app/core/helpers/session_helper.dart';
import 'package:rocket_finances/app/core/values/snackbars.dart';
import 'package:rocket_finances/app/data/enum/delete_recurring_enum.dart';
import 'package:rocket_finances/app/data/models/args/add_bill_args.dart';
import 'package:rocket_finances/app/data/models/bill_model.dart';
import 'package:rocket_finances/app/ui/modules/home/widgets/bill_pay_bottom_widget.dart';
import 'package:rocket_finances/app/ui/modules/home/widgets/bill_recurring_bottom_widget.dart';
import 'package:rocket_finances/app/ui/modules/home/widgets/bill_tile_widget.dart';
import 'package:rocket_finances/app/ui/shared/dialogs/decision_dialog.dart';
import 'package:rocket_finances/app/ui/shared/widgets/options_bottom_widget.dart';
import 'package:rocket_finances/routes/app_pages.dart';

class BillGroupModel {
  final String title;
  final List<BillModel> bills;

  BillGroupModel({
    required this.title,
    required this.bills,
  });
}

class BillsWidget extends StatefulWidget {
  const BillsWidget({super.key});

  @override
  State<BillsWidget> createState() => _BillsWidgetState();
}

class _BillsWidgetState extends State<BillsWidget> {
  final sessionHelper = GetIt.I<SessionHelper>();

  Set<String> categories = {};
  List<BillGroupModel> billGroups = [];

  @override
  void initState() {
    super.initState();
    scheduleMicrotask(_loadBills);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocListener<BillsCubit, BillsState>(
      listener: (context, state) {
        if (state.status.isDeleted) {
          SuccessSnackbar(context, message: 'Conta deletada com sucesso');
          _loadBills();
        } else if (state.status.isPaid) {
          SuccessSnackbar(context, message: 'Valor pago com sucesso');
          _loadBills();
        } else if (state.status.isError) {
          ErrorSnackbar(context, message: state.error?.message);
        }
      },
      child: Column(
        children: [
          BlocBuilder<BillsCubit, BillsState>(
            builder: (context, state) {
              if (state.status.isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.status.isError) {
                return Column(
                  children: [
                    Icon(Icons.error_outline),
                    SizedBox(
                      height: 6,
                    ),
                    Text('Erro ao carregar contas'),
                    TextButton.icon(
                      onPressed: _loadBills,
                      label: Text('Recarregar'),
                      icon: Icon(Icons.refresh),
                    ),
                  ],
                );
              } else {
                if (state.bills.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Text('Ainda sem contas :('),
                  );
                }

                categories.clear();
                billGroups.clear();
                categories = state.bills.map((e) => e.categoryName).toSet();

                for (var category in categories) {
                  billGroups.add(BillGroupModel(
                      title: category,
                      bills: state.bills
                          .where((e) => e.categoryName == category)
                          .toList()));
                }

                return Column(
                  children: billGroups
                      .map((e) => Column(
                            children: [
                              Row(
                                spacing: 12,
                                children: [
                                  Text(
                                    e.title,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Expanded(child: Divider()),
                                  Text(
                                    '${e.bills.length} item(s)',
                                    style: TextStyle(
                                      color: colorScheme.onSurface
                                          .withValues(alpha: .6),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Column(
                                spacing: 12,
                                children: e.bills.map((e) {
                                  return BillTileWidget(
                                    bill: e,
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (_) {
                                          return OptionsBottomWidget(
                                            onEdit: () async {
                                              final result =
                                                  await Navigator.pushNamed(
                                                context,
                                                AppRoutes.addBill,
                                                arguments: AddBillArgs(e),
                                              );
                                              if (result == true &&
                                                  context.mounted) {
                                                _loadBills();
                                              }
                                            },
                                            onDelete: () {
                                              if (e.isRecurring) {
                                                showModalBottomSheet(
                                                  context: context,
                                                  builder: (context) =>
                                                      BillRecurringBottomWidget(
                                                    onDelete: (type) =>
                                                        _deleteRecurringBill(
                                                            e.id, type),
                                                  ),
                                                );
                                              } else {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      DecisionDialog(
                                                    title: 'Deletar conta?',
                                                    content:
                                                        'Tem certeza que deseja deletar a conta?',
                                                    onConfirm: () =>
                                                        _deleteBill(e.id),
                                                  ),
                                                );
                                              }
                                            },
                                          );
                                        },
                                      );
                                    },
                                    onTapPay: () {
                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        builder: (_) => BlocProvider.value(
                                          value: BlocProvider.of<BillsCubit>(
                                              context),
                                          child: BillPayBottomWidget(bill: e),
                                        ),
                                      );
                                    },
                                  );
                                }).toList(),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ))
                      .toList(),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  void _loadBills() {
    BlocProvider.of<BillsCubit>(context)
        .getAllByUserId(sessionHelper.currentUser?.id ?? '');
  }

  void _deleteBill(int id) {
    BlocProvider.of<BillsCubit>(context).deleteBillById(id, false);
  }

  void _deleteRecurringBill(int id, DeleteRecurringEnum type) {
    if (type.isOneMonth) {
      BlocProvider.of<BillsCubit>(context).deleteBillMonthById(id);
    } else {
      BlocProvider.of<BillsCubit>(context).deleteBillById(id, true);
    }
  }
}
