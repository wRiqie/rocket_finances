import 'package:rocket_finances/app/data/data_sources/auth_data_source.dart';
import 'package:rocket_finances/app/data/models/default_response_model.dart';
import 'package:rocket_finances/app/data/models/user_model.dart';
import 'package:rocket_finances/app/data/services/execute_service.dart';

import '../models/commands/sign_up_command.dart';

abstract class AuthRepository {
  Future<DefaultResponseModel<UserModel>> signIn(String email, String password);

  Future<DefaultResponseModel<UserModel>> signUp(SignUpCommand command);

  Future<DefaultResponseModel<UserModel>> getSession();

  Future<DefaultResponseModel<void>> signOut();
}

class AuthRepositoryImp implements AuthRepository {
  final AuthDataSource _authDataSource;

  AuthRepositoryImp(this._authDataSource);

  @override
  Future<DefaultResponseModel<UserModel>> signIn(
      String email, String password) {
    return ExecuteService.tryExecuteAsync(
        () => _authDataSource.signIn(email, password));
  }

  @override
  Future<DefaultResponseModel<UserModel>> signUp(SignUpCommand command) {
    return ExecuteService.tryExecuteAsync(
        () => _authDataSource.signUp(command));
  }

  @override
  Future<DefaultResponseModel<UserModel>> getSession() {
    return ExecuteService.tryExecuteAsync(() => _authDataSource.getSession());
  }

  @override
  Future<DefaultResponseModel<void>> signOut() {
    return ExecuteService.tryExecuteAsync(() => _authDataSource.signOut());
  }
}
