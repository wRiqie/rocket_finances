import 'package:flutter/material.dart';
import 'package:rocket_finances/app/ui/modules/goal/widgets/goal_step_widget.dart';
import 'package:rocket_finances/app/ui/modules/goal/widgets/skills_step_widget.dart';
import 'package:rocket_finances/routes/app_pages.dart';

class GoalScreen extends StatefulWidget {
  const GoalScreen({super.key});

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  List<Widget> steps = [];
  int currentIndex = 0;

  String? goalDescription;
  int? months;

  @override
  void initState() {
    super.initState();
    steps = [
      GoalStepWidget(
        onNext: (goal, months) {
          goalDescription = goal;
          months = months;
          setState(() {
            currentIndex++;
          });
        },
      ),
      SkillsStepWidget(
        onConfirm: (skills) {
          Navigator.pushReplacementNamed(context, AppRoutes.loadingAnalysis);
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final backgroundGradient = LinearGradient(
      colors: [
        const Color.fromARGB(255, 112, 36, 243),
        colorScheme.surface,
      ],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    );

    return Stack(
      children: [
        Container(
          color: colorScheme.surface,
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Opacity(
            opacity: .2,
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                gradient: backgroundGradient,
              ),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text('Análise financeira'),
          ),
          body: steps[currentIndex],
        ),
      ],
    );
  }
}
