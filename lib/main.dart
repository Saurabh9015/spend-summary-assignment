import 'package:flutter/material.dart';

import 'screens/spend_summary_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const SpendSummaryApp());
}

class SpendSummaryApp extends StatefulWidget {
  const SpendSummaryApp({super.key});

  @override
  State<SpendSummaryApp> createState() => _SpendSummaryAppState();
}

class _SpendSummaryAppState extends State<SpendSummaryApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme() {
    setState(() {
      _themeMode = switch (_themeMode) {
        ThemeMode.system => _platformIsDark ? ThemeMode.light : ThemeMode.dark,
        ThemeMode.light => ThemeMode.dark,
        ThemeMode.dark => ThemeMode.light,
      };
    });
  }

  bool get _platformIsDark {
    return WidgetsBinding.instance.platformDispatcher.platformBrightness ==
        Brightness.dark;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spend Summary',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: SpendSummaryScreen(
        themeMode: _themeMode,
        onToggleTheme: _toggleTheme,
      ),
    );
  }
}
