//
// Copyright (c) 2025 Renon Sumii. All rights reserved.
//

class AuthValidator {
  static String? validateEmail(String email) {
    if (email.isEmpty) {
      return 'メールアドレスを入力してください';
    }

    final regex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );

    if (!regex.hasMatch(email)) {
      return 'メールアドレスの形式が正しくありません';
    }

    return null;
  }

  static String? validatePassword(String password) {
    if (password.isEmpty) {
      return 'パスワードを入力してください';
    }

    if (password.length < 8) {
      return 'パスワードは8文字以上にしてください';
    }

    final hasLetter = RegExp(r'[a-zA-Z]').hasMatch(password);
    final hasNumber = RegExp(r'\d').hasMatch(password);

    if (!hasLetter || !hasNumber) {
      return '英字と数字を両方含めてください';
    }

    return null;
  }
}
