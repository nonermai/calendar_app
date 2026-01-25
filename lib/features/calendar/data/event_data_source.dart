//
// Copyright (c) 2025 Renon Sumii. All rights reserved.
//

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:calender_app/features/calendar/domain/event.dart';
import 'package:calender_app/core/logger/logger.dart';

///
/// 実際にDB操作するクラス
///
class EventDataSource {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// イベント一覧取得
  Future<List<Event>> getEvents(String uid) async {
    Logger.d('--> Fetching events from Firestore');
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('events')
        .get();
    Logger.d(
      '<-- Fetching events result : ${snapshot.docs.map((e) => e.data())}',
    );
    return snapshot.docs.map((doc) => Event.fromJson(doc.data())).toList();
  }

  /// イベント追加
  Future<void> createEvent({
    required String uid,
    required Event event,
  }) async {
    Logger.d('--> Create event for uid=$uid: ${event.toJson()}');

    await _db
        .collection('users')
        .doc(uid)
        .collection('events')
        .doc(event.id)
        .set(event.toJson());
  }

  /// イベント削除
  Future<void> deleteEvent({
    required String uid,
    required String eventId,
  }) async {
    Logger.d('--> Delete event uid=$uid eventId=$eventId');

    await _db
        .collection('users')
        .doc(uid)
        .collection('events')
        .doc(eventId)
        .delete();
  }

  /// uidを指定してユーザーのドキュメントを削除
  Future<void> deleteUserDocument(String uid) async {
    Logger.d('--> Delete user document uid=$uid');
    final userDocument = _db.collection('users').doc(uid);

    // 全イベントを削除
    final eventsSnapshot = await userDocument.collection('events').get();
    for (final doc in eventsSnapshot.docs) {
      await doc.reference.delete();
    }

    // ユーザードキュメントを削除
    await userDocument.delete();
  }
}
