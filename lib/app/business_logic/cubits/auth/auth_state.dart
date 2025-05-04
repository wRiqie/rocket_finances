import 'package:rocket_finances/app/data/models/error_model.dart';
import 'package:rocket_finances/app/data/models/user_model.dart';

abstract class AuthState {}

class AuthIdleState implements AuthState {}

class AuthLoadingState implements AuthState {}

class AuthSuccessState implements AuthState {
  final UserModel user;

  AuthSuccessState(this.user);
}

class AuthErrorState implements AuthState {
  final ErrorModel? error;

  AuthErrorState({this.error});
}
