//
// Copyright (c) 2026 Renon Sumii. All rights reserved.
//

import 'package:calender_app/core/analytics/analytics_helper.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'analytics_provider.g.dart';

@riverpod
AnalyticsHelper analyticsHelper(Ref ref) {
  return AnalyticsHelper(FirebaseAnalytics.instance);
}
