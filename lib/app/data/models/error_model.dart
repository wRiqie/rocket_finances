import 'package:supabase_flutter/supabase_flutter.dart';

class ErrorModel implements Exception {
  final String message;

  ErrorModel(this.message);
}

ErrorModel? tryConvertErrorToSupabase(dynamic exception) {
  if (exception is AuthApiException) {
    return ErrorModel(exception.message);
  } else if (exception is PostgrestException) {
    return ErrorModel(exception.message);
  } else if (exception is StorageException) {
    return ErrorModel(exception.message);
  }
  return null;
}
