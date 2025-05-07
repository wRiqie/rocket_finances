class BudgetUpdateCommand {
  final int id;
  final String name;
  final double value;
  final String iconUrl;

  BudgetUpdateCommand({
    required this.id,
    required this.name,
    required this.value,
    required this.iconUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'value': value,
      'icon_url': iconUrl,
    };
  }
}
