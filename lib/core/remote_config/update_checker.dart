//
// Copyright (c) 2026 Renon Sumii. All rights reserved.
//

import 'package:calender_app/core/logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';

class UpdateChecker {
  // キャッシュ用PackageInfo
  static PackageInfo? _cachedPackageInfo;

  // アプリのアップデートが必要かどうかを判定する
  static Future<bool> shouldUpdate({
    String? forceUpdateVersion,
  }) async {
    if (forceUpdateVersion == null || forceUpdateVersion.isEmpty) {
      return false;
    }

    // 現在のアプリのバージョンを取得
    _cachedPackageInfo ??= await PackageInfo.fromPlatform();
    final currentVersion = _cachedPackageInfo!.version;
    Logger.d(
      'Current Version: $currentVersion Force Update Version: $forceUpdateVersion',
    );
    return _isLowerVersion(currentVersion, forceUpdateVersion);
  }

  // currentVersionがforceUpdateVersionよりも低いかどうかを判定する
  static bool _isLowerVersion(
    String? currentVersion,
    String forceUpdateVersion,
  ) {
    if (currentVersion == null ||
        currentVersion.isEmpty ||
        forceUpdateVersion.isEmpty) {
      return false;
    }

    // バージョン文字列をドットで分割し、各要素を整数に変換
    // 例: "1.2.3" -> [1, 2, 3]
    // X.Y.Z の形式でなければfalseを返却
    try {
      final currentVersionElements = currentVersion
          .split('.')
          .map(int.parse)
          .toList();
      if (currentVersionElements.isEmpty ||
          currentVersionElements.length != 3) {
        return false;
      }
      final forceVersionElements = forceUpdateVersion
          .split('.')
          .map(int.parse)
          .toList();
      if (forceVersionElements.isEmpty || forceVersionElements.length != 3) {
        return false;
      }

      for (var i = 0; i < 3; i++) {
        if (currentVersionElements[i] < forceVersionElements[i]) {
          return true;
        } else if (currentVersionElements[i] > forceVersionElements[i]) {
          return false;
        }
      }
    } catch (e) {
      // 変換に失敗した場合はfalseを返却
      return false;
    }

    return false;
  }
}
