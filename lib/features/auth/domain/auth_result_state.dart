enum AuthResultState {
  invalidEmail,
  userDisabled,
  weakPassword,
  emailAlreadyInUse,
  unknown,
}

extension AuthResultMessage on AuthResultState {
  String get message {
    switch (this) {
      case AuthResultState.invalidEmail:
        return 'メールアドレスの形式が正しくありません';
      case AuthResultState.userDisabled:
        return '指定したメールアドレスは使用できません';
      case AuthResultState.weakPassword:
        return 'パスワードは6文字以上にしてください';
      case AuthResultState.emailAlreadyInUse:
        return 'このメールアドレスは既に使われています';
      case AuthResultState.unknown:
        return '登録に失敗しました';
    }
  }
}
