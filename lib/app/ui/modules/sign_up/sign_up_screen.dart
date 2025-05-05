import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rocket_finances/app/business_logic/cubits/auth/auth_cubit.dart';
import 'package:rocket_finances/app/business_logic/cubits/auth/auth_state.dart';
import 'package:rocket_finances/app/core/helpers/session_helper.dart';
import 'package:rocket_finances/app/core/mixins/validators_mixin.dart';
import 'package:rocket_finances/app/core/values/snackbars.dart';
import 'package:rocket_finances/app/data/models/commands/sign_up_command.dart';
import 'package:rocket_finances/app/ui/shared/widgets/glow_logo_widget.dart';
import 'package:rocket_finances/routes/app_pages.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with ValidatorsMixin {
  final sessionHelper = GetIt.I<SessionHelper>();

  final formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  final isObscure = ValueNotifier(true);

  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final containerColor = colorScheme.surfaceBright.withValues(alpha: .15);

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          sessionHelper.setCurrentUser(state.user);
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.dashboard, (route) => false);
        } else if (state is AuthErrorState) {
          ErrorSnackbar(context, message: state.error?.message);
        }
      },
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(18, 20, 18, 0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GlowLogoWidget(colorScheme: colorScheme),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Rocket Finances',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Hora de tomar conta de suas finanças',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: colorScheme.onSurface.withValues(alpha: .6),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            color: containerColor,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: colorScheme.surfaceContainer,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 12,
                            children: [
                              Icon(
                                Icons.g_mobiledata,
                                size: 28,
                              ),
                              Text(
                                'Entre com o google',
                                style: TextStyle(fontSize: 16),
                              ),
                              Opacity(
                                opacity: 0,
                                child: Icon(
                                  Icons.g_mobiledata,
                                  size: 28,
                                  color: colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            children: [
                              Expanded(child: Divider()),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Text('Ou'),
                              ),
                              Expanded(child: Divider()),
                            ],
                          ),
                        ),
                        Column(
                          spacing: 8,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Nome'),
                            TextFormField(
                              controller: nameCtrl,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                hintText: 'Digite seu nome',
                                prefixIcon: Icon(Icons.person),
                              ),
                              validator: isNotEmpty,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Column(
                          spacing: 8,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Email'),
                            TextFormField(
                              controller: emailCtrl,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                hintText: 'Digite seu email',
                                prefixIcon: Icon(Icons.email_outlined),
                              ),
                              validator: (value) => combine([
                                () => isNotEmpty(value),
                                () => isValidEmail(value),
                              ]),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Column(
                          spacing: 8,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Senha'),
                            ValueListenableBuilder(
                                valueListenable: isObscure,
                                builder: (context, value, child) {
                                  return TextFormField(
                                    controller: passwordCtrl,
                                    textInputAction: TextInputAction.send,
                                    decoration: InputDecoration(
                                      hintText: 'Digite sua senha',
                                      prefixIcon: Icon(Icons.lock_outline),
                                      suffixIcon: IconButton(
                                        onPressed: _togglePasswordObscure,
                                        icon: Icon(
                                          value
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined,
                                        ),
                                      ),
                                    ),
                                    obscureText: value,
                                    validator: (value) => combine([
                                      () => isNotEmpty(value),
                                      () => isValidPassword(value),
                                    ]),
                                  );
                                }),
                          ],
                        ),
                        SizedBox(
                          height: 26,
                        ),
                        SizedBox(
                          height: 45,
                          child: ElevatedButton(
                            onPressed: _signUp,
                            child: Text('Cadastrar'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return Visibility(
                visible: state is AuthLoadingState,
                child: Container(
                  color: Colors.black26,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  void _signUp() {
    if (!(formKey.currentState?.validate() ?? false)) return;

    final command = SignUpCommand(
        email: emailCtrl.text,
        password: passwordCtrl.text,
        name: nameCtrl.text);

    final authCubit = BlocProvider.of<AuthCubit>(context);
    authCubit.signUp(command);
  }

  void _togglePasswordObscure() {
    setState(() {
      isObscure.value = !isObscure.value;
    });
  }
}
