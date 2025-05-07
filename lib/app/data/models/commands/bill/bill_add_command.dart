class BillAddCommand {
  final String name;
  final double value;
  final bool isRecurring;
  final int categoryId;
  final String userId;

  BillAddCommand({
    required this.name,
    required this.value,
    required this.isRecurring,
    required this.categoryId,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'value': value,
      'is_recurring': isRecurring,
      'category_id': categoryId,
      'user_id': userId,
    };
  }
}
