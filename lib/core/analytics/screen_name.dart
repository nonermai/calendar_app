//
// Copyright (c) 2026 Renon Sumii. All rights reserved.
//

enum ScreenName {
  login, // ログイン画面
  calendar, // カレンダーページ
}

extension ScreenNameExt on ScreenName {
  String get value => name;
}
