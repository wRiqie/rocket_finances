class ReductionSugestionModel {
  final String name;
  final String currentValue;
  final String suggestionValue;
  final String description;

  ReductionSugestionModel(
      {required this.name,
      required this.currentValue,
      required this.suggestionValue,
      required this.description});

  factory ReductionSugestionModel.fromMap(Map<String, dynamic> map) {
    return ReductionSugestionModel(
      name: map['nome'],
      currentValue: map['valor_atual'],
      suggestionValue: map['valor_sugerido'],
      description: map['descricao'],
    );
  }
}
