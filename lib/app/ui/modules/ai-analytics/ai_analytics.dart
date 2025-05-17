import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rocket_finances/app/business_logic/cubits/analysis/analysis_cubit.dart';
import 'package:rocket_finances/app/ui/modules/ai-analytics/ai_analytics_screen.dart';

class AiAnalytics extends StatelessWidget {
  const AiAnalytics({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AnalysisCubit(GetIt.I()),
      child: AiAnalyticsScreen(),
    );
  }
}
