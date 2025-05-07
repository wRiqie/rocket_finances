import 'package:rocket_finances/app/data/models/error_model.dart';
import 'package:rocket_finances/app/data/models/receipt_model.dart';

enum ReceiptsStatus {
  idle,
  loading,
  success,
  error;

  bool get isLoading => this == ReceiptsStatus.loading;
  bool get isSuccess => this == ReceiptsStatus.success;
  bool get isError => this == ReceiptsStatus.error;
}

class ReceiptsState {
  final List<ReceiptModel> receipts;
  final ReceiptsStatus status;
  final ErrorModel? error;

  ReceiptsState({
    this.status = ReceiptsStatus.idle,
    this.error,
    this.receipts = const [],
  });

  ReceiptsState copyWith({
    required ReceiptsStatus status,
    List<ReceiptModel>? receipts,
    ErrorModel? error,
  }) {
    return ReceiptsState(
      status: status,
      receipts: receipts ?? this.receipts,
      error: error ?? this.error,
    );
  }
}
