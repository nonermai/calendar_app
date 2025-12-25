//
// Copyright (c) 2025 sumiirenon. All rights reserved.
//

import 'package:calender_app/app/app_root.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Color(0xFF000000),
      ),
      debugShowCheckedModeBanner: false,
      home: const AppRoot(),
    );
  }
}
