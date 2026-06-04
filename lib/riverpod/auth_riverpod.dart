import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moviehub/services/auth_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider=ChangeNotifierProvider<AuthStateProvider>((ref){
  return AuthStateProvider();
});

class AuthStateProvider extends ChangeNotifier {
  bool _isLoading = false;
  User? _user;
  final AuthServices _authServices = AuthServices();

  AuthStateProvider() {
    _authServices.user.listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }
  User? get user => _user;
  bool get isloading => _isLoading;
  bool get isAuthenticated => user != null;

  Future<bool> sighinWithEmainandPassword(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      User? user = await _authServices.sighinWithEmailandPassword(
        email,
        password,
      );

      _isLoading = false;
      notifyListeners();
      return user != null;
    } catch (e) {
      _isLoading = false;
           debugPrint("$e");
                    

      notifyListeners();
      return false;
    }
  }

  Future<bool> registerWithEmailandPassword(
    String email,
    String password,
  ) async {
    _isLoading = true;
    notifyListeners();
    try {
      User? user = await _authServices.registerWithEmailandPassword(
        email,
        password,
      );

      _isLoading = false;
      notifyListeners();
      return user != null;
    } catch (e) {
      debugPrint('hi');
    }
    return false;
  }

 

  Future<void>signOut() async {
    await _authServices.sighOut();
    _user=null;
    notifyListeners();
  }
}