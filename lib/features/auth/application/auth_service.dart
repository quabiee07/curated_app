import 'dart:async';

import 'package:curated_app/core/domain/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthState {
  unknown,
  // onboarding,
  unauthenticated,
  authenticated,
}

class AuthService extends ChangeNotifier {
  final SharedPreferences _prefs;
  AuthState _authState = AuthState.unknown;
  Timer? _authTimer;

  AuthService(this._prefs) {
    _checkAuthState();
  }

  AuthState get authState => _authState;

  void _checkAuthState() {
    // final hasSeenOnboarding = _prefs.getBool(onboardingKey) ?? false;

    // if (!hasSeenOnboarding) {
    //   _authState = AuthState.onboarding;
    //   notifyListeners();
    //   return;
    // }

    final token = _prefs.getString(tokenKey);
    final loggedInUser = _prefs.getString(user);

    if (token != null && loggedInUser != null) {
      accessToken = token;
      _authState = AuthState.authenticated;
    } else {
      _authState = AuthState.unauthenticated;
    }
    notifyListeners();
  }

  // Future<void> setOnboardingCompleted() async {
  //   await _prefs.setBool(onboardingKey, true);
  //   _checkAuthState();
  // }

  Future<void> login(String token, String userJson) async {
    await _prefs.setString(tokenKey, token);
    await _prefs.setString(user, userJson);
    // Add a small delay to allow success snackbar to show before router redirect
    await Future.delayed(const Duration(milliseconds: 2000));
    _checkAuthState();
  }

  Future<void> logout() async {
    await _prefs.remove(tokenKey);
    await _prefs.remove(user);
    accessToken = '';
    _checkAuthState();
  }

  @override
  void dispose() {
    _authTimer?.cancel();
    super.dispose();
  }
}
