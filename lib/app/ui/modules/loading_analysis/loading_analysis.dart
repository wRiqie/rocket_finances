import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rocket_finances/app/business_logic/cubits/analysis/analysis_cubit.dart';
import 'package:rocket_finances/app/ui/modules/loading_analysis/loading_analysis_screen.dart';

class LoadingAnalysis extends StatelessWidget {
  const LoadingAnalysis({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AnalysisCubit(GetIt.I()),
      child: LoadingAnalysisScreen(),
    );
  }
}
