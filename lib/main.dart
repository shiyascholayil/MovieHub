import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:moviehub/riverpod/auth_riverpod.dart';
import 'package:moviehub/screens/home_screen.dart';
import 'package:moviehub/screens/login_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(
    child:MyApp() ,) );
}

class MyApp extends ConsumerWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final authStateProvider=ref.watch(authProvider);
    return  MaterialApp(
        debugShowCheckedModeBanner: false,   
        home: authStateProvider.isAuthenticated
          ? HomeScreen()
          : LoginScreen()
    );
        
          
          
        
      
    
  }
}