// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(analyticsHelper)
const analyticsHelperProvider = AnalyticsHelperProvider._();

final class AnalyticsHelperProvider
    extends
        $FunctionalProvider<AnalyticsHelper, AnalyticsHelper, AnalyticsHelper>
    with $Provider<AnalyticsHelper> {
  const AnalyticsHelperProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'analyticsHelperProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$analyticsHelperHash();

  @$internal
  @override
  $ProviderElement<AnalyticsHelper> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AnalyticsHelper create(Ref ref) {
    return analyticsHelper(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AnalyticsHelper value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AnalyticsHelper>(value),
    );
  }
}

String _$analyticsHelperHash() => r'a17d83c69d8fca159e9efe52e23bd4b44c28a0a2';
