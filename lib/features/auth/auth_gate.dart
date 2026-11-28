import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/auth_service.dart';
import 'screens/home_placeholder_screen.dart';
import 'screens/login_screen.dart';

/// Memilih layar berdasarkan status login user.
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: context.read<AuthService>().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.data != null) {
          // TODO(Orang 7): ganti dengan MainNavigation.
          return const HomePlaceholderScreen();
        }
        return const LoginScreen();
      },
    );
  }
}
