import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rocket_finances/app/business_logic/cubits/bills/bills_cubit.dart';
import 'package:rocket_finances/app/ui/modules/add_bill/add_bill_screen.dart';

class AddBill extends StatelessWidget {
  const AddBill({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BillsCubit(GetIt.I()),
      child: AddBillScreen(),
    );
  }
}
