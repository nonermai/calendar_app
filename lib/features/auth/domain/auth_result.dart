//
// Copyright (c) 2025 Renon Sumii. All rights reserved.
//

import 'auth_result_state.dart';
import 'auth_user.dart';

sealed class AuthResult {
  const AuthResult();
}

class AuthSuccess extends AuthResult {
  final AuthUser user;
  const AuthSuccess(this.user);
}

class AuthFailure extends AuthResult {
  final AuthResultState state;
  const AuthFailure(this.state);
}
