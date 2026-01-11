//
// Copyright (c) 2025 Renon Sumii. All rights reserved.
//

import 'package:calender_app/features/settings/presentation/widgets/settings_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('設定画面'),
        backgroundColor: Color(0xFFF6F6F6),
      ),
      backgroundColor: Color(0xFFF6F6F6),
      body: SettingsBody(),
    );
  }
}
