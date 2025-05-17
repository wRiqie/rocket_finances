class ReductionSugestionModel {
  final String name;
  final double currentValue;
  final double suggestionValue;
  final String description;

  ReductionSugestionModel(
      {required this.name,
      required this.currentValue,
      required this.suggestionValue,
      required this.description});

  factory ReductionSugestionModel.fromMap(Map<String, dynamic> map) {
    return ReductionSugestionModel(
      name: map['nome'],
      currentValue: map['valor_atual'] * 1.0,
      suggestionValue: map['valor_sugerido'] * 1.0,
      description: map['descricao'],
    );
  }
}
