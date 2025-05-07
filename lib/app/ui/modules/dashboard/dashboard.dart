import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rocket_finances/app/business_logic/cubits/receipts/receipts_cubit.dart';
import 'package:rocket_finances/app/ui/modules/dashboard/dashboard_screen.dart';

import '../../../business_logic/cubits/bills/bills_cubit.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BillsCubit(GetIt.I()),
        ),
        BlocProvider(
          create: (context) => ReceiptsCubit(GetIt.I()),
        ),
      ],
      child: DashboardScreen(),
    );
  }
}
