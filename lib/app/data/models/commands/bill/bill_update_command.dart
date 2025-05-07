import 'package:rocket_finances/app/core/values/extensions.dart';

class BillUpdateCommand {
  final int id;
  final String name;
  final double value;
  final bool isRecurring;
  final int categoryId;

  BillUpdateCommand(
      {required this.id,
      required this.name,
      required this.value,
      required this.isRecurring,
      required this.categoryId});

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'name': name,
      'value': value,
      'category_id': categoryId,
    };

    return {}..addAllNotNull(map);
  }
}
