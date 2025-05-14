import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rocket_finances/app/core/values/images.dart';
import 'package:rocket_finances/app/ui/shared/widgets/gradient_text.dart';

class AiAnalyticsScreen extends StatefulWidget {
  const AiAnalyticsScreen({super.key});

  @override
  State<AiAnalyticsScreen> createState() => _AiAnalyticsScreenState();
}

class _AiAnalyticsScreenState extends State<AiAnalyticsScreen>
    with SingleTickerProviderStateMixin {
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
  }

  @override
  void dispose() {
    animationController.dispose();
    periodicAnim.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  'Nossa IA analisará seus dados financeiros dos últimos 3 meses para fornecer insights personalizados e sugestões acionáveis.',
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
                    onPressed: () {},
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
            )
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
}
