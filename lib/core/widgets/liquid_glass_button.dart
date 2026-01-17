//
// Copyright (c) 2025-2026 Renon Sumii. All rights reserved.
//

import 'package:calender_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    this.glassColor = AppColor.glassColor,
    this.thickness = 10.0,
    this.blur = 2.0,
    this.lightIntensity = 0.5,
    this.lightAngle = 0.25,
    this.color = AppColor.grow,
    this.glowRadius = 0.0,
    this.onTap,
  });

  final Widget child;
  final double height;
  final double width;
  final double borderRadius;
  final Color glassColor;
  final double thickness;
  final double blur;
  final double lightIntensity;
  final double lightAngle;
  final Color color;
  final double glowRadius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return LiquidGlassLayer(
      settings: LiquidGlassSettings(
        glassColor: glassColor,
        thickness: thickness,
        blur: blur,
        lightIntensity: lightIntensity,
        lightAngle: lightAngle,
      ),
      child: GestureDetector(
        onTap: () {
          if (onTap != null) {
            onTap!();
          }
          HapticFeedback.mediumImpact();
        },
        child: LiquidGlass(
          shape: LiquidRoundedSuperellipse(borderRadius: borderRadius),
          child: GlassGlow(
            glowColor: color,
            glowRadius: glowRadius,
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
