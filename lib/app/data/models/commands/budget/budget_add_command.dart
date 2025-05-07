class BudgetAddCommand {
  final String name;
  final double value;
  final String iconUrl;

  BudgetAddCommand({
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
