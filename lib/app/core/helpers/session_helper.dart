import 'package:rocket_finances/app/data/repositories/auth_repository.dart';

import '../../data/models/user_model.dart';

class SessionHelper {
  final AuthRepository _authRepository;

  UserModel? _currentUser;

  SessionHelper(this._authRepository);

  Future<bool> loadActualSession() async {
    final response = await _authRepository.getSession();

    if (response.isSuccess && response.data != null) {
      setCurrentUser(response.data!);
      return true;
    }

    return false;
  }

  UserModel? get currentUser {
    return _currentUser;
  }

  void setCurrentUser(UserModel user) {
    _currentUser = user;
  }

  bool get isSignedIn => _currentUser != null;

  Future<void> signOut() async {
    await _authRepository.signOut();
    _currentUser = null;
  }
}
