//
// Copyright (c) 2025 sumiirenon. All rights reserved.
//

import 'package:calender_app/features/auth/domain/auth_result.dart';
import 'package:calender_app/features/auth/domain/auth_user.dart';

abstract class AuthRepository {
  Future<AuthUser?> getCurrentUser();
  Future<AuthResult> signIn(String email, String password);
  Future<AuthResult> signInAnonymously();
  Future<AuthResult> signUp(String email, String password);
  Future<void> signOut();
}
