import 'package:rocket_finances/app/core/values/tables.dart';
import 'package:rocket_finances/app/data/models/commands/receipt/receipt_add_command.dart';
import 'package:rocket_finances/app/data/models/commands/receipt/receipt_update_command.dart';
import 'package:rocket_finances/app/data/models/receipt_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ReceiptsDataSource {
  Future<List<ReceiptModel>> getAllReceiptsByUserId(String id);

  Future<void> addReceipt(ReceiptAddCommand command);

  Future<void> updateReceipt(ReceiptUpdateCommand command);

  Future<void> deleteReceiptById(int id);
}

class ReceiptsDataSourceSupaImp implements ReceiptsDataSource {
  final SupabaseClient _client;

  ReceiptsDataSourceSupaImp(this._client);

  @override
  Future<List<ReceiptModel>> getAllReceiptsByUserId(String id) async {
    final response = await _client
        .from(Tables.receipts)
        .select('id, name, value')
        .eq('user_id', id);

    return response.isNotEmpty
        ? response.map((e) => ReceiptModel.fromMap(e)).toList()
        : [];
  }

  @override
  Future<void> addReceipt(ReceiptAddCommand command) async {
    await _client.from(Tables.receipts).insert(command.toMap());
  }

  @override
  Future<void> updateReceipt(ReceiptUpdateCommand command) async {
    await _client.from(Tables.receipts).update(command.toMap());
  }

  @override
  Future<void> deleteReceiptById(int id) async {
    await _client.from(Tables.receipts).delete().eq('id', id);
  }
}
