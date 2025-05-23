class ReceiptModel {
  final int id;
  final String name;
  final double value;

  ReceiptModel({
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

  factory ReceiptModel.fromMap(Map<String, dynamic> map) {
    return ReceiptModel(
      id: map['id'],
      name: map['name'],
      value: map['value'] * 1.0,
    );
  }
}
