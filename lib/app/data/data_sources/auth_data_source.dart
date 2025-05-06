import 'package:rocket_finances/app/core/values/functions.dart';
import 'package:rocket_finances/app/core/values/tables.dart';
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

    final user = response.user;
    if (user != null) {
      final response =
          await _client.rpc(Functions.getUserData, params: {'usr_id': user.id});

      if (response.isNotEmpty) {
        final dbUser = response.first;
        return UserModel.fromMap(dbUser..addAll({'email': user.email}));
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
      final idResponse = await _client
          .from(Tables.users)
          .insert(command.toMap()..addAll({'auth_id': user.id}))
          .select('id');

      return UserModel(
          id: idResponse.first['id'], name: command.name, email: command.email);
    }
    return null;
  }

  @override
  Future<UserModel?> getSession() async {
    final user = _client.auth.currentUser;

    if (user != null) {
      final response =
          await _client.rpc(Functions.getUserData, params: {'usr_id': user.id});

      if (response.isNotEmpty) {
        final dbUser = response.first;
        return UserModel.fromMap(dbUser..addAll({'email': user.email}));
      }
    }
    return null;
  }

  @override
  Future<void> signOut() {
    return _client.auth.signOut();
  }
}
