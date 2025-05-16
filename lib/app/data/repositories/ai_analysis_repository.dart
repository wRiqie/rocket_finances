import 'package:rocket_finances/app/data/data_sources/ai_analysis_data_source.dart';
import 'package:rocket_finances/app/data/models/analysis_model.dart';
import 'package:rocket_finances/app/data/models/commands/ai_analysis_command.dart';
import 'package:rocket_finances/app/data/models/default_response_model.dart';
import 'package:rocket_finances/app/data/services/execute_service.dart';

abstract class AiAnalysisRepository {
  Future<DefaultResponseModel<AnalysisModel>> requestAnalysis(
      AiAnalysisCommand command);

  Future<DefaultResponseModel<AnalysisModel>> getAnalysisByUserId(String id);
}

class AiAnalysisRepositoryImp implements AiAnalysisRepository {
  final AiAnalysisDataSource _aiAnalysisDataSource;

  AiAnalysisRepositoryImp(this._aiAnalysisDataSource);

  @override
  Future<DefaultResponseModel<AnalysisModel>> getAnalysisByUserId(String id) {
    return ExecuteService.tryExecuteAsync(
        () => _aiAnalysisDataSource.getAnalysisByUserId(id));
  }

  @override
  Future<DefaultResponseModel<AnalysisModel>> requestAnalysis(
      AiAnalysisCommand command) {
    {
      return ExecuteService.tryExecuteAsync(
          () => _aiAnalysisDataSource.requestAnalysis(command));
    }
  }
}
