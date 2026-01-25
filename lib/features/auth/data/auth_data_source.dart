//
// Copyright (c) 2025-2026 Renon Sumii. All rights reserved.
//

import 'package:calender_app/core/logger/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthDataSource {
  final FirebaseAuth _auth;

  AuthDataSource(this._auth);

  User? get currentUser {
    Logger.d('--> Get currentUser');
    Logger.d('<-- Got currentUser: ${_auth.currentUser?.uid}');
    return _auth.currentUser;
  }

  Future<User> signIn(String email, String password) async {
    Logger.d('--> Sign in');
    final result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    Logger.d('<-- Signed in user: ${result.user?.uid}');
    return result.user!;
  }

  Future<User> signInAnonymously() async {
    Logger.d('--> Sign in anonymously');
    final result = await _auth.signInAnonymously();
    Logger.d('<-- Anonymous user uid: ${result.user?.uid}');
    return result.user!;
  }

  Future<User> signUp(String email, String password) async {
    Logger.d('--> Sign up');
    final result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    Logger.d('<-- Signed up user: ${result.user?.uid}');
    return result.user!;
  }

  Future<void> signOut() async {
    Logger.d('--> Sign out');
    await _auth.signOut();
    Logger.d('<-- Signed out');
  }

  Future<void> deleteAccount() async {
    Logger.d('--> Delete account');
    final user = _auth.currentUser;
    if (user == null) return;

    try {
      await user.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        throw Exception('再ログインが必要です');
      }
      rethrow;
    }
    Logger.d('<-- Deleted account');
  }
}
