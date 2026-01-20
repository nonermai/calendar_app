//
// Copyright (c) 2025-2026 Renon Sumii. All rights reserved.
//

import 'package:calender_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:calender_app/features/calendar/data/event_data_source.dart';
import 'package:calender_app/features/calendar/data/event_repository_impl.dart';
import 'package:calender_app/features/calendar/domain/event.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'event_list_controller.g.dart';

///
/// イベント一覧を管理するコントローラー（StateNotifier / ViewModel)みたいなもん
///
@riverpod
class EventListController extends _$EventListController {
  // リポジトリ作成(EventDataSourceを使ってリポジトリを初期化)
  final EventRepositoryImpl _repo = EventRepositoryImpl(EventDataSource());

  @override
  Future<List<Event>> build() async {
    final authUser = ref.watch(authControllerProvider).value;

    // 未ログイン時
    if (authUser == null) {
      return [];
    }

    // イベント一覧取得
    return _repo.fetchEvents(authUser.uid);
  }

  // イベント追加メソッド
  Future<void> createEvent(
    String title,
    DateTime startDate,
    DateTime endDate,
    Color color,
  ) async {
    final authUser = ref.read(authControllerProvider).value;

    if (authUser == null) return;

    final event = Event(
      // 一意なIDを生成（簡易的にミリ秒を使用(1970年1月1日からの経過ミリ秒数)）
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      startDate: startDate,
      endDate: endDate,
      color: color,
    );

    await _repo.createEvent(
      authUser.uid,
      event,
    );
    // Viewを更新
    // プロバイダーを削除することで、buildメソッドが呼ばれ最新データを取得する
    ref.invalidateSelf();
  }

  // イベント削除メソッド
  Future<void> deleteEvent(String id) async {
    final authUser = ref.read(authControllerProvider).value;

    if (authUser == null) return;

    await _repo.deleteEvent(authUser.uid, id);

    // Viewを更新
    // プロバイダーを削除することで、buildメソッドが呼ばれ最新データを取得する
    ref.invalidateSelf();
  }

  // ユーザードキュメント削除メソッド
  Future<void> deleteUserDocument() async {
    final authUser = ref.read(authControllerProvider).value;
    if (authUser == null) return;
    await _repo.deleteUserDocument(authUser.uid);
  }
}
