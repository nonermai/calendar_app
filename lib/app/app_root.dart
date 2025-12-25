import 'package:calender_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:calender_app/features/auth/presentation/pages/login_page.dart';
import 'package:calender_app/features/calendar/presentation/pages/calendar_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppRoot extends ConsumerWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);

    // 認証状態が確定したらスプラッシュを消す
    authState.whenData((_) {
      FlutterNativeSplash.remove();
    });

    return authState.when(
      loading: () {
        return const SizedBox.shrink();
      },
      error: (e, _) => const LoginPage(),
      data: (user) {
        if (user != null) {
          debugPrint('認証状態：ログイン済み');
          return const CalendarPage();
        } else {
          debugPrint('認証状態：未ログイン');
          return const LoginPage();
        }
      },
    );
  }
}
