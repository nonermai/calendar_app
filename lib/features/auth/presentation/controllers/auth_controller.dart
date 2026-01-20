//
// Copyright (c) 2025-2026 Renon Sumii. All rights reserved.
//

import 'package:calender_app/features/auth/data/auth_data_source.dart';
import 'package:calender_app/features/auth/data/auth_repository_impl.dart';
import 'package:calender_app/features/auth/domain/auth_result_state.dart';
import 'package:calender_app/features/auth/domain/auth_repository.dart';
import 'package:calender_app/features/auth/domain/auth_result.dart';
import 'package:calender_app/features/auth/domain/auth_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  late final AuthRepository _repo;

  @override
  Future<AuthUser?> build() async {
    _repo = AuthRepositoryImpl(
      AuthDataSource(FirebaseAuth.instance),
    );

    // 現在ログイン中のユーザーを取得
    return _repo.getCurrentUser();
  }

  Future<AuthResultState?> signIn(String email, String password) async {
    final result = await _repo.signIn(email, password);
    switch (result) {
      case AuthSuccess(:final user):
        // 成功時は認証状態をログイン済みにし、nullを返す
        state = AsyncData(user);
        return null;
      case AuthFailure(:final state):
        // 失敗時はエラー状態を返す
        return state;
    }
  }

  Future<AuthResultState?> signInAsGuest() async {
    final result = await _repo.signInAnonymously();
    switch (result) {
      case AuthSuccess(:final user):
        state = AsyncData(user);
        return null;
      case AuthFailure(:final state):
        return state;
    }
  }

  Future<AuthResultState?> signUp(String email, String password) async {
    final result = await _repo.signUp(email, password);
    switch (result) {
      case AuthSuccess(:final user):
        // 成功時は認証状態をログイン済みにし、nullを返す
        state = AsyncData(user);
        return null;
      case AuthFailure(:final state):
        // 失敗時はエラー状態を返す
        return state;
    }
  }

  Future<void> signOut() async {
    await _repo.signOut();
    state = const AsyncData(null);
  }

  Future<void> deleteAccount() async {
    try {
      await _repo.deleteAccount();
      state = const AsyncData(null);
    } catch (e) {
      rethrow;
    }
  }
}
