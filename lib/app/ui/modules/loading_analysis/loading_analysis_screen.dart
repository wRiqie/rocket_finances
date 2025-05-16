import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rocket_finances/app/core/values/animations.dart';
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
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return PopScope(
      canPop: false,
      child: Scaffold(
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
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
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
                              color:
                                  colorScheme.onSurface.withValues(alpha: .08),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          Container(
                            width: constraints.maxWidth * .5,
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
                      Text('30% gerado'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
