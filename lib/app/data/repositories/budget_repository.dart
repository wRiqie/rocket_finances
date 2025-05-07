import 'package:rocket_finances/app/data/data_sources/budgets_data_source.dart';
import 'package:rocket_finances/app/data/models/budget_model.dart';
import 'package:rocket_finances/app/data/models/default_response_model.dart';
import 'package:rocket_finances/app/data/services/execute_service.dart';

abstract class BudgetRepository {
  Future<DefaultResponseModel<List<BudgetModel>>> getAllBudgetsByUserId(
      String id);
}

class BudgetRepositoryImp implements BudgetRepository {
  final BudgetsDataSource _budgetsDataSource;

  BudgetRepositoryImp(this._budgetsDataSource);

  @override
  Future<DefaultResponseModel<List<BudgetModel>>> getAllBudgetsByUserId(
      String id) {
    return ExecuteService.tryExecuteAsync(
        () => _budgetsDataSource.getAllBudgetsByUserId(id));
  }
}
