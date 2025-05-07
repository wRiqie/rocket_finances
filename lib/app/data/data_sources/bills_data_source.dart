import 'package:rocket_finances/app/core/values/functions.dart';
import 'package:rocket_finances/app/core/values/tables.dart';
import 'package:rocket_finances/app/data/models/bill_model.dart';
import 'package:rocket_finances/app/data/models/commands/bill/bill_add_command.dart';
import 'package:rocket_finances/app/data/models/commands/bill/bill_update_command.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BillsDataSource {
  Future<List<BillModel>> getAllBillsByUserId(String id);

  Future<void> addBill(BillAddCommand command);

  Future<void> updateBill(BillUpdateCommand command);

  Future<void> deleteBillMonthById(int id);

  Future<void> deleteBillById(int id);
}

class BillsDataSourceSupaImp implements BillsDataSource {
  final SupabaseClient _client;

  BillsDataSourceSupaImp(this._client);

  @override
  Future<List<BillModel>> getAllBillsByUserId(String id) async {
    final response = await _client
        .rpc(Functions.getUserBills, params: {'usr_id': id}).select();

    return response.isNotEmpty
        ? response.map((e) => BillModel.fromMap(e)).toList()
        : [];
  }

  @override
  Future<void> addBill(BillAddCommand command) async {
    await _client.from(Tables.bills).insert(command.toMap());
  }

  @override
  Future<void> updateBill(BillUpdateCommand command) async {
    final isRecurring = command.isRecurring;

    if (isRecurring) {
      final response = await _client
          .rpc(Functions.checkBillOverride, params: {'bil_id': command.id});

      if (response.isNotEmpty) {
        final id = response.first[Functions.checkBillOverride];

        await _client
            .from(Tables.billsOverrides)
            .update({'new_value': command.value}).eq('id', id);
      } else {
        await _client
            .from(Tables.billsOverrides)
            .insert({'new_value': command.value, 'bill_id': command.id});
      }

      await _client
          .from(Tables.bills)
          .update({'name': command.name, 'category_id': command.categoryId}).eq(
              'id', command.id);
    } else {
      await _client
          .from(Tables.bills)
          .update(command.toMap())
          .eq('id', command.id);
    }
  }

  @override
  Future<void> deleteBillById(int id) async {
    await _client.from(Tables.bills).delete().eq('id', id);
  }

  @override
  Future<void> deleteBillMonthById(int id) {
    // TODO: implement deleteBillMonthById
    throw UnimplementedError();
  }
}
