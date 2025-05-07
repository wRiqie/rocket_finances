class BudgetModel {
  final int id;
  final String name;
  final double value;
  final String iconUrl;

  BudgetModel(
      {required this.id,
      required this.name,
      required this.value,
      required this.iconUrl});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'value': value,
    };
  }

  factory BudgetModel.fromMap(Map<String, dynamic> map) {
    return BudgetModel(
      id: map['id'],
      name: map['name'],
      value: map['value'],
      iconUrl: map['icon_url'],
    );
  }
}
