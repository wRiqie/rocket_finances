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

    return ListTile(
      tileColor: containerColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: colorScheme.surfaceContainer),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 12),
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
    );
  }
}
