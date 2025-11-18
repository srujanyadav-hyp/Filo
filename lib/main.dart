// FILO App Entry Point
// Refs: architecture_diagram_ultra.md line 8, coding_standards_ultra_ultra.md lines 32-38

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/providers/provider_observer.dart';
import 'presentation/theme/app_theme.dart';
import 'presentation/screens/home_screen.dart';

void main() {
  runApp(
    ProviderScope(observers: [FiloProviderObserver()], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FILO',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const HomeScreen(),
    );
  }
}
