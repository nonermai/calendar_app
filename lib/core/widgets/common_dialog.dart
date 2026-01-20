//
// Copyright (c) 2025-2026 Renon Sumii. All rights reserved.
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
    this.thirdButtonText,
    this.primaryAction,
    this.secondAction,
    this.thirdAction,
    this.isVertical = false,
    super.key,
  });

  final String title;

  final String primaryButtonText;
  final String secondButtonText;
  final String? thirdButtonText;

  final VoidCallback? primaryAction;
  final VoidCallback? secondAction;
  final VoidCallback? thirdAction;

  final bool isVertical;

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
        if (isVertical)
          Center(
            child: Column(
              children: [
                LiquidGlassButton(
                  onTap: primaryAction,
                  child: Text(
                    primaryButtonText,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                LiquidGlassButton(
                  onTap: secondAction,
                  child: Text(
                    secondButtonText,
                  ),
                ),
                if (thirdButtonText != null) ...[
                  SizedBox(
                    height: 8,
                  ),
                  LiquidGlassButton(
                    onTap: thirdAction,
                    child: Text(
                      thirdButtonText!,
                    ),
                  ),
                ],
              ],
            ),
          )
        else
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
