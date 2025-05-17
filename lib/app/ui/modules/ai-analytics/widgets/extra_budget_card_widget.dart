import 'package:flutter/material.dart';
import 'package:rocket_finances/app/data/models/extra_budget_suggestion_model.dart';

class ExtraBudgetCardWidget extends StatelessWidget {
  final ExtraBudgetSugestionModel suggestion;
  const ExtraBudgetCardWidget({super.key, required this.suggestion});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final difficultColor = suggestion.difficult == 'Fácil'
        ? Colors.green
        : suggestion.difficult == 'Médio'
            ? Colors.orange
            : Colors.red;

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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Row(
                  spacing: 12,
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(80, 255, 153, 0),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.orange,
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
              ),
              SizedBox(
                width: 12,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                    color: difficultColor.withValues(alpha: .4),
                    border: Border.all(
                      color: difficultColor,
                    ),
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  suggestion.difficult,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: difficultColor,
                  ),
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
