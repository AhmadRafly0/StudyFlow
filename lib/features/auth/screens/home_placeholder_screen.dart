import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/auth_service.dart';

/// Halaman sementara setelah login.
// TODO(Orang 7): ganti dengan MainNavigation di AuthGate.
class HomePlaceholderScreen extends StatelessWidget {
  const HomePlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthService>();
    final user = auth.currentUser;
    final displayName = (user?.displayName?.isNotEmpty ?? false)
        ? user!.displayName!
        : (user?.email ?? '');

    return Scaffold(
      appBar: AppBar(title: const Text('StudyFlow')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Halo, $displayName',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () => auth.signOut(),
                icon: const Icon(Icons.logout),
                label: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
