import 'package:flutter/material.dart';
import 'package:rocket_finances/routes/app_pages.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final containerColor = colorScheme.surfaceBright.withValues(alpha: .15);

    return Scaffold(
      bottomNavigationBar: InkWell(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.signUp);
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 10 + MediaQuery.of(context).viewPadding.bottom,
          ),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Ainda não tem uma conta? ',
              children: [
                TextSpan(
                  text: 'cadastre-se agora!',
                  style: TextStyle(color: colorScheme.primary),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 20, 18, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 40,
                ),
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
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
                        padding: const EdgeInsets.symmetric(horizontal: 30),
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
                    Text('Email'),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'Digite seu email',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Senha'),
                        Text(
                          'Esqueceu a senha?',
                          style: TextStyle(color: colorScheme.primary),
                        ),
                      ],
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.send,
                      decoration: InputDecoration(
                        hintText: 'Digite sua senha',
                        prefixIcon: Icon(Icons.lock_outline),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 26,
                ),
                SizedBox(
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Entrar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GlowLogoWidget extends StatelessWidget {
  const GlowLogoWidget({
    super.key,
    required this.colorScheme,
  });

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colorScheme.primaryContainer.withValues(alpha: .2),
          ),
        ),
        Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colorScheme.primaryContainer,
          ),
        ),
        Icon(Icons.monetization_on_outlined),
      ],
    );
  }
}
