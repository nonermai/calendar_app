//
// Copyright (c) 2025-2026 Renon Sumii. All rights reserved.
//

import 'package:calender_app/core/constants/app_duration.dart';
import 'package:calender_app/core/constants/app_layout.dart';
import 'package:calender_app/core/constants/app_logic.dart';
import 'package:calender_app/core/theme/app_theme.dart';
import 'package:calender_app/core/widgets/common_dialog.dart';
import 'package:calender_app/core/widgets/liquid_glass_button.dart';
import 'package:calender_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calender_app/features/calendar/presentation/widgets/calendar_body.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

///
/// カレンダー画面
///
class CalendarPage extends ConsumerStatefulWidget {
  const CalendarPage({super.key});

  @override
  ConsumerState<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends ConsumerState<CalendarPage> {
  // bodyのScrollablePositionedList用コントローラ
  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener =
      ItemPositionsListener.create();

  // 現在月のインデックス
  static const int _currentMonthIndex = AppLogic.currentMonthIndex;

  // 現在表示中の月のインデックス
  late int _dispMonthIndex;

  // ログイン後、現在月のカレンダーが表示されたかどうか
  bool isCurrentMonthDisplayed = false;

  @override
  void initState() {
    super.initState();

    // 初期表示は必ず現在月
    _dispMonthIndex = _currentMonthIndex;

    // build完了を確実に待つ
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // コントローラーがListにAttachされるまで待つ
      while (!_itemScrollController.isAttached) {
        await Future.delayed(AppDuration.controllerAttachCheckDelay);
      }

      // attach完了後にスクロール
      _itemScrollController.jumpTo(
        alignment: 0.1,
        index: _currentMonthIndex,
      );
      isCurrentMonthDisplayed = true;
      FlutterNativeSplash.remove();
    });

    // スクロール監視リスナー追加
    _itemPositionsListener.itemPositions.addListener(() {
      final positions = _itemPositionsListener.itemPositions.value;
      if (positions.isEmpty) return;

      // 表示中アイテムをindex昇順でソート
      final sorted = positions.toList()
        ..sort((a, b) => a.index.compareTo(b.index));

      final firstItem = sorted.first;
      int nextDispIndex = firstItem.index;

      // firstIndexのtrailingEdgeが0.5以下なら次のindexに切り替える
      if (firstItem.itemTrailingEdge <= 0.5) {
        nextDispIndex = firstItem.index + 1;
      }

      // stateが破棄されてない場合かつ
      // カレンダー画面表示直後のjump終了後(index0番目の月で一瞬ビルドされることを防ぐため)
      // 表示月が変わった場合に更新(setState呼び出しを最小限にするため)
      if (mounted &&
          isCurrentMonthDisplayed &&
          nextDispIndex != _dispMonthIndex) {
        setState(() {
          _dispMonthIndex = nextDispIndex;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // 現在から前後24ヶ月のリストを生成
    final now = DateTime.now();
    final months = List.generate(AppLogic.totalMonthCount, (i) {
      final offset = i - AppLogic.currentMonthIndex;
      return DateTime(now.year, now.month + offset, AppLogic.monthFirstDate);
    });

    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(height: 16),
            LiquidGlassLayer(
              child: LiquidGlassButton(
                height: 50.0,
                width: 50.0,
                borderRadius: 25.0,
                onTap: () {
                  _itemScrollController.scrollTo(
                    alignment: 0.1,
                    index: _currentMonthIndex,
                    duration: AppDuration.backToCurrentMonthAnimation,
                    curve: Curves.easeInOut,
                  );
                },
                child: const Icon(
                  Icons.undo,
                  size: AppLayout.backToCurrentMonthButtonSize,
                  color: AppColor.secondaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            CalendarBody(
              months: months,
              itemScrollController: _itemScrollController,
              itemPositionsListener: _itemPositionsListener,
              currentMonthIndex: _currentMonthIndex,
              dispMonthIndex: _dispMonthIndex,
            ),
            LiquidGlassLayer(
              settings: const LiquidGlassSettings(
                thickness: 10,
                blur: 2,
                lightIntensity: 1.5,
                lightAngle: 45,
              ),
              child: SizedBox(
                height: 56,
                child: LiquidGlass(
                  shape: LiquidRoundedRectangle(borderRadius: 0.0),
                  child: GlassGlow(
                    hitTestBehavior: HitTestBehavior.deferToChild,
                    glowColor: AppColor.grow,
                    glowRadius: 3.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            '${months[_dispMonthIndex].year}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: AppColor.secondaryColor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: GestureDetector(
                            child: Icon(
                              Icons.logout,
                              color: AppColor.secondaryColor,
                              size: 20,
                            ),
                            onTap: () {
                              // ログアウトダイアログを呼び出す
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return CommonDialog(
                                    title: 'ログアウトしますか？',
                                    primaryButtonText: 'はい',
                                    secondButtonText: 'キャンセル',
                                    primaryAction: () {
                                      Navigator.pop(context);
                                      ref
                                          .read(authControllerProvider.notifier)
                                          .signOut();
                                    },
                                    secondAction: () {
                                      Navigator.pop(context);
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
