import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthDataSource {
  final FirebaseAuth _auth;

  AuthDataSource(this._auth);

  User? get currentUser {
    debugPrint('--> Get currentUser');
    debugPrint('<-- Got currentUser: ${_auth.currentUser?.uid}');
    return _auth.currentUser;
  }

  Future<User> signIn(String email, String password) async {
    debugPrint('--> Sign in');
    final result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    debugPrint('<-- Signed in user: ${result.user?.uid}');
    return result.user!;
  }

  Future<User> signInAnonymously() async {
    debugPrint('--> Sign in anonymously');
    final result = await _auth.signInAnonymously();
    debugPrint('<-- Anonymous user uid: ${result.user?.uid}');
    return result.user!;
  }

  Future<User> signUp(String email, String password) async {
    debugPrint('--> Sign up');
    final result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    debugPrint('<-- Signed up user: ${result.user?.uid}');
    return result.user!;
  }

  Future<void> signOut() async {
    debugPrint('--> Sign out');
    await _auth.signOut();
    debugPrint('<-- Signed out');
  }
}
