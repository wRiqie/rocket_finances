import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rocket_finances/app/core/values/animations.dart';

class AiAnalyticsScreen extends StatefulWidget {
  const AiAnalyticsScreen({super.key});

  @override
  State<AiAnalyticsScreen> createState() => _AiAnalyticsScreenState();
}

class _AiAnalyticsScreenState extends State<AiAnalyticsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  late Animation<double> fadeInAnim;
  late Animation<double> positionAnim;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    );

    fadeInAnim = Tween<double>(begin: 0, end: 1).animate(animationController);
    positionAnim =
        Tween<double>(begin: -10, end: 0).animate(animationController);

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        spacing: 24,
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(Animations.ai,
              width: 150, repeat: false, controller: animationController),
          AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, positionAnim.value),
                  child: Opacity(
                    opacity: fadeInAnim.value,
                    child: Column(
                      spacing: 10,
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          decoration: BoxDecoration(
                            color: colorScheme.primaryContainer
                                .withValues(alpha: .4),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'Análise de IA',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.primary,
                                fontSize: 18),
                          ),
                        ),
                        Text(
                          'Hora de impulsionar ainda mais suas finanças e alcançar seus objetivos',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                        ElevatedButton.icon(
                          onPressed: null,
                          label: Text('Use o app por 3 meses'),
                          icon: Icon(Icons.lock),
                        ),
                      ],
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }
}
