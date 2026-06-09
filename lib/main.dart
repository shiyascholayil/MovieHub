import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moviehub/models/movie.dart';
import 'package:moviehub/riverpod/auth_riverpod.dart';
import 'package:moviehub/screens/login_screen.dart';
import 'package:moviehub/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase
  await Firebase.initializeApp();

  // Hive
  await Hive.initFlutter();
  Hive.registerAdapter(MovieAdapter());
  await Hive.openBox<Movie>('favorites');

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStateProvider = ref.watch(authProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: authStateProvider.isAuthenticated
          ? const MainScreen()
          : const LoginScreen(),
    );
  }
}