import 'package:flutter/material.dart';

class SpendBarWidget extends StatelessWidget {
  const SpendBarWidget({
    super.key,
    required this.size,
    required this.colorScheme,
  });

  final Size size;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: size.width,
          height: 14,
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        Container(
          width: size.width / 1.5,
          height: 14,
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(40),
          ),
        )
      ],
    );
  }
}
