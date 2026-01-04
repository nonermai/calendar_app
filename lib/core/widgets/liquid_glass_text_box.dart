//
// Copyright (c) 2025 sumiirenon. All rights reserved.
//

import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

///
/// リキッドグラス風テキストボックスのクラス
///
class LiquidGlassTextBox extends StatelessWidget {
  const LiquidGlassTextBox({
    super.key,
    required this.text,
    required this.textStyle,
    this.height = 50.0,
    this.width = 120.0,
    this.onChanged,
  });

  final String text;
  final TextStyle? textStyle;
  final double height;
  final double width;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return LiquidGlassLayer(
      settings: const LiquidGlassSettings(
        thickness: 10,
        blur: 2,
      ),
      child: LiquidGlass(
        shape: LiquidRoundedSuperellipse(borderRadius: 30),
        child: GlassGlow(
          glowColor: Colors.white24,
          glowRadius: 2.0,
          child: SizedBox(
            height: height,
            width: width,
            child: Center(
              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: text,
                  hintStyle: textStyle,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 14.0,
                  ),
                ),
                style: textStyle,
                onChanged: (value) {
                  if (onChanged != null) {
                    onChanged!(value);
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
