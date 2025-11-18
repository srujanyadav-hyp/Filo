// FILO Provider Observer - Debug and logging for Riverpod state changes
// Refs: architecture_diagram_ultra.md line 8, coding_standards_ultra_ultra.md

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';

/// Observer for monitoring provider lifecycle and state changes
/// Useful for debugging and understanding state management flow
class FiloProviderObserver extends ProviderObserver {
  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    if (kDebugMode) {
      print(
        '[Provider Added] ${provider.name ?? provider.runtimeType}: $value',
      );
    }
  }

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    if (kDebugMode) {
      print(
        '[Provider Updated] ${provider.name ?? provider.runtimeType}: $previousValue → $newValue',
      );
    }
  }

  @override
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) {
    if (kDebugMode) {
      print('[Provider Disposed] ${provider.name ?? provider.runtimeType}');
    }
  }

  @override
  void providerDidFail(
    ProviderBase<Object?> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    if (kDebugMode) {
      print(
        '[Provider Error] ${provider.name ?? provider.runtimeType}: $error',
      );
      print(stackTrace);
    }
  }
}
