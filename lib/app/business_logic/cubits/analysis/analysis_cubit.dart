import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rocket_finances/app/business_logic/cubits/analysis/analysis_state.dart';
import 'package:rocket_finances/app/data/models/commands/ai_analysis_command.dart';
import 'package:rocket_finances/app/data/repositories/ai_analysis_repository.dart';

class AnalysisCubit extends Cubit<AnalysisState> {
  final AiAnalysisRepository _aiAnalysisRepository;
  AnalysisCubit(this._aiAnalysisRepository) : super(const AnalysisState());

  void requestAnalysis(AiAnalysisCommand command) async {
    emit(state.copyWith(status: AnalysisStatus.loading));

    final response = await _aiAnalysisRepository.requestAnalysis(command);
    emit(state.copyWith(
      status: AnalysisStatus.success,
      analysis: response.data,
    ));
    emit(state.copyWith(
      status: AnalysisStatus.error,
      error: response.error,
    ));
  }

  void getAnalysisById(String id) async {
    emit(state.copyWith(status: AnalysisStatus.loading));

    final response = await _aiAnalysisRepository.getAnalysisByUserId(id);
    emit(state.copyWith(
      status: AnalysisStatus.success,
      analysis: response.data,
    ));
    emit(state.copyWith(
      status: AnalysisStatus.error,
      error: response.error,
    ));
  }
}
