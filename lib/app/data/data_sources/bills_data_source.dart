import 'package:rocket_finances/app/core/values/functions.dart';
import 'package:rocket_finances/app/data/models/bill_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BillsDataSource {
  Future<List<BillModel>> getAllBillsByUserId(String id);
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
}
