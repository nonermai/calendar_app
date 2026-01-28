//
// Copyright (c) 2026 Renon Sumii. All rights reserved.
//

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:calender_app/core/logger/logger.dart';

class RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig;

  RemoteConfigService(this._remoteConfig);

  Future<void> init() async {
    try {
      await _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 5),
          minimumFetchInterval: const Duration(seconds: 5),
        ),
      );

      await _remoteConfig.fetchAndActivate();
      // 取得した値を全てログに出力
      _remoteConfig.getAll().forEach((key, value) {
        Logger.d('Remote Config 取得値 $key: ${value.asString()}');
      });
    } catch (e) {
      Logger.d('Remote Config 取得失敗：${e.toString()}');
    }
  }

  String get forceUpdateVersion =>
      _remoteConfig.getString('force_update_version');
}
