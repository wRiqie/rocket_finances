import 'package:rocket_finances/app/data/models/budget_model.dart';
import 'package:rocket_finances/app/data/models/error_model.dart';

enum BudgetsStatus {
  idle,
  loading,
  success,
  deleted,
  error;

  bool get isLoading => this == BudgetsStatus.loading;
  bool get isSuccess => this == BudgetsStatus.success;
  bool get isDeleted => this == BudgetsStatus.deleted;
  bool get isError => this == BudgetsStatus.error;
}

class BudgetsState {
  final List<BudgetModel> budgets;
  final BudgetsStatus status;
  final ErrorModel? error;

  BudgetsState({
    this.status = BudgetsStatus.idle,
    this.error,
    this.budgets = const [],
  });

  BudgetsState copyWith({
    required BudgetsStatus status,
    List<BudgetModel>? budgets,
    ErrorModel? error,
  }) {
    return BudgetsState(
      status: status,
      budgets: budgets ?? this.budgets,
      error: error ?? this.error,
    );
  }
}
