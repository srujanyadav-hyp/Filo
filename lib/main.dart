// FILO App Entry Point
// Refs: architecture_diagram_ultra.md line 8, coding_standards_ultra_ultra.md lines 32-38

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/providers/provider_observer.dart';
import 'presentation/theme/app_theme.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/onboarding_screen.dart';
import 'data/repositories/onboarding_repository.dart';

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
      home: const InitialScreen(),
    );
  }
}

/// Initial screen that decides whether to show onboarding or home
class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  final OnboardingRepository _repository = OnboardingRepository();
  bool _isLoading = true;
  bool _showOnboarding = true;

  @override
  void initState() {
    super.initState();
    _checkOnboardingStatus();
  }

  Future<void> _checkOnboardingStatus() async {
    final isComplete = await _repository.isOnboardingComplete();
    setState(() {
      _showOnboarding = !isComplete;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return _showOnboarding ? const OnboardingScreen() : const HomeScreen();
  }
}
