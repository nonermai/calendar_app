//
// Copyright (c) 2025-2026 sumiirenon. All rights reserved.
//

import 'package:calender_app/core/constants/app_layout.dart';
import 'package:calender_app/core/constants/app_logic.dart';
import 'package:calender_app/core/constants/app_string.dart';
import 'package:calender_app/core/theme/app_theme.dart';
import 'package:calender_app/core/widgets/common_dialog.dart';
import 'package:calender_app/core/widgets/liquid_glass_button.dart';
import 'package:calender_app/features/calendar/presentation/widgets/add_event_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calender_app/features/calendar/domain/event.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:table_calendar/table_calendar.dart';
import '../controllers/event_list_controller.dart';

///
/// カレンダー画面の本体のクラス
///
class CalendarBody extends ConsumerStatefulWidget {
  const CalendarBody({
    super.key,
    required this.months,
    required this.itemScrollController,
    required this.itemPositionsListener,
    required this.currentMonthIndex,
    required this.dispMonthIndex,
  });

  final List<DateTime> months;
  final ItemScrollController itemScrollController;
  final ItemPositionsListener itemPositionsListener;
  final int currentMonthIndex;
  final int dispMonthIndex;

  @override
  ConsumerState<CalendarBody> createState() => _CalendarBodyState();
}

class _CalendarBodyState extends ConsumerState<CalendarBody> {
  // 選択された日付(初期値は現在の日付)
  DateTime? _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    // イベント一覧の非同期データを監視
    final eventsAsync = ref.watch(eventListControllerProvider);

