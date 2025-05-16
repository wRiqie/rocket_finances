import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rocket_finances/app/business_logic/cubits/receipts/receipts_cubit.dart';
import 'package:rocket_finances/app/business_logic/cubits/receipts/receipts_state.dart';
import 'package:rocket_finances/app/data/models/args/add_receipt_args.dart';
import 'package:rocket_finances/app/ui/modules/home/widgets/receipt_tile_widget.dart';
import 'package:rocket_finances/app/ui/shared/dialogs/decision_dialog.dart';
import 'package:rocket_finances/app/ui/shared/widgets/options_bottom_widget.dart';
import 'package:rocket_finances/routes/app_pages.dart';

import '../../../../core/helpers/session_helper.dart';

class ReceiptsWidget extends StatefulWidget {
  const ReceiptsWidget({super.key});

  @override
  State<ReceiptsWidget> createState() => _ReceiptsWidgetState();
}

class _ReceiptsWidgetState extends State<ReceiptsWidget> {
  final sessionHelper = GetIt.I<SessionHelper>();

  @override
  void initState() {
    super.initState();
    scheduleMicrotask(_loadReceipts);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BlocBuilder<ReceiptsCubit, ReceiptsState>(
          builder: (context, state) {
            if (state.status.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.status.isSuccess) {
              if (state.receipts.isNotEmpty) {
                return Column(
                  spacing: 12,
                  children: state.receipts
                      .map((e) => ReceiptTileWidget(
                            receipt: e,
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (_) => OptionsBottomWidget(
                                  onEdit: () async {
                                    final result = await Navigator.pushNamed(
                                      context,
                                      AppRoutes.addReceipt,
                                      arguments: AddReceiptArgs(e),
                                    );

                                    if (result == true && context.mounted) {
                                      _loadReceipts();
                                    }
                                  },
                                  onDelete: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => DecisionDialog(
                                        title: 'Deletar recebimento',
                                        content:
                                            'Tem certeza que deseja deletar o recebimento?',
                                        onConfirm: () => _deleteReceipt(e.id),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ))
                      .toList(),
                );
              } else {
                // TODO empty
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Ainda sem recebimentos :('),
                    ],
                  ),
                );
              }
            }
            // TODO error
            return SizedBox.shrink();
          },
        ),
      ],
    );
  }

  void _loadReceipts() {
    BlocProvider.of<ReceiptsCubit>(context)
        .getAllByUserId(sessionHelper.currentUser?.id ?? '');
  }

  void _deleteReceipt(int id) {
    BlocProvider.of<ReceiptsCubit>(context).deleteReceiptById(id);
  }
}
