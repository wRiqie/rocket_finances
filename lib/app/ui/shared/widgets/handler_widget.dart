import 'package:flutter/material.dart';

class HandlerWidget extends StatelessWidget {
  const HandlerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
          color: colorScheme.surface, borderRadius: BorderRadius.circular(10)),
      height: 4,
      width: 100,
    );
  }
}
