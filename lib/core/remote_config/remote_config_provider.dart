//
// Copyright (c) 2026 Renon Sumii. All rights reserved.
//

import 'package:calender_app/core/remote_config/remote_config_service.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'remote_config_provider.g.dart';

@riverpod
RemoteConfigService remoteConfigService(Ref ref) {
  return RemoteConfigService(FirebaseRemoteConfig.instance);
}
