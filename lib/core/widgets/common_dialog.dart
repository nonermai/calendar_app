//
// Copyright (c) 2025 Renon Sumii. All rights reserved.
//

import 'package:calender_app/core/constants/app_layout.dart';
import 'package:calender_app/core/theme/app_theme.dart';
import 'package:calender_app/core/widgets/liquid_glass_button.dart';
import 'package:flutter/material.dart';

///
/// 共通ダイアログクラス
///
class CommonDialog extends StatelessWidget {
  const CommonDialog({
    required this.title,
    required this.primaryButtonText,
    required this.secondButtonText,
    this.primaryAction,
    this.secondAction,
    super.key,
  });

  final String title;

  final String primaryButtonText;
  final String secondButtonText;

  final VoidCallback? primaryAction;
  final VoidCallback? secondAction;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColor.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppLayout.deleteEventDialogBorderRadius,
        ),
      ),
      title: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            color: AppColor.secondaryColor,
          ),
        ),
      ),
      actions: [
        Row(
          children: [
            LiquidGlassButton(
              onTap: secondAction,
              child: Text(
                secondButtonText,
              ),
            ),
            SizedBox(
              width: 7,
            ),
            LiquidGlassButton(
              onTap: primaryAction,
              child: Text(
                primaryButtonText,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
