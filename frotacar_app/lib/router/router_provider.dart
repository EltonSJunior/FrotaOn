// lib/router/router_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/providers.dart';
import '../pages/login_page.dart';
import '../pages/home_page.dart';

/// Notifier que avisa o GoRouter para rebuildar
class GoRouterRefreshNotifier extends ChangeNotifier {
  void refresh() {
    notifyListeners();
  }
}

/// Provider que conecta o auth ao GoRouter
final routerRefreshProvider = Provider<GoRouterRefreshNotifier>((ref) {
  final notifier = GoRouterRefreshNotifier();

  // Quando auth mudar → GoRouter rebuilda
  ref.listen<AuthState>(authStateProvider, (previous, next) {
    notifier.refresh();
  });

  ref.onDispose(() {
    notifier.dispose();
  });

  return notifier;
});

final routerProvider = Provider<GoRouter>((ref) {
  final refreshListenable = ref.watch(routerRefreshProvider);
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/login',
    refreshListenable: refreshListenable,
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      GoRoute(path: '/', builder: (context, state) => const HomePage()),
    ],
    redirect: (context, state) {
      final loggingIn = state.matchedLocation == '/login';
      final isLoggedIn = authState is AuthStateAuthenticated;

      if (!isLoggedIn) {
        return loggingIn ? null : '/login';
      }
      if (loggingIn) return '/';
      return null;
    },
  );
});
