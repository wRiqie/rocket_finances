import 'package:rocket_finances/app/core/values/functions.dart';
import 'package:rocket_finances/app/data/models/bill_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BillsDataSource {
  Future<List<BillModel>> getAllBills();
}

class BillsDataSourceSupaImp implements BillsDataSource {
  final SupabaseClient _client;

  BillsDataSourceSupaImp(this._client);

  @override
  Future<List<BillModel>> getAllBills() async {
    final user = _client.auth.currentUser;

    if (user != null) {
      final response = await _client
          .rpc(Functions.getUserBills, params: {'user_id': user.id}).select();

      return response.isNotEmpty
          ? response.map((e) => BillModel.fromMap(e)).toList()
          : [];
    }

    return [];
  }
}
