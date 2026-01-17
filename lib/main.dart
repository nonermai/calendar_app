//
// Copyright (c) 2025 Renon Sumii. All rights reserved.
//

import 'package:calender_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'app/app.dart';

Future<void> main() async {
  // Flutter のエンジンとフレームワークの「binding」を初期化
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // スプラッシュ画面の表示を維持
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // 画面の向きを縦固定に設定
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // 日付フォーマットの初期化
  await initializeDateFormatting();

  // Firebaseの初期化
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: MyApp()));
}
