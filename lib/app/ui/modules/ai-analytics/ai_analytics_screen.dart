import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:rocket_finances/app/business_logic/cubits/analysis/analysis_cubit.dart';
import 'package:rocket_finances/app/business_logic/cubits/analysis/analysis_state.dart';
import 'package:rocket_finances/app/core/helpers/app_helpers.dart';
import 'package:rocket_finances/app/core/helpers/session_helper.dart';
import 'package:rocket_finances/app/core/values/images.dart';
import 'package:rocket_finances/app/data/models/analysis_model.dart';
import 'package:rocket_finances/app/ui/modules/ai-analytics/widgets/extra_budget_card_widget.dart';
import 'package:rocket_finances/app/ui/modules/ai-analytics/widgets/reduction_suggestion_card_widget.dart';
import 'package:rocket_finances/app/ui/shared/widgets/gradient_text.dart';
import 'package:rocket_finances/routes/app_pages.dart';

class AiAnalyticsScreen extends StatefulWidget {
  const AiAnalyticsScreen({super.key});

  @override
  State<AiAnalyticsScreen> createState() => _AiAnalyticsScreenState();
}

class _AiAnalyticsScreenState extends State<AiAnalyticsScreen>
    with SingleTickerProviderStateMixin {
  final sessionHelper = GetIt.I<SessionHelper>();

  late AnimationController animationController;

  late Animation<double> fadeAnim;
  late Animation<double> scaleAnim;

  final gradient = LinearGradient(
    colors: [
      const Color.fromARGB(255, 112, 36, 243),
      const Color.fromARGB(255, 148, 94, 240),
    ],
  );

  late Timer periodicAnim;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    fadeAnim = Tween<double>(begin: .6, end: 0).animate(animationController);
    scaleAnim = Tween<double>(begin: 1, end: 1.5).animate(animationController);

    Future.delayed(Duration(milliseconds: 300), animationController.forward);
    periodicAnim = Timer.periodic(Duration(seconds: 5), (_) {
      animationController.reset();
      animationController.forward();
    });

    scheduleMicrotask(() {
      _loadAnalysis();
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    periodicAnim.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalysisCubit, AnalysisState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.status.isError) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Ocorreu um erro ao carregar a análise'),
                TextButton.icon(
                  onPressed: _loadAnalysis,
                  icon: Icon(Icons.refresh),
                  label: Text('Tentar novamente'),
                ),
              ],
            ),
          );
        } else if (state.status.isSuccess) {
          if (state.analysis != null) {
            return _buildAnalysisInfo(state.analysis!);
          } else {
            return _buildNoAnalysis();
          }
        }
        return SizedBox();
      },
    );
  }

  Widget _buildAnalysisInfo(AnalysisModel analysisInfo) {
    final colorScheme = Theme.of(context).colorScheme;
    final containerColor = colorScheme.surfaceBright.withValues(alpha: .15);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 20, 18, 0),
        child: Column(
          spacing: 12,
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: containerColor,
                border: Border.all(color: colorScheme.surfaceContainer),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          spacing: 12,
                          children: [
                            SvgPicture.asset(
                              Images.goal,
                              colorFilter: ColorFilter.mode(
                                colorScheme.primary,
                                BlendMode.srcIn,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Viabilidade de meta',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: colorScheme.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(102, 221, 134, 4),
                            border: Border.all(
                              color: const Color(0xFFDD8604),
                            ),
                            borderRadius: BorderRadius.circular(4)),
                        child: Text(
                          analysisInfo.goalStatus,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFDD8604),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Análise: ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, height: 1.25),
                      children: [
                        TextSpan(
                          text: analysisInfo.analysis,
                          style: TextStyle(fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: containerColor,
                border: Border.all(color: colorScheme.surfaceContainer),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    spacing: 12,
                    children: [
                      SvgPicture.asset(
                        Images.trendingDown,
                        colorFilter: ColorFilter.mode(
                          colorScheme.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Sugestões de redução de gasto',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Economia mínima: ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, height: 1.25),
                      children: [
                        TextSpan(
                          text: AppHelpers.formatCurrency(
                              analysisInfo.monthlySavings),
                          style: TextStyle(fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Column(
                    spacing: 10,
                    children: analysisInfo.reductionSugestions
                        .map(
                          (e) => ReductionSuggestionCardWidget(suggestion: e),
                        )
                        .toList(),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: containerColor,
                border: Border.all(color: colorScheme.surfaceContainer),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    spacing: 12,
                    children: [
                      SvgPicture.asset(
                        Images.trendingUp,
                        colorFilter: ColorFilter.mode(
                          colorScheme.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Sugestões de renda extra',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Column(
                    spacing: 10,
                    children: analysisInfo.extraBudgetSugestions
                        .map(
                          (e) => ExtraBudgetCardWidget(suggestion: e),
                        )
                        .toList(),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoAnalysis() {
    final colorScheme = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          spacing: 24,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                AnimatedBuilder(
                    animation: animationController,
                    builder: (context, _) {
                      return Transform.scale(
                        scale: scaleAnim.value,
                        child: Opacity(
                          opacity: fadeAnim.value,
                          child: Container(
                            padding: EdgeInsets.all(50),
                            decoration: BoxDecoration(
                              color: colorScheme.primaryContainer,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      );
                    }),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    Images.brain,
                    width: 60,
                    colorFilter: ColorFilter.mode(
                      colorScheme.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              spacing: 10,
              children: [
                GradientText(
                  'Análise Inteligente',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: colorScheme.primary,
                    fontSize: 26,
                  ),
                  gradient: gradient,
                  align: TextAlign.center,
                ),
                Text(
                  'Nossa IA analisará seus dados financeiros para fornecer insights personalizados e sugestões acionáveis.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 12,
                ),
                _buildItem(
                    Images.goal,
                    'Viabilidade de Metas',
                    'Avaliação se suas metas financeiras são alcançaveis',
                    Colors.blue),
                _buildItem(
                    Images.trendingDown,
                    'Sugestões de Redução de Custos',
                    'Identificação de áreas onde você pode economizar',
                    Colors.green),
                _buildItem(
                    Images.trendingUp,
                    'Dicas de Renda Extra',
                    'Sugestões para aumentar sua renda com base no seu perfil',
                    Colors.orange),
                SizedBox(
                  height: 30,
                ),
                // SizedBox(
                //   height: 45,
                //   child: ElevatedButton.icon(
                //     onPressed: null,
                //     label: Text('Anote suas finanças por 3 meses'),
                //     icon: Icon(Icons.lock),
                //   ),
                // ),
                Container(
                  decoration: BoxDecoration(
                      gradient: gradient,
                      borderRadius: BorderRadius.circular(30)),
                  height: 45,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      await Navigator.pushNamed(context, AppRoutes.goal);
                    },
                    label: Text('Analisar com IA'),
                    icon: SvgPicture.asset(
                      Images.sparkles,
                      width: 20,
                      colorFilter: ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        foregroundColor: Colors.white,
                        iconColor: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  ListTile _buildItem(String icon, String title, String subtitle, Color color) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: .4),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          icon,
          width: 24,
          colorFilter: ColorFilter.mode(
            color,
            BlendMode.srcIn,
          ),
        ),
      ),
      title: Text(title),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: colorScheme.onSurface.withValues(alpha: .7)),
      ),
    );
  }

  void _loadAnalysis() {
    final userId = sessionHelper.currentUser?.id;

    BlocProvider.of<AnalysisCubit>(context).getAnalysisById(userId ?? '');
  }
}
