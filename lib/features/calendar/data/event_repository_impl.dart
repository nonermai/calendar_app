//
// Copyright (c) 2025-2026 Renon Sumii. All rights reserved.
//

import 'package:calender_app/features/calendar/domain/event.dart';
import 'package:calender_app/features/calendar/domain/event_repository_interface.dart';

import 'event_data_source.dart';

///
/// Repositoryの実装。DataSourceを利用してFirestoreにアクセスするクラス
///
class EventRepositoryImpl implements EventRepository {
  final EventDataSource _dataSource;

  EventRepositoryImpl(this._dataSource);

  @override
  Future<List<Event>> fetchEvents(String uid) {
    return _dataSource.getEvents(uid);
  }

  @override
  Future<void> createEvent(String uid, Event event) {
    return _dataSource.createEvent(
      uid: uid,
      event: event,
    );
  }

  @override
  Future<void> deleteEvent(String uid, String eventId) {
    return _dataSource.deleteEvent(
      uid: uid,
      eventId: eventId,
    );
  }

  @override
  Future<void> deleteUserDocument(String uid) {
    return _dataSource.deleteUserDocument(uid);
  }
}
