import 'package:flutter/material.dart';
import 'package:rocket_finances/app/core/helpers/app_helpers.dart';
import 'package:rocket_finances/app/data/models/bill_model.dart';

class BillTileWidget extends StatelessWidget {
  final BillModel bill;
  const BillTileWidget({super.key, required this.bill});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final containerColor = colorScheme.surfaceBright.withValues(alpha: .15);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: containerColor,
        border: Border.all(color: colorScheme.surfaceContainer),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              child: Icon(Icons.home_outlined),
            ),
            title: Text(bill.name),
            subtitle: Text(bill.categoryName),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppHelpers.formatCurrency(bill.value),
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                Text(
                  'Pagar',
                  style: TextStyle(
                    fontSize: 14,
                    color: colorScheme.primaryFixedDim,
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: bill.totalPaid > 0,
            child: Column(
              children: [
                LinearProgressIndicator(
                  value: bill.totalPaidProportion,
                  minHeight: 5,
                  borderRadius: BorderRadius.circular(10),
                  backgroundColor: colorScheme.surface,
                  color: colorScheme.primaryContainer,
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${bill.paidPercentage}% pago',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: colorScheme.primary,
                      ),
                    ),
                    Visibility(
                      visible: bill.totalPaid < bill.value,
                      child: Text(
                        'Restante: ${AppHelpers.formatCurrency(bill.remainingValue)}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: colorScheme.onSurface.withValues(alpha: .7),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
