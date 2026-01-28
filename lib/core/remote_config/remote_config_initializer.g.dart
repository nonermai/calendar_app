// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_config_initializer.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(remoteConfigInitializer)
const remoteConfigInitializerProvider = RemoteConfigInitializerProvider._();

final class RemoteConfigInitializerProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  const RemoteConfigInitializerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'remoteConfigInitializerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$remoteConfigInitializerHash();

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    return remoteConfigInitializer(ref);
  }
}

String _$remoteConfigInitializerHash() =>
    r'528a6e3325200b97f74e89259bcfacadcbc21b63';
