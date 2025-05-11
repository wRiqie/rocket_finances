import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rocket_finances/app/business_logic/cubits/receipts/receipts_cubit.dart';
import 'package:rocket_finances/app/ui/modules/add_receipt/add_receipt_screen.dart';

class AddReceipt extends StatelessWidget {
  const AddReceipt({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReceiptsCubit(GetIt.I()),
      child: AddReceiptScreen(),
    );
  }
}
