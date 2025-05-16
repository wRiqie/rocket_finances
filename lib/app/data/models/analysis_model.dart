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
    return AnalysisModel(
      goalStatus: map['meta_ok'],
      monthlySavings: map['economia_mensal'],
      analysis: map['analise'],
      reductionSugestions: List<ReductionSugestionModel>.from(
        (map['sugestoes_de_reducao'] as List<int>).map<ReductionSugestionModel>(
          (x) => ReductionSugestionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      extraBudgetSugestions: List<ExtraBudgetSugestionModel>.from(
        (map['sugestoes_renda_extra'] as List<int>)
            .map<ExtraBudgetSugestionModel>(
          (x) => ExtraBudgetSugestionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
