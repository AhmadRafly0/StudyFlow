import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/notes/providers/note_provider.dart';
import 'features/schedule/providers/schedule_provider.dart';
import 'features/tasks/providers/task_provider.dart';
import 'features/timer/providers/session_provider.dart';
import 'services/auth_service.dart';

class StudyFlowApp extends StatelessWidget {
  const StudyFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => ScheduleProvider()),
        ChangeNotifierProvider(create: (_) => NoteProvider()),
        ChangeNotifierProvider(create: (_) => SessionProvider()),
        Provider<AuthService>(
          create: (ctx) => AuthService(
            onSignOut: [
              ctx.read<TaskProvider>().clear,
              ctx.read<ScheduleProvider>().clear,
              ctx.read<NoteProvider>().clear,
              ctx.read<SessionProvider>().clear,
            ],
          ),
        ),
      ],
      child: MaterialApp(
        title: 'StudyFlow',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ),
        home: const Scaffold(body: Center(child: Text('StudyFlow'))),
      ),
    );
  }
}
