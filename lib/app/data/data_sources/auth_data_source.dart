import 'package:rocket_finances/app/data/models/commands/sign_up_command.dart';
import 'package:rocket_finances/app/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthDataSource {
  Future<UserModel?> signIn(String email, String password);

  Future<UserModel?> signUp(SignUpCommand command);

  Future<UserModel?> getSession();

  Future<void> signOut();
}

class AuthDataSourceSupaImp implements AuthDataSource {
  final SupabaseClient _client;

  AuthDataSourceSupaImp(this._client);

  @override
  Future<UserModel?> signIn(String email, String password) async {
    final response = await _client.auth.signInWithPassword(
      password: password,
      email: email,
    );

    if (response.user != null) {
      final userResponse = await _client
          .from('users')
          .select('id, auth_id, name, photo_url')
          .filter('auth_id', 'eq', response.user!.id);

      if (userResponse.isNotEmpty) {
        final dbUser = userResponse.first;
        final user = UserModel(
          name: dbUser['name'],
          email: email,
          photoUrl: dbUser['photo_url'],
        );

        return user;
      }
    }

    return null;
  }

  @override
  Future<UserModel?> signUp(SignUpCommand command) async {
    final response = await _client.auth
        .signUp(password: command.password, email: command.email);

    final user = response.user;

    if (user != null) {
      await _client
          .from('users')
          .insert(command.toMap()..addAll({'auth_id': user.id}));

      return UserModel(name: command.name, email: command.email);
    }
    return null;
  }

  @override
  Future<UserModel?> getSession() async {
    final user = _client.auth.currentUser;

    if (user != null) {
      final response = await _client
          .from('users')
          .select('id, auth_id, name, photo_url')
          .filter('auth_id', 'eq', user.id);

      if (response.isNotEmpty) {
        final dbUser = response.first;
        return UserModel(
          name: dbUser['name'],
          email: user.email ?? '',
          photoUrl: dbUser['photo_url'],
        );
      }
    }
    return null;
  }

  @override
  Future<void> signOut() {
    return _client.auth.signOut();
  }
}
