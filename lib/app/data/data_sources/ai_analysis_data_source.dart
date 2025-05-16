import 'dart:io';

import 'package:rocket_finances/app/core/values/functions.dart';
import 'package:rocket_finances/app/data/models/analysis_model.dart';
import 'package:rocket_finances/app/data/models/commands/ai_analysis_command.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AiAnalysisDataSource {
  Future<AnalysisModel> requestAnalysis(AiAnalysisCommand command);

  Future<AnalysisModel?> getAnalysisByUserId(String id);
}

class AiAnalysisDataSourceSupaImp implements AiAnalysisDataSource {
  final SupabaseClient _client;

  AiAnalysisDataSourceSupaImp(this._client);

  @override
  Future<AnalysisModel> requestAnalysis(AiAnalysisCommand command) async {
    final response = await _client.functions.invoke(
      Functions.requestAnalysis,
      method: HttpMethod.post,
      body: command.toMap(),
      headers: {
        HttpHeaders.authorizationHeader:
            _client.auth.currentSession?.accessToken ?? '',
      },
    );

    return AnalysisModel.fromMap(response.data);
  }

  @override
  Future<AnalysisModel?> getAnalysisByUserId(String id) async {
    final response = await _client
        .rpc(Functions.getMonthAnalysis, params: {'usr_id': id}).select();

    return response.isNotEmpty ? AnalysisModel.fromMap(response.first) : null;
  }
}
