import 'package:rocket_finances/app/data/models/analysis_model.dart';
import 'package:rocket_finances/app/data/models/error_model.dart';

enum AnalysisStatus {
  idle,
  loading,
  success,
  error;

  bool get isLoading => this == loading;
  bool get isSuccess => this == success;
  bool get isError => this == error;
}

class AnalysisState {
  final AnalysisStatus status;
  final ErrorModel? error;
  final AnalysisModel? analysis;

  const AnalysisState({
    this.status = AnalysisStatus.idle,
    this.error,
    this.analysis,
  });

  AnalysisState copyWith({
    AnalysisStatus? status,
    ErrorModel? error,
    AnalysisModel? analysis,
  }) {
    return AnalysisState(
      status: status ?? this.status,
      error: error ?? this.error,
      analysis: analysis ?? this.analysis,
    );
  }
}
