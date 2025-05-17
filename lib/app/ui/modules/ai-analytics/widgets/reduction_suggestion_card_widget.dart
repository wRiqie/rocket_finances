import 'package:flutter/material.dart';
import 'package:rocket_finances/app/core/helpers/app_helpers.dart';
import 'package:rocket_finances/app/data/models/reduction_suggestion_model.dart';

class ReductionSuggestionCardWidget extends StatelessWidget {
  final ReductionSugestionModel suggestion;
  const ReductionSuggestionCardWidget({super.key, required this.suggestion});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: colorScheme.surfaceContainer),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            spacing: 12,
            children: [
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(73, 76, 175, 79),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.remove,
                  color: Colors.green,
                ),
              ),
              Expanded(
                child: Text(
                  suggestion.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Valor atual:',
                style: TextStyle(
                  color: colorScheme.onSurface.withValues(alpha: .7),
                ),
              ),
              Text(
                AppHelpers.formatCurrency(suggestion.currentValue),
                style: TextStyle(
                  color: const Color.fromARGB(255, 241, 101, 91),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Valor sugerido:',
                style: TextStyle(
                  color: colorScheme.onSurface.withValues(alpha: .7),
                ),
              ),
              Text(
                AppHelpers.formatCurrency(suggestion.suggestionValue),
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Divider(),
          ),
          Text(
            suggestion.description,
            style: TextStyle(
              color: colorScheme.onSurface,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
