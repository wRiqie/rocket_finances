class BillModel {
  final int id;
  final String name;
  final int categoryId;
  final String? categoryLogoUrl;
  final String categoryName;
  final double value;
  final double totalPaid;
  final bool isRecurring;

  BillModel({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.categoryLogoUrl,
    required this.categoryName,
    required this.value,
    required this.isRecurring,
    required this.totalPaid,
  });

  factory BillModel.fromMap(Map<String, dynamic> map) {
    return BillModel(
      id: map['id'],
      name: map['name'],
      categoryId: map['category_id'],
      categoryLogoUrl: map['category_icon_url'],
      categoryName: map['category_name'],
      value: map['value'] * 1.0,
      totalPaid: map['total_paid'] * 1.0,
      isRecurring: map['is_recurring'],
    );
  }

  double get totalPaidProportion => totalPaid > 0 ? totalPaid / value : 0;
  double get remainingValue => value - totalPaid;
  int get paidPercentage => ((totalPaid / value) * 100).round();
  bool get isPaid => totalPaid >= value;
}

extension BillsExt on List<BillModel> {
  double get totalPaid {
    return map((e) => e.totalPaid).reduce((value, element) => value + element);
  }

  double get value =>
      map((e) => e.value).reduce((value, element) => value + element);

  double get remainingValue =>
      map((e) => e.remainingValue).reduce((value, element) => value + element);

  double get totalPaidProportion => totalPaid / value;

  String get paidPercentage => ((totalPaid / value) * 100).toStringAsFixed(1);
}
