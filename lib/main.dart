import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/app_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://vkjwojowbvdxsexculqm.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZrandvam93YnZkeHNleGN1bHFtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDYxMjI3ODUsImV4cCI6MjA2MTY5ODc4NX0.iHw-Io9AK8-TvrnXNXFVMYtlxAXeuKNRdnTgIUcwBFI',
  );

  runApp(const AppWidget());
}
