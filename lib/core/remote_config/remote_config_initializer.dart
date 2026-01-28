//
// Copyright (c) 2026 Renon Sumii. All rights reserved.
//

import 'package:calender_app/core/remote_config/remote_config_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'remote_config_initializer.g.dart';

@riverpod
Future<void> remoteConfigInitializer(Ref ref) async {
  await ref.read(remoteConfigServiceProvider).init();
}
