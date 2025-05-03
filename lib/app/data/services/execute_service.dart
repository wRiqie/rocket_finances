import 'package:rocket_finances/app/data/models/default_response_model.dart';
import 'package:rocket_finances/app/data/models/error_model.dart';

class ExecuteService {
  ExecuteService._();

  static Future<DefaultResponseModel<T>> tryExecuteAsync<T>(
      Future<T?> Function() execute) async {
    try {
      final response = await execute();
      return DefaultResponseModel<T>(data: response);
    } catch (e) {
      var defaultError = tryConvertErrorToSupabase(e);
      if (defaultError != null) {
        return DefaultResponseModel(error: defaultError);
      } else {
        return DefaultResponseModel(error: ErrorModel('Ocorreu um erro'));
      }
    }
  }
}
