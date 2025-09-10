// lib/pages/login_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/providers.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _user = TextEditingController();
  final _pass = TextEditingController();
  bool _loading = false;

  Future<void> _submit() async {
    setState(() => _loading = true);
    await ref.read(authStateProvider.notifier).login(_user.text, _pass.text);
    setState(() => _loading = false);

    final state = ref.read(authStateProvider);
    if (state is AuthStateAuthenticated) {
      // redireciona para home substituindo rota atual
      context.go('/');
    } else {
      // tratar erro real aqui
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Falha no login')));
    }
  }

  @override
  void dispose() {
    _user.dispose();
    _pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  const Text('FrotaCar', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  TextField(controller: _user, decoration: const InputDecoration(labelText: 'Usuário')),
                  const SizedBox(height: 8),
                  TextField(controller: _pass, decoration: const InputDecoration(labelText: 'Senha'), obscureText: true),
                  const SizedBox(height: 16),
                  _loading
                      ? const CircularProgressIndicator()
                      : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(onPressed: _submit, child: const Text('Acessar')),
                        ),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
