import 'package:flutter/material.dart';

class GlowLogoWidget extends StatelessWidget {
  const GlowLogoWidget({
    super.key,
    required this.colorScheme,
  });

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colorScheme.primaryContainer.withValues(alpha: .2),
          ),
        ),
        Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colorScheme.primaryContainer,
          ),
        ),
        Icon(Icons.monetization_on_outlined),
      ],
    );
  }
}
