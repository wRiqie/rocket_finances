class ReceiptAddCommand {
  final String name;
  final double value;
  final String userId;

  ReceiptAddCommand({
    required this.name,
    required this.value,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'value': value,
      'user_id': userId,
    };
  }
}
