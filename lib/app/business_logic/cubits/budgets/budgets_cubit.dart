import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rocket_finances/app/business_logic/cubits/budgets/budgets_state.dart';
import 'package:rocket_finances/app/data/models/commands/budget/budget_add_command.dart';
import 'package:rocket_finances/app/data/models/commands/budget/budget_update_command.dart';
import 'package:rocket_finances/app/data/repositories/budget_repository.dart';

class BudgetsCubit extends Cubit<BudgetsState> {
  final BudgetRepository _budgetRepository;
  BudgetsCubit(this._budgetRepository) : super(BudgetsState());

  void getAllBudgetsByUserId(String id) async {
    emit(state.copyWith(status: BudgetsStatus.loading));

    final response = await _budgetRepository.getAllBudgetsByUserId(id);
    if (response.isSuccess) {
      emit(state.copyWith(
        status: BudgetsStatus.success,
        budgets: response.data,
      ));
    } else {
      emit(state.copyWith(
        status: BudgetsStatus.error,
        error: response.error,
      ));
    }
  }

  void addBudget(BudgetAddCommand command) async {
    emit(state.copyWith(status: BudgetsStatus.loading));

    final response = await _budgetRepository.addBudget(command);
    if (response.isSuccess) {
      emit(state.copyWith(status: BudgetsStatus.success));
    } else {
      emit(state.copyWith(
        status: BudgetsStatus.error,
        error: response.error,
      ));
    }
  }

  void updateBudget(BudgetUpdateCommand command) async {
    emit(state.copyWith(status: BudgetsStatus.loading));

    final response = await _budgetRepository.updateBudget(command);
    if (response.isSuccess) {
      emit(state.copyWith(status: BudgetsStatus.success));
    } else {
      emit(state.copyWith(
        status: BudgetsStatus.error,
        error: response.error,
      ));
    }
  }

  void deleteBudgetById(int id) async {
    emit(state.copyWith(status: BudgetsStatus.loading));

    final response = await _budgetRepository.deleteBudgetById(id);
    if (response.isSuccess) {
      emit(state.copyWith(status: BudgetsStatus.deleted));
    } else {
      emit(state.copyWith(
        status: BudgetsStatus.error,
        error: response.error,
      ));
    }
  }
}
