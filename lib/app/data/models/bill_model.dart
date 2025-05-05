class BillModel {
  final int id;
  final String name;
  final String? categoryLogoUrl;
  final String categoryName;
  final double value;
  final bool isRecurring;
  final bool isInstallment;
  final int? installmentsAmount;

  BillModel(
      {required this.id,
      required this.name,
      required this.categoryLogoUrl,
      required this.categoryName,
      required this.value,
      required this.isRecurring,
      required this.isInstallment,
      required this.installmentsAmount});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'category_icon_url': categoryLogoUrl,
      'category_name': categoryName,
      'value': value,
      'is_recurring': isRecurring,
      'is_installment': isInstallment,
      'installments_amount': installmentsAmount,
    };
  }

  factory BillModel.fromMap(Map<String, dynamic> map) {
    return BillModel(
      id: map['id'],
      name: map['name'],
      categoryLogoUrl: map['category_icon_url'],
      categoryName: map['category_name'],
      value: map['value'] * 1.0,
      isRecurring: map['is_recurring'],
      isInstallment: map['is_installment'],
      installmentsAmount: map['installments_amount'],
    );
  }
}
