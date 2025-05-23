class BudgetUpdateCommand {
  final int id;
  final String name;
  final double value;

  BudgetUpdateCommand({
    required this.id,
    required this.name,
    required this.value,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'value': value,
    };
  }
}
