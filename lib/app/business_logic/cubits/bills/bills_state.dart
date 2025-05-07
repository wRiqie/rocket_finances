import 'package:rocket_finances/app/data/models/bill_model.dart';
import 'package:rocket_finances/app/data/models/error_model.dart';

enum BillsStatus {
  idle,
  loading,
  success,
  error;

  bool get isLoading => this == BillsStatus.loading;
  bool get isSuccess => this == BillsStatus.success;
  bool get isError => this == BillsStatus.error;
}

class BillsState {
  final List<BillModel> bills;
  final BillsStatus status;
  final ErrorModel? error;

  BillsState({
    this.status = BillsStatus.idle,
    this.error,
    this.bills = const [],
  });

  BillsState copyWith({
    required BillsStatus status,
    List<BillModel>? bills,
    ErrorModel? error,
  }) {
    return BillsState(
      status: status,
      bills: bills ?? this.bills,
      error: error ?? this.error,
    );
  }
}
