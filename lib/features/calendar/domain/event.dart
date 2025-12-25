//
// Copyright (c) 2025 sumiirenon. All rights reserved.
//

import 'dart:ui';

import 'package:table_calendar/table_calendar.dart';

/// イベントの種類を表す列挙型
enum EventPosition {
  start,
  middle,
  end,
  single,
  none,
}

///
/// イベントデータのモデルクラス
///
class Event {
  final String id;
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final Color color;

  const Event({
    required this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.color,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'startDate': startDate.toIso8601String(),
    'endDate': endDate.toIso8601String(),
    'color': color.toARGB32(),
  };

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] as String,
      title: json['title'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      color: Color(json['color'] as int),
    );
  }

  // 指定された日付がイベントの範囲内にあるか判定する
  bool isInRange(DateTime day) {
    final target = DateTime(day.year, day.month, day.day);
    final start = DateTime(
      startDate.year,
      startDate.month,
      startDate.day,
    );
    final end = DateTime(
      endDate.year,
      endDate.month,
      endDate.day,
    );
    return target.isAfter(start.subtract(const Duration(days: 1))) &&
        target.isBefore(end.add(const Duration(days: 1)));
  }

  // イベントの位置を取得する
  EventPosition getPosition(DateTime day) {
    if (day.isBefore(startDate) || day.isAfter(endDate)) {
      return EventPosition.none;
    }

    if (isSameDay(startDate, endDate)) {
      return EventPosition.single;
    }
    if (isSameDay(day, startDate)) {
      return EventPosition.start;
    }
    if (isSameDay(day, endDate)) {
      return EventPosition.end;
    }
    return EventPosition.middle;
  }
}
