import 'package:rocket_finances/app/data/models/extra_budget_suggestion_model.dart';
import 'package:rocket_finances/app/data/models/reduction_suggestion_model.dart';

class AnalysisModel {
  final String goalStatus;
  final double monthlySavings;
  final String analysis;
  final List<ReductionSugestionModel> reductionSugestions;
  final List<ExtraBudgetSugestionModel> extraBudgetSugestions;

  AnalysisModel({
    required this.goalStatus,
    required this.monthlySavings,
    required this.analysis,
    required this.reductionSugestions,
    required this.extraBudgetSugestions,
  });

  factory AnalysisModel.fromMap(Map<String, dynamic> map) {
    final data = map['result'];

    return AnalysisModel(
        goalStatus: data['meta_ok'],
        monthlySavings: data['economia_mensal'] * 1.0,
        analysis: data['analise'],
        reductionSugestions: (data['sugestoes_de_reducao'] as List)
            .map((x) => ReductionSugestionModel.fromMap(x))
            .toList(),
        extraBudgetSugestions: (data['sugestoes_renda_extra'] as List)
            .map((x) => ExtraBudgetSugestionModel.fromMap(x))
            .toList());
  }
}
