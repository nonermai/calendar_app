//
// Copyright (c) 2026 Renon Sumii. All rights reserved.
//

enum ButtonName {
  login, // ログインボタン
  signUp, // 新規登録ボタン
  guestLogin, // ゲストログインボタン
  logout, // ログアウトボタン
  setting, // 設定ボタン
  accountDelete, // アカウント削除ボタン
  addEvent, // 予定追加ボタン
  deleteEvent, // 予定削除ボタン
  backToCurrentMonth, // 今月に戻るボタン
}

extension ButtonNameExt on ButtonName {
  String get value => name;
}
