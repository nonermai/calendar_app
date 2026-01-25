//
// Copyright (c) 2026 Renon Sumii. All rights reserved.
//

import 'package:calender_app/core/analytics/button_name.dart';
import 'package:calender_app/core/analytics/screen_name.dart';
import 'package:calender_app/core/logger/logger.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsHelper {
  final FirebaseAnalytics _analytics;

  AnalyticsHelper(this._analytics);

  // 画面表示のログを送信する
  Future<void> logScreenView(ScreenName screen) async {
    Logger.d('send Firebase Analytics screen view: ${screen.name}');
    _analytics.logScreenView(screenName: screen.name);
  }

  // ボタンタップのログを送信する
  Future<void> logButtonTap(ButtonName button) async {
    Logger.d('send Firebase Analytics button tap: ${button.name}');
    _analytics.logEvent(
      name: 'button_tap',
      parameters: {'button_name': button.name},
    );
  }
}
