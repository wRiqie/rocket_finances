import 'package:rocket_finances/app/core/values/tables.dart';
import 'package:rocket_finances/app/data/models/budget_model.dart';
import 'package:rocket_finances/app/data/models/commands/budget/budget_add_command.dart';
import 'package:rocket_finances/app/data/models/commands/budget/budget_update_command.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BudgetsDataSource {
  Future<List<BudgetModel>> getAllBudgetsByUserId(String id);

  Future<void> addBudget(BudgetAddCommand command);

  Future<void> updateBudget(BudgetUpdateCommand command);

  Future<void> deleteBudgetById(int id);
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

  @override
  Future<void> addBudget(BudgetAddCommand command) async {
    await _client.from(Tables.budgets).insert(command.toMap());
  }

  @override
  Future<void> updateBudget(BudgetUpdateCommand command) async {
    await _client
        .from(Tables.budgets)
        .update(command.toMap())
        .eq('id', command.id);
  }

  @override
  Future<void> deleteBudgetById(int id) async {
    await _client.from(Tables.budgets).delete().eq('id', id);
  }
}
