import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:rocket_finances/app/business_logic/cubits/analysis/analysis_cubit.dart';
import 'package:rocket_finances/app/business_logic/cubits/analysis/analysis_state.dart';
import 'package:rocket_finances/app/core/values/animations.dart';
import 'package:rocket_finances/app/core/values/snackbars.dart';
import 'package:rocket_finances/app/data/models/args/loading_analysis_args.dart';
import 'package:rocket_finances/app/data/models/commands/ai_analysis_command.dart';
import 'package:rocket_finances/app/ui/shared/widgets/gradient_text.dart';

class LoadingAnalysisScreen extends StatefulWidget {
  const LoadingAnalysisScreen({super.key});

  @override
  State<LoadingAnalysisScreen> createState() => _LoadingAnalysisScreenState();
}

class _LoadingAnalysisScreenState extends State<LoadingAnalysisScreen> {
  final gradient = LinearGradient(
    colors: [
      const Color.fromARGB(255, 112, 36, 243),
      const Color.fromARGB(255, 148, 94, 240),
    ],
  );

  late Timer timer;
  ValueNotifier<double> progress = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AnalysisCubit>(context).stream.listen(
      (event) {
        if (event.status.isSuccess) {
          Future.delayed(Duration(milliseconds: 500), () {
            if (mounted) {
              Navigator.pop(context, true);
            }
          });
        }
      },
    );
    timer = _getTimer();

    scheduleMicrotask(_requestAnalysis);
  }

  @override
  void dispose() {
    timer.cancel();
    progress.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocListener<AnalysisCubit, AnalysisState>(
      listener: (context, state) {
        if (state.status.isError) {
          ErrorSnackbar(context, message: state.error?.message);
        }
      },
      child: PopScope(
        canPop: false,
        child: BlocBuilder<AnalysisCubit, AnalysisState>(
          builder: (context, state) {
            if (state.status.isError) {
              return Scaffold(
                body: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Ocorreu um erro'),
                      TextButton.icon(
                        onPressed: () {
                          progress.value = 0;
                          timer = _getTimer();
                          _requestAnalysis();
                        },
                        icon: Icon(Icons.refresh),
                        label: Text('Tentar novamente'),
                      ),
                    ],
                  ),
                ),
              );
            }

            return Scaffold(
              bottomNavigationBar: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.paddingOf(context).bottom,
                    left: 18,
                    right: 18),
                child: Text(
                  'Leva de 5 a 15 segundos normalmente',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: colorScheme.onSurface.withValues(alpha: .6),
                  ),
                ),
              ),
              body: SafeArea(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(Animations.aiThinking, width: 150),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GradientText(
                          'Gerando sua análise!',
                          gradient: gradient,
                          align: TextAlign.center,
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.w800),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          'Em segundos você terá uma análise completa de suas finanças!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: colorScheme.onSurface.withValues(alpha: .6),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            return Stack(
                              children: [
                                Container(
                                  width: constraints.maxWidth,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: colorScheme.onSurface
                                        .withValues(alpha: .08),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                Container(
                                  width: constraints.maxWidth * progress.value,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    gradient: gradient,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                                '${(progress.value * 100).toStringAsFixed(0)}% gerado'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _requestAnalysis() {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is LoadingAnalysisArgs) {
      final command = AiAnalysisCommand(
        skills: args.skills,
        goal: args.goalDescription,
        requiredValue: args.requiredValue,
        savedValue: args.savedValue,
        due: args.due,
      );

      BlocProvider.of<AnalysisCubit>(context).requestAnalysis(command);
    } else {
      Navigator.pop(context);
    }
  }

  Timer _getTimer() {
    return Timer.periodic(Duration(milliseconds: 1000), (tick) {
      if (progress.value <= .75) {
        setState(() {
          progress.value += .25;
        });
      }
    });
  }
}
