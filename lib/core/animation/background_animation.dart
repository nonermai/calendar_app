//
// Copyright (c) 2026 Renon Sumii. All rights reserved.
//

import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  // 3つの光の位置
  final List<Offset> _positions = [
    const Offset(-0.2, 0.2),
    const Offset(0.8, 0.1),
    const Offset(0.3, 0.8),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      // 6秒かけてアニメーション(reverse分含めない)
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xFF91A1B4),
          ),
          child: Stack(
            children: [
              // 背景
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFB8C6DB),
                      Color(0xFF95A5C3),
                    ],
                  ),
                ),
              ),
              // 右上
              _buildBlurCircle(
                size: size,
                color: const Color(0xC8FFFFFF),
                baseOffset: _positions[0],
                radius: size.width * 1.2,
                phase: 0.0,
              ),
              // 左上
              _buildBlurCircle(
                size: size,
                color: const Color(0xC8FFFFFF),
                baseOffset: _positions[1],
                radius: size.width * 1.0,
                phase: 2.1,
              ),
              // 下部
              _buildBlurCircle(
                size: size,
                color: const Color(0xC8FFFFFF),
                baseOffset: _positions[2],
                radius: size.width * 1.5,
                phase: 4.5,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBlurCircle({
    required Size size,
    required Color color,
    required Offset baseOffset,
    required double radius,
    required double phase,
  }) {
    final double t = _controller.value * 2 * pi;
    final double dx = sin(t + phase) * 0.1;
    final double dy = cos(t * 0.7 + phase) * 0.1;

    return Positioned(
      left: (baseOffset.dx + dx) * size.width - (radius / 2),
      top: (baseOffset.dy + dy) * size.height - (radius / 2),
      child: Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [color, color.withValues(alpha: 0.0)],
          ),
        ),
      ),
    );
  }
}
