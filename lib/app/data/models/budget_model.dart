class BudgetModel {
  final int id;
  final String name;
  final double value;

  BudgetModel({
    required this.id,
    required this.name,
    required this.value,
  });

  factory BudgetModel.fromMap(Map<String, dynamic> map) {
    return BudgetModel(
      id: map['id'],
      name: map['name'],
      value: map['value'] * 1.0,
    );
  }
}
