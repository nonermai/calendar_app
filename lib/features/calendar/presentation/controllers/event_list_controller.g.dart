// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
///
/// イベント一覧を管理するコントローラー（StateNotifier / ViewModel)みたいなもん
///

@ProviderFor(EventListController)
const eventListControllerProvider = EventListControllerProvider._();

///
/// イベント一覧を管理するコントローラー（StateNotifier / ViewModel)みたいなもん
///
final class EventListControllerProvider
    extends $AsyncNotifierProvider<EventListController, List<Event>> {
  ///
  /// イベント一覧を管理するコントローラー（StateNotifier / ViewModel)みたいなもん
  ///
  const EventListControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eventListControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eventListControllerHash();

  @$internal
  @override
  EventListController create() => EventListController();
}

String _$eventListControllerHash() =>
    r'658b410248cb4ca74d1d71eede5355d2d991bc7d';

///
/// イベント一覧を管理するコントローラー（StateNotifier / ViewModel)みたいなもん
///

abstract class _$EventListController extends $AsyncNotifier<List<Event>> {
  FutureOr<List<Event>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<Event>>, List<Event>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Event>>, List<Event>>,
              AsyncValue<List<Event>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
