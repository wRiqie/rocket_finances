import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rocket_finances/app/business_logic/cubits/auth/auth_cubit.dart';
import 'package:rocket_finances/app/ui/modules/sign_up/sign_up_screen.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(GetIt.I()),
      child: SignUpScreen(),
    );
  }
}
