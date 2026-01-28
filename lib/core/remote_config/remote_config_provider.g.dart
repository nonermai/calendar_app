// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_config_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(remoteConfigService)
const remoteConfigServiceProvider = RemoteConfigServiceProvider._();

final class RemoteConfigServiceProvider
    extends
        $FunctionalProvider<
          RemoteConfigService,
          RemoteConfigService,
          RemoteConfigService
        >
    with $Provider<RemoteConfigService> {
  const RemoteConfigServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'remoteConfigServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$remoteConfigServiceHash();

  @$internal
  @override
  $ProviderElement<RemoteConfigService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RemoteConfigService create(Ref ref) {
    return remoteConfigService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RemoteConfigService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RemoteConfigService>(value),
    );
  }
}

String _$remoteConfigServiceHash() =>
    r'279530aff22db390c67fdf8797bd70981336a0c7';
