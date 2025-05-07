import 'package:rocket_finances/app/core/values/tables.dart';
import 'package:rocket_finances/app/data/models/budget_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BudgetsDataSource {
  Future<List<BudgetModel>> getAllBudgetsByUserId(String id);
}

class BudgetsDataSourceSupaImp implements BudgetsDataSource {
  final SupabaseClient _client;

  BudgetsDataSourceSupaImp(this._client);

  @override
  Future<List<BudgetModel>> getAllBudgetsByUserId(String id) async {
    final response = await _client
        .from(Tables.budgets)
        .select('id, name, value')
        .eq('user_id', id);

    return response.isNotEmpty
        ? response.map((e) => BudgetModel.fromMap(e)).toList()
        : [];
  }
}
