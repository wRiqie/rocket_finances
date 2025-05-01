import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rocket_finances/app/routes/app_pages.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            spacing: 10,
            mainAxisSize: MainAxisSize.min,
            children: [
              CupertinoButton.filled(
                child: Text('Entrar'),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.home);
                },
              ),
              CupertinoButton.tinted(
                child: Text('Mais infos'),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
