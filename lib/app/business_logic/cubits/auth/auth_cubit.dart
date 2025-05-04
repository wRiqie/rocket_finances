import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rocket_finances/app/business_logic/cubits/auth/auth_state.dart';
import 'package:rocket_finances/app/data/models/commands/sign_up_command.dart';
import 'package:rocket_finances/app/data/repositories/auth_repository.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(AuthIdleState());

  void signIn(String email, String password) async {
    emit(AuthLoadingState());

    final response = await _authRepository.signIn(email, password);
    if (response.isSuccess && response.data != null) {
      emit(AuthSuccessState(response.data!));
    } else {
      emit(AuthErrorState(error: response.error));
    }
  }

  void signUp(SignUpCommand command) async {
    emit(AuthLoadingState());

    final response = await _authRepository.signUp(command);
    if (response.isSuccess && response.data != null) {
      emit(AuthSuccessState(response.data!));
    } else {
      emit(AuthErrorState(error: response.error));
    }
  }
}
