//
// Copyright (c) 2025 Renon Sumii. All rights reserved.
//

import 'package:calender_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

///
/// リキッドグラス風ボタンのクラス
///
class LiquidGlassButton extends StatelessWidget {
  const LiquidGlassButton({
    super.key,
    required this.child,
    this.height = 50.0,
    this.width = 120.0,
    this.borderRadius = 30.0,
    this.color = AppColor.grow,
    this.glassColor = AppColor.glassColor,
    this.onTap,
  });

  final Widget child;
  final double height;
  final double width;
  final double borderRadius;
  final Color glassColor;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return LiquidGlassLayer(
      settings: LiquidGlassSettings(
        glassColor: glassColor,
        thickness: 10,
        blur: 2,
        lightIntensity: 1.5,
        lightAngle: 45,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: LiquidGlass(
          shape: LiquidRoundedSuperellipse(borderRadius: borderRadius),
          child: GlassGlow(
            glowColor: color,
            glowRadius: 3.0,
            child: SizedBox(
              height: height,
              width: width,
              child: Center(
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
