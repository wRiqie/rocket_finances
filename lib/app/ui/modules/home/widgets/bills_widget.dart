import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rocket_finances/app/business_logic/cubits/bills/bills_cubit.dart';
import 'package:rocket_finances/app/business_logic/cubits/bills/bills_state.dart';
import 'package:rocket_finances/app/core/helpers/session_helper.dart';
import 'package:rocket_finances/app/ui/modules/home/widgets/bill_tile_widget.dart';

class BillsWidget extends StatefulWidget {
  const BillsWidget({super.key});

  @override
  State<BillsWidget> createState() => _BillsWidgetState();
}

class _BillsWidgetState extends State<BillsWidget> {
  final sessionHelper = GetIt.I<SessionHelper>();

  @override
  void initState() {
    super.initState();
    scheduleMicrotask(_loadBills);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'A pagar',
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
        BlocBuilder<BillsCubit, BillsState>(
          builder: (context, state) {
            if (state.status.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                spacing: 8,
                children: state.bills
                    .take(3)
                    .map((e) => BillTileWidget(bill: e))
                    .toList(),
              );
            }
          },
        ),
      ],
    );
  }

  void _loadBills() {
    BlocProvider.of<BillsCubit>(context)
        .getAllByUserId(sessionHelper.currentUser?.id ?? '');
  }
}
