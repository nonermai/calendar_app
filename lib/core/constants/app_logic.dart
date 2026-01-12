//
// Copyright (c) 2025-2026 Renon Sumii. All rights reserved.
//

class AppLogic {
  // 現在月のindex
  static const int currentMonthIndex = 120;
  // 現在表示中の月のindex
  static int dispMonthIndex = 0;
  // カレンダー画面で表示するindexの量(過去10年+今月+未来10年)
  static const int totalMonthCount = 241;
  // 月の最初の日付
  static const int monthFirstDate = 1;
  // カレンダーで描画する最初と最後の日付(実際は前後24ヶ月で制御している)
  static DateTime firstDisplayDate = DateTime.utc(2000, 1, 1);
  static DateTime lastDisplayDate = DateTime.utc(2100, 12, 31);
}
