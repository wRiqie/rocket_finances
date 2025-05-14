import 'package:flutter/material.dart';
import 'package:rocket_finances/app/core/helpers/app_helpers.dart';
import 'package:rocket_finances/app/data/models/bill_model.dart';

class BillTileWidget extends StatelessWidget {
  final BillModel bill;
  final VoidCallback? onTap;
  final VoidCallback? onTapPay;

  final bool useVariant;
  const BillTileWidget({
    super.key,
    required this.bill,
    this.onTap,
    this.onTapPay,
    this.useVariant = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final containerColor = colorScheme.surfaceBright.withValues(alpha: .15);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: containerColor,
          border: Border.all(
              color: useVariant
                  ? colorScheme.surface
                  : colorScheme.surfaceContainer),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                child: bill.categoryLogoUrl != null
                    ? Image.network(bill.categoryLogoUrl!)
                    : Icon(Icons.question_mark),
              ),
              title: Text(
                bill.name,
                softWrap: false,
                overflow: TextOverflow.fade,
              ),
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
                  Visibility(
                    visible: bill.isPaid,
                    child: Row(
                      spacing: 6,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check,
                          size: 14,
                          color: Colors.green,
                        ),
                        Text(
                          'Pago',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: onTapPay != null && !bill.isPaid,
                    child: GestureDetector(
                      onTap: onTapPay,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          'Pagar',
                          style: TextStyle(
                            fontSize: 14,
                            color: colorScheme.primaryFixedDim,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: bill.totalPaid > 0 && !bill.isPaid,
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
      ),
    );
  }
}
