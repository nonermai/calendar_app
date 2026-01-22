//
// Copyright (c) 2026 Renon Sumii. All rights reserved.
//

import 'package:calender_app/core/constants/pref_keys.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InAppReviewService {
  static const int reviewTriggerCount = 5;
  static Future<void> tryShowReview() async {
    final prefs = await SharedPreferences.getInstance();

    // 今月表示済みかどうか
    final now = DateTime.now();
    final String currentMonth = '${now.year}${now.month}';
    debugPrint('Current Month: $currentMonth');
    final lastShownMonth = prefs.getString(PrefKeys.lastReviewDialogShownMonth);
    debugPrint('lastShownMonth: $lastShownMonth');
    if (lastShownMonth == currentMonth) {
      return;
    }

    // 表示回数条件を満たしているか
    final openCount = (prefs.getInt(PrefKeys.calendarOpenCount) ?? 0) + 1;
    debugPrint('openCount: $openCount');
    await prefs.setInt(PrefKeys.calendarOpenCount, openCount);
    if (openCount < reviewTriggerCount) {
      return;
    }

    // レビュー表示処理
    final inAppReview = InAppReview.instance;
    if (await inAppReview.isAvailable()) {
      // レビューダイアログ表示
      await inAppReview.requestReview();
      // 表示月を保存
      await prefs.setString(PrefKeys.lastReviewDialogShownMonth, currentMonth);
      // カウントリセット
      await prefs.setInt(PrefKeys.calendarOpenCount, 0);
    }
  }
}
