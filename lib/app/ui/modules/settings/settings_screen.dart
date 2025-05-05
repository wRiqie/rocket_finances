import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:get_it/get_it.dart';
import 'package:rocket_finances/app/core/helpers/session_helper.dart';
import 'package:rocket_finances/app/ui/shared/dialogs/decision_dialog.dart';
import 'package:rocket_finances/routes/app_pages.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final sessionHelper = GetIt.I<SessionHelper>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
      ),
      body: SettingsTheme(
        themeData: SettingsThemeData(),
        platform:
            Platform.isAndroid ? DevicePlatform.android : DevicePlatform.iOS,
        child: Column(
          children: [
            SettingsSection(
              title: Text('Básico'),
              tiles: [
                SettingsTile(
                  title: Text('Conta'),
                  leading: Icon(Icons.person_outline),
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile(
                  title: Text('Sair'),
                  leading: Icon(Icons.logout),
                  onPressed: (context) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return DecisionDialog(
                            title: 'Encerrar sessão',
                            content:
                                'Tem certeza que deseja encerrar sua sessão?',
                            onConfirm: _signOut);
                      },
                    );
                  },
                ),
              ],
            ),
            SettingsSection(
              title: Text('Segurança'),
              tiles: [
                SettingsTile(
                  title: Text('Senha'),
                  leading: Icon(Icons.lock_outline),
                  onPressed: (BuildContext context) {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _signOut() async {
    await sessionHelper.signOut();

    if (mounted) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(AppRoutes.signIn, (route) => false);
    }
  }
}