    return SafeArea(
      child: eventsAsync.when(
        // データ取得成功時
        data: (events) {
          final laneMap = buildLaneMap(events);

          return ScrollablePositionedList.builder(
            itemScrollController: widget.itemScrollController,
            itemPositionsListener: widget.itemPositionsListener,
            itemCount: widget.months.length,
            itemBuilder: (context, index) {
              final dispMonth = widget.months[index];
              return Column(
                children: [
                  const SizedBox(
                    height: AppLayout.calendarHeaderVerticalSpace,
                  ),
                  // 各月を表示
                  Text(
                    '${dispMonth.month}${AppString.monthUnit}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColor.secondaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: AppLayout.calendarHeaderVerticalSpace,
                  ),
                  TableCalendar(
                    locale: "ja_JP",
                    firstDay: AppLogic.firstDisplayDate,
                    lastDay: AppLogic.lastDisplayDate,
                    focusedDay: dispMonth,
                    selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                    // セルを選択した時の処理
                    onDaySelected: (selected, focused) {
                      setState(() {
                        _selectedDay = selected;
                      });
                      // bottomSheetModalを表示
                      _showAddEventSheet(events, selected);
                    },
                    calendarFormat: CalendarFormat.month,
                    availableGestures: AvailableGestures.none,
                    headerVisible: false,
                    calendarStyle: const CalendarStyle(
                      outsideDaysVisible: false,
                      todayDecoration: BoxDecoration(
                        color: AppColor.accentColor,
                        shape: BoxShape.circle,
                      ),
                      // 選択された日の背景色
                      selectedDecoration: BoxDecoration(
                        color: AppColor.secondaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    daysOfWeekVisible: false,
                    rowHeight: AppLayout.cellHeight,
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      leftChevronVisible: false,
                      rightChevronVisible: false,
                      titleCentered: true,
                      titleTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppColor.secondaryColor,
                      ),
                      titleTextFormatter: (date, locale) {
                        return '${date.month}${AppString.monthUnit}';
                      },
                    ),
                    // カレンダーの日付セルをカスタム描画する
                    // 日付の分だけ呼ばれる関数
                    calendarBuilders: CalendarBuilders(
                      // 今日でも選択日でもない日のbuilder
                      // サークルは今日または選択時にしか表示されないため、サークルの背景色はここでは指定しない
                      defaultBuilder: (context, day, focusedDay) =>
                          buildDefault(context, day, events),
                      // 今日の日のbuilder
                      todayBuilder: (context, day, focusedDay) =>
                          buildToday(context, day, events),
                      // 選択された日のbuilder
                      selectedBuilder: (context, day, focusedDay) =>
                          buildSelected(context, day, events),
                      // イベント表示用のbuilder
                      markerBuilder: (context, day, _) =>
                          buildEventMarker(context, day, events, laneMap),
                    ),
                  ),
                ],
              );
            },
          );
        },
        // データ取得中
        loading: () => const Center(child: CircularProgressIndicator()),
        // データ取得失敗時
        error: (err, _) => Center(child: Text('エラー: $err')),
      ),
    );
  }

  // 今日でも選択日でもない日のbuildメソッド
  Widget? buildDefault(
    BuildContext context,
    DateTime day,
    List<Event> events,
  ) {
    // セルの文字色カスタム
    final weekday = day.weekday;
    Color textColor;
    if (weekday == DateTime.sunday) {
      // 日曜日は赤
      textColor = AppColor.accentColor;
    } else if (weekday == DateTime.saturday) {
      // 土曜日は青
      textColor = AppColor.saturdayColor;
    } else {
      textColor = AppColor.secondaryColor;
    }
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: AppLayout.cellNumberSize,
        height: AppLayout.cellNumberSize,
        alignment: Alignment.center,
        child: Text(
          '${day.day}',
          style: TextStyle(
            color: textColor,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  // 今日の日のbuildメソッド
  Widget? buildToday(
    BuildContext context,
    DateTime day,
    List<Event> events,
  ) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: AppLayout.cellNumberSize,
        height: AppLayout.cellNumberSize,
        decoration: const BoxDecoration(
          color: AppColor.accentColor,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(
          '${day.day}',
          style: const TextStyle(
            color: AppColor.primaryColor,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  // 選択された日のbuildメソッド
  Widget? buildSelected(
    BuildContext context,
    DateTime day,
    List<Event> events,
  ) {
    final isToday = isSameDay(day, DateTime.now());
    // todayBuilderよりもselectedBuilderが優先されるため、
    // 選択する日=今日の場合、背景色を赤に上書きする
    final backgroundColor = isToday
        ? AppColor.accentColor
        : AppColor.secondaryColor;
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: AppLayout.cellNumberSize,
        height: AppLayout.cellNumberSize,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(
          '${day.day}',
          style: const TextStyle(
            color: AppColor.primaryColor,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  // イベント表示用のbuildメソッド
  Widget? buildEventMarker(
    BuildContext context,
    DateTime day,
    List<Event> events,
    Map<DateTime, Map<Event, int>> laneMap,
  ) {
    final dayEvents = getEventsForDay(day, events);
    if (dayEvents.isEmpty) return null;

    return Stack(
      children: [
        for (final event in dayEvents)
          Positioned(
            top:
                AppLayout.eventBandOffset +
                (laneMap[DateTime(day.year, day.month, day.day)]![event]! *
                    AppLayout.eventBandAreaHeight),
            left: AppLayout.eventBandHorizontalPadding,
            right: AppLayout.eventBandHorizontalPadding,
            child: buildEventBand(event, event.getPosition(day)),
          ),
      ],
    );
  }

  // イベントを帯状で描画するウィジェット
  Widget buildEventBand(Event event, EventPosition position) {
    // 角丸の半径
    BorderRadius radius;
    // 帯の左右マージン
    EdgeInsetsGeometry? margin;

    switch (position) {
      case EventPosition.start:
        radius = const BorderRadius.horizontal(
          left: Radius.circular(
            AppLayout.eventBandBorderRadius,
          ),
          right: Radius.zero,
        );
        margin = const EdgeInsets.only(
          left: AppLayout.eventBandHorizontalMargin,
        );
        break;
      case EventPosition.middle:
        radius = BorderRadius.zero;
        break;
      case EventPosition.end:
        radius = const BorderRadius.horizontal(
          left: Radius.zero,
          right: Radius.circular(
            AppLayout.eventBandBorderRadius,
          ),
        );
        margin = const EdgeInsets.only(
          right: AppLayout.eventBandHorizontalMargin,
        );
        break;
      case EventPosition.single:
        radius = BorderRadius.circular(
          AppLayout.eventBandBorderRadius,
        );
        margin = const EdgeInsets.symmetric(
          horizontal: AppLayout.eventBandHorizontalMargin,
        );
        break;
      default:
        return const SizedBox.shrink();
    }

    return Container(
      height: AppLayout.eventBandHeight,
      margin: margin,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: event.color,
        borderRadius: radius,
      ),
      child: position == EventPosition.start || position == EventPosition.single
          ? Text(
              event.title,
              style: TextStyle(
                fontSize: 10,
                color:
                    event.color.computeLuminance() >
                        AppLayout.luminanceThreshold
                    ? AppColor.secondaryColor
                    : AppColor.primaryColor,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            )
          : null,
    );
  }

  Map<DateTime, Map<Event, int>> buildLaneMap(List<Event> events) {
    final laneMap = <DateTime, Map<Event, int>>{};

    // その日のイベントをsortする
    final sorted = [...events]
      ..sort((a, b) {
        // 優先度 1: 開始日の比較 (早い順: 昇順)
        final dateComparison = a.startDate.compareTo(b.startDate);
        if (dateComparison != 0) {
          return dateComparison;
        }
        // 優先度 2: 期間の比較 (長い順: 降順)
        final lengthA = a.endDate.difference(a.startDate).inDays;
        final lengthB = b.endDate.difference(b.startDate).inDays;
        return lengthB.compareTo(lengthA);
      });

    for (final event in sorted) {
      DateTime day = DateTime(
        event.startDate.year,
        event.startDate.month,
        event.startDate.day,
      );
      final last = DateTime(
        event.endDate.year,
        event.endDate.month,
        event.endDate.day,
      );

      // 割り当てるレーン番号
      int lane = 0;

      while (true) {
        bool ok = true;
        DateTime cursor = day;

        while (!cursor.isAfter(last)) {
          laneMap.putIfAbsent(cursor, () => {});
          if (laneMap[cursor]!.values.contains(lane)) {
            ok = false;
            break;
          }
          cursor = cursor.add(const Duration(days: 1));
        }

        if (ok) break;

        lane++;
      }

      DateTime cursor = day;
      while (!cursor.isAfter(last)) {
        laneMap[cursor]!.putIfAbsent(event, () => lane);
        cursor = cursor.add(const Duration(days: 1));
      }
    }

    return laneMap;
  }

  // 日付選択時にモーダルシートを表示する
  void _showAddEventSheet(List events, DateTime selected) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColor.primaryColor,
      builder: (context) {
        // 選択された日のイベントを抽出
        final EventListController eventListController = ref.read(
          eventListControllerProvider.notifier,
        );
        final dayEvents = events
            .where(
              (event) =>
                  // 選択された日(selected)が、イベントの開始日(startDate)と
                  // イベントの終了日(endDate)の間（またはその日付自体）に含まれている
                  !selected.isBefore(event.startDate) &&
                  !selected.isAfter(event.endDate),
            )
            .toList();

        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(
                AppLayout.modalContentPadding,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${selected.month}${AppString.monthUnit}${selected.day}${AppString.dayUnit}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColor.secondaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: AppLayout.modalDateBottomSpace,
                  ),
                  // イベントがない場合
                  if (dayEvents.isEmpty)
                    Center(
                      child: Text(
                        AppString.noEvents,
                        style: TextStyle(
                          color: AppColor.thirdColor,
                        ),
                      ),
                    )
                  else
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: dayEvents.length,
                        itemBuilder: (context, index) {
                          final event = dayEvents[index];
                          return ListTile(
                            // イベントのタイトルを表示
                            title: Text(
                              event.title,
                              style: const TextStyle(
                                fontSize: 16,
                                color: AppColor.secondaryColor,
                              ),
                            ),
                            // イベントタップ時の処理
                            onTap: () {
                              // ダイアログ表示
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return CommonDialog(
                                    title: AppString.confirmDeleteEventMessage,
                                    primaryButtonText: AppString.delete,
                                    secondButtonText: AppString.cancel,
                                    primaryAction: () {
                                      // idを指定してイベント削除
                                      eventListController.deleteEvent(
                                        event.id,
                                      );
                                      // ダイアログとモーダルを両方閉じる
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                    secondAction: () {
                                      Navigator.pop(context);
                                    },
                                  );
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
            Positioned(
              right: AppLayout.modalAddButtonRightPosition,
              bottom: AppLayout.modalAddButtonBottomPosition,
              child: LiquidGlassLayer(
                child: LiquidGlassButton(
                  height: 48,
                  width: 48,
                  borderRadius: 24.0,
                  onTap: () {
                    // ダイアログ表示
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AddEventDialog(
                          initialDate: selected,
                          onAddEvent: (title, start, end, color) {
                            eventListController.createEvent(
                              title,
                              start,
                              end,
                              color,
                            );
                          },
                        );
                      },
                    );
                  },
                  child: const Icon(
                    Icons.add,
                    size: AppLayout.modalAddButtonIconSize,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// 指定した日に該当する「期間イベント」を返す
  List<Event> getEventsForDay(DateTime day, List<Event> events) {
    return events.where((e) => e.isInRange(day)).toList();
  }
}
