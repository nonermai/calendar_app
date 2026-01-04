//
// Copyright (c) 2025 sumiirenon. All rights reserved.
//

import 'package:calender_app/features/auth/data/auth_data_source.dart';
import 'package:calender_app/features/auth/domain/auth_result_state.dart';
import 'package:calender_app/features/auth/domain/auth_repository.dart';
import 'package:calender_app/features/auth/domain/auth_result.dart';
import 'package:calender_app/features/auth/domain/auth_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _dataSource;

  AuthRepositoryImpl(this._dataSource);

  @override
  Future<AuthUser?> getCurrentUser() async {
    final currentUser = _dataSource.currentUser;
    if (currentUser == null) return null;

    return AuthUser(uid: currentUser.uid);
  }

  @override
  Future<AuthResult> signIn(String email, String password) async {
    try {
      final firebaseUser = await _dataSource.signIn(email, password);
      final authUser = AuthUser(
        uid: firebaseUser.uid,
      );
      return AuthSuccess(authUser);
    } on FirebaseAuthException catch (e) {
      debugPrint('signIn error: ${e.code}');
      return AuthFailure(_mapError(e));
    }
  }

  @override
  Future<AuthResult> signInAnonymously() async {
    try {
      final firebaseUser = await _dataSource.signInAnonymously();
      return AuthSuccess(
        AuthUser(
          uid: firebaseUser.uid,
        ),
      );
    } on FirebaseAuthException catch (e) {
      debugPrint('anonymous signIn error: ${e.code}');
      return AuthFailure(AuthResultState.unknown);
    }
  }

  @override
  Future<AuthResult> signUp(String email, String password) async {
    try {
      final firebaseUser = await _dataSource.signUp(email, password);
      final authUser = AuthUser(
        uid: firebaseUser.uid,
      );
      return AuthSuccess(authUser);
    } on FirebaseAuthException catch (e) {
      debugPrint('signUp error: ${e.code}');
      return AuthFailure(_mapError(e));
    }
  }

  @override
  Future<void> signOut() {
    return _dataSource.signOut();
  }

  AuthResultState _mapError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return AuthResultState.invalidEmail;
      case 'user-disabled':
        return AuthResultState.userDisabled;
      case 'weak-password':
        return AuthResultState.weakPassword;
      case 'email-already-in-use':
        return AuthResultState.emailAlreadyInUse;
      default:
        return AuthResultState.unknown;
    }
  }
}
