import 'package:flutter/material.dart';
import 'package:rocket_finances/app/core/helpers/app_helpers.dart';
import 'package:rocket_finances/app/data/models/receipt_model.dart';

class ReceiptTileWidget extends StatelessWidget {
  final ReceiptModel receipt;
  final VoidCallback? onTap;
  const ReceiptTileWidget({super.key, required this.receipt, this.onTap});

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
          border: Border.all(color: colorScheme.surfaceContainer),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                child: Icon(Icons.monetization_on_outlined),
              ),
              title: Text(receipt.name),
              trailing: Text(
                AppHelpers.formatCurrency(receipt.value),
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
