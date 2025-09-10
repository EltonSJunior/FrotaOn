// lib/features/auth/providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class AuthState {}

class AuthStateUnauthenticated extends AuthState {}

class AuthStateAuthenticated extends AuthState {
  final String token;
  AuthStateAuthenticated(this.token);
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthStateUnauthenticated());

  Future<void> login(String user, String pass) async {
    // TODO: trocar por chamada real à API
    await Future.delayed(const Duration(seconds: 1));
    state = AuthStateAuthenticated('fake-token-123');
  }

  void logout() {
    state = AuthStateUnauthenticated();
  }
}

final authStateProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) => AuthNotifier());
