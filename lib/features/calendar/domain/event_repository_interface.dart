//
// Copyright (c) 2025-2026 Renon Sumii. All rights reserved.
//

import 'event.dart';

///
/// Firestoreの実装に依存しない抽象的なリポジトリ定義
/// (「どこから持ってくるか」は言わずに「何をしてほしいかだけ」を決めるイメージ)
///
abstract class EventRepository {
  Future<List<Event>> fetchEvents(String uid);
  Future<void> createEvent(String uid, Event event);
  Future<void> deleteEvent(String uid, String eventId);
  Future<void> deleteUserDocument(String uid);
}
