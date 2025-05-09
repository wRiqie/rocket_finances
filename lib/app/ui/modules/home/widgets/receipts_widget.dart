import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rocket_finances/app/business_logic/cubits/receipts/receipts_cubit.dart';
import 'package:rocket_finances/app/business_logic/cubits/receipts/receipts_state.dart';
import 'package:rocket_finances/app/ui/modules/home/widgets/receipt_tile_widget.dart';

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
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recebimentos',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: colorScheme.onSurface.withValues(alpha: .45)),
            ),
            TextButton(
              onPressed: () {},
              child: Text('Ver tudo'),
            ),
          ],
        ),
        BlocBuilder<ReceiptsCubit, ReceiptsState>(
          builder: (context, state) {
            if (state.status.isLoading) {
              // TODO skeleton
              return SizedBox.shrink();
            } else if (state.status.isSuccess) {
              if (state.receipts.isNotEmpty) {
                return Column(
                  children: state.receipts
                      .map((e) => ReceiptTileWidget(receipt: e))
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
}
