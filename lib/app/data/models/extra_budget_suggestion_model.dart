class ExtraBudgetSugestionModel {
  final String name;
  final String difficult;
  final String description;

  ExtraBudgetSugestionModel({
    required this.name,
    required this.difficult,
    required this.description,
  });

  factory ExtraBudgetSugestionModel.fromMap(Map<String, dynamic> map) {
    return ExtraBudgetSugestionModel(
      name: map['nome'],
      difficult: map['dificuldade'],
      description: map['descricao'],
    );
  }
}
