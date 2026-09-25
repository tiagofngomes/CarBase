import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../features/shell/presentation/app_shell.dart';
import 'theme/app_theme.dart';

class CarBaseApp extends StatelessWidget {
  const CarBaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CarBase',
      debugShowCheckedModeBanner: false,
      locale: const Locale('pt', 'PT'),
      supportedLocales: const [Locale('pt', 'PT')],
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      theme: AppTheme.light,
      home: const AppShell(),
    );
  }
}
