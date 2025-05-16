import 'package:rocket_finances/app/data/data_sources/budgets_data_source.dart';
import 'package:rocket_finances/app/data/models/budget_model.dart';
import 'package:rocket_finances/app/data/models/commands/budget/budget_add_command.dart';
import 'package:rocket_finances/app/data/models/commands/budget/budget_update_command.dart';
import 'package:rocket_finances/app/data/models/default_response_model.dart';
import 'package:rocket_finances/app/data/services/execute_service.dart';

abstract class BudgetRepository {
  Future<DefaultResponseModel<List<BudgetModel>>> getAllBudgetsByUserId(
      String id);

  Future<DefaultResponseModel<void>> addBudget(BudgetAddCommand command);

  Future<DefaultResponseModel<void>> updateBudget(BudgetUpdateCommand command);

  Future<DefaultResponseModel<void>> deleteBudgetById(int id);
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

  @override
  Future<DefaultResponseModel<void>> addBudget(BudgetAddCommand command) {
    return ExecuteService.tryExecuteAsync(
        () => _budgetsDataSource.addBudget(command));
  }

  @override
  Future<DefaultResponseModel<void>> deleteBudgetById(int id) {
    return ExecuteService.tryExecuteAsync(
        () => _budgetsDataSource.deleteBudgetById(id));
  }

  @override
  Future<DefaultResponseModel<void>> updateBudget(BudgetUpdateCommand command) {
    return ExecuteService.tryExecuteAsync(
        () => _budgetsDataSource.updateBudget(command));
  }
}
