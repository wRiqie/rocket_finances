import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
}
