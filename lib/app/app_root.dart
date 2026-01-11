//
// Copyright (c) 2025-2026 Renon Sumii. All rights reserved.
//

import 'package:calender_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:calender_app/features/auth/presentation/pages/login_page.dart';
import 'package:calender_app/features/calendar/presentation/pages/calendar_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppRoot extends ConsumerWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);

    return authState.when(
      loading: () {
        return const SizedBox.shrink();
      },
      error: (e, _) => const LoginPage(),
      data: (user) {
        if (user != null) {
          return const CalendarPage();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
