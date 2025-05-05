import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rocket_finances/app/business_logic/cubits/auth/auth_cubit.dart';
import 'package:rocket_finances/app/ui/modules/sign_in/sign_in_screen.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(GetIt.I()),
      child: SignInScreen(),
    );
  }
}
