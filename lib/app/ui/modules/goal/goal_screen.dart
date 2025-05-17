import 'package:flutter/material.dart';
import 'package:rocket_finances/app/data/models/args/loading_analysis_args.dart';
import 'package:rocket_finances/app/ui/modules/goal/widgets/goal_step_widget.dart';
import 'package:rocket_finances/app/ui/modules/goal/widgets/skills_step_widget.dart';
import 'package:rocket_finances/app/ui/modules/goal/widgets/values_step_widget.dart';
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
  int? due;
  double? requiredValue;
  double? savedValue;
  List<String> skills = [];

  @override
  void initState() {
    super.initState();
    steps = [
      GoalStepWidget(
        onNext: (goal, months) {
          goalDescription = goal;
          due = months;
          setState(() {
            currentIndex++;
          });
        },
      ),
      ValuesStepWidget(
        onConfirm: (requiredValue, savedValue) {
          this.requiredValue = requiredValue;
          this.savedValue = savedValue;
          setState(() {
            currentIndex++;
          });
        },
      ),
      SkillsStepWidget(
        onConfirm: (skills) {
          this.skills = skills;
          final args = LoadingAnalysisArgs(
            skills: this.skills,
            goalDescription: goalDescription ?? '',
            requiredValue: requiredValue ?? 0,
            savedValue: savedValue ?? 0,
            due: due ?? 0,
          );
          Navigator.pushReplacementNamed(context, AppRoutes.loadingAnalysis,
              arguments: args);
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
