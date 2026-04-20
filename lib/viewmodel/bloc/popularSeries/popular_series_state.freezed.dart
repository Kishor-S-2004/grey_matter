// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'popular_series_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PopularSeriesState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<AiringTodayResults> results) loaded,
    required TResult Function(String errorMsg) failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<AiringTodayResults> results)? loaded,
    TResult? Function(String errorMsg)? failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<AiringTodayResults> results)? loaded,
    TResult Function(String errorMsg)? failure,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PopularSeriesInitial value) initial,
    required TResult Function(PopularSeriesLoading value) loading,
    required TResult Function(PopularSeriesLoaded value) loaded,
    required TResult Function(PopularSeriesFailure value) failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PopularSeriesInitial value)? initial,
    TResult? Function(PopularSeriesLoading value)? loading,
    TResult? Function(PopularSeriesLoaded value)? loaded,
    TResult? Function(PopularSeriesFailure value)? failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PopularSeriesInitial value)? initial,
    TResult Function(PopularSeriesLoading value)? loading,
    TResult Function(PopularSeriesLoaded value)? loaded,
    TResult Function(PopularSeriesFailure value)? failure,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PopularSeriesStateCopyWith<$Res> {
  factory $PopularSeriesStateCopyWith(
    PopularSeriesState value,
    $Res Function(PopularSeriesState) then,
  ) = _$PopularSeriesStateCopyWithImpl<$Res, PopularSeriesState>;
}

/// @nodoc
class _$PopularSeriesStateCopyWithImpl<$Res, $Val extends PopularSeriesState>
    implements $PopularSeriesStateCopyWith<$Res> {
  _$PopularSeriesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PopularSeriesState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$PopularSeriesInitialImplCopyWith<$Res> {
  factory _$$PopularSeriesInitialImplCopyWith(
    _$PopularSeriesInitialImpl value,
    $Res Function(_$PopularSeriesInitialImpl) then,
  ) = __$$PopularSeriesInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PopularSeriesInitialImplCopyWithImpl<$Res>
    extends _$PopularSeriesStateCopyWithImpl<$Res, _$PopularSeriesInitialImpl>
    implements _$$PopularSeriesInitialImplCopyWith<$Res> {
  __$$PopularSeriesInitialImplCopyWithImpl(
    _$PopularSeriesInitialImpl _value,
    $Res Function(_$PopularSeriesInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PopularSeriesState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PopularSeriesInitialImpl implements PopularSeriesInitial {
  const _$PopularSeriesInitialImpl();

  @override
  String toString() {
    return 'PopularSeriesState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PopularSeriesInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<AiringTodayResults> results) loaded,
    required TResult Function(String errorMsg) failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<AiringTodayResults> results)? loaded,
    TResult? Function(String errorMsg)? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<AiringTodayResults> results)? loaded,
    TResult Function(String errorMsg)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PopularSeriesInitial value) initial,
    required TResult Function(PopularSeriesLoading value) loading,
    required TResult Function(PopularSeriesLoaded value) loaded,
    required TResult Function(PopularSeriesFailure value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PopularSeriesInitial value)? initial,
    TResult? Function(PopularSeriesLoading value)? loading,
    TResult? Function(PopularSeriesLoaded value)? loaded,
    TResult? Function(PopularSeriesFailure value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PopularSeriesInitial value)? initial,
    TResult Function(PopularSeriesLoading value)? loading,
    TResult Function(PopularSeriesLoaded value)? loaded,
    TResult Function(PopularSeriesFailure value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class PopularSeriesInitial implements PopularSeriesState {
  const factory PopularSeriesInitial() = _$PopularSeriesInitialImpl;
}

/// @nodoc
abstract class _$$PopularSeriesLoadingImplCopyWith<$Res> {
  factory _$$PopularSeriesLoadingImplCopyWith(
    _$PopularSeriesLoadingImpl value,
    $Res Function(_$PopularSeriesLoadingImpl) then,
  ) = __$$PopularSeriesLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PopularSeriesLoadingImplCopyWithImpl<$Res>
    extends _$PopularSeriesStateCopyWithImpl<$Res, _$PopularSeriesLoadingImpl>
    implements _$$PopularSeriesLoadingImplCopyWith<$Res> {
  __$$PopularSeriesLoadingImplCopyWithImpl(
    _$PopularSeriesLoadingImpl _value,
    $Res Function(_$PopularSeriesLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PopularSeriesState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PopularSeriesLoadingImpl implements PopularSeriesLoading {
  const _$PopularSeriesLoadingImpl();

  @override
  String toString() {
    return 'PopularSeriesState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PopularSeriesLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<AiringTodayResults> results) loaded,
    required TResult Function(String errorMsg) failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<AiringTodayResults> results)? loaded,
    TResult? Function(String errorMsg)? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<AiringTodayResults> results)? loaded,
    TResult Function(String errorMsg)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PopularSeriesInitial value) initial,
    required TResult Function(PopularSeriesLoading value) loading,
    required TResult Function(PopularSeriesLoaded value) loaded,
    required TResult Function(PopularSeriesFailure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PopularSeriesInitial value)? initial,
    TResult? Function(PopularSeriesLoading value)? loading,
    TResult? Function(PopularSeriesLoaded value)? loaded,
    TResult? Function(PopularSeriesFailure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PopularSeriesInitial value)? initial,
    TResult Function(PopularSeriesLoading value)? loading,
    TResult Function(PopularSeriesLoaded value)? loaded,
    TResult Function(PopularSeriesFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class PopularSeriesLoading implements PopularSeriesState {
  const factory PopularSeriesLoading() = _$PopularSeriesLoadingImpl;
}

/// @nodoc
abstract class _$$PopularSeriesLoadedImplCopyWith<$Res> {
  factory _$$PopularSeriesLoadedImplCopyWith(
    _$PopularSeriesLoadedImpl value,
    $Res Function(_$PopularSeriesLoadedImpl) then,
  ) = __$$PopularSeriesLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<AiringTodayResults> results});
}

/// @nodoc
class __$$PopularSeriesLoadedImplCopyWithImpl<$Res>
    extends _$PopularSeriesStateCopyWithImpl<$Res, _$PopularSeriesLoadedImpl>
    implements _$$PopularSeriesLoadedImplCopyWith<$Res> {
  __$$PopularSeriesLoadedImplCopyWithImpl(
    _$PopularSeriesLoadedImpl _value,
    $Res Function(_$PopularSeriesLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PopularSeriesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? results = null}) {
    return _then(
      _$PopularSeriesLoadedImpl(
        null == results
            ? _value._results
            : results // ignore: cast_nullable_to_non_nullable
                  as List<AiringTodayResults>,
      ),
    );
  }
}

/// @nodoc

class _$PopularSeriesLoadedImpl implements PopularSeriesLoaded {
  const _$PopularSeriesLoadedImpl(final List<AiringTodayResults> results)
    : _results = results;

  final List<AiringTodayResults> _results;
  @override
  List<AiringTodayResults> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  String toString() {
    return 'PopularSeriesState.loaded(results: $results)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PopularSeriesLoadedImpl &&
            const DeepCollectionEquality().equals(other._results, _results));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_results));

  /// Create a copy of PopularSeriesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PopularSeriesLoadedImplCopyWith<_$PopularSeriesLoadedImpl> get copyWith =>
      __$$PopularSeriesLoadedImplCopyWithImpl<_$PopularSeriesLoadedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<AiringTodayResults> results) loaded,
    required TResult Function(String errorMsg) failure,
  }) {
    return loaded(results);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<AiringTodayResults> results)? loaded,
    TResult? Function(String errorMsg)? failure,
  }) {
    return loaded?.call(results);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<AiringTodayResults> results)? loaded,
    TResult Function(String errorMsg)? failure,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(results);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PopularSeriesInitial value) initial,
    required TResult Function(PopularSeriesLoading value) loading,
    required TResult Function(PopularSeriesLoaded value) loaded,
    required TResult Function(PopularSeriesFailure value) failure,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PopularSeriesInitial value)? initial,
    TResult? Function(PopularSeriesLoading value)? loading,
    TResult? Function(PopularSeriesLoaded value)? loaded,
    TResult? Function(PopularSeriesFailure value)? failure,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PopularSeriesInitial value)? initial,
    TResult Function(PopularSeriesLoading value)? loading,
    TResult Function(PopularSeriesLoaded value)? loaded,
    TResult Function(PopularSeriesFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class PopularSeriesLoaded implements PopularSeriesState {
  const factory PopularSeriesLoaded(final List<AiringTodayResults> results) =
      _$PopularSeriesLoadedImpl;

  List<AiringTodayResults> get results;

  /// Create a copy of PopularSeriesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PopularSeriesLoadedImplCopyWith<_$PopularSeriesLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PopularSeriesFailureImplCopyWith<$Res> {
  factory _$$PopularSeriesFailureImplCopyWith(
    _$PopularSeriesFailureImpl value,
    $Res Function(_$PopularSeriesFailureImpl) then,
  ) = __$$PopularSeriesFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String errorMsg});
}

/// @nodoc
class __$$PopularSeriesFailureImplCopyWithImpl<$Res>
    extends _$PopularSeriesStateCopyWithImpl<$Res, _$PopularSeriesFailureImpl>
    implements _$$PopularSeriesFailureImplCopyWith<$Res> {
  __$$PopularSeriesFailureImplCopyWithImpl(
    _$PopularSeriesFailureImpl _value,
    $Res Function(_$PopularSeriesFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PopularSeriesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? errorMsg = null}) {
    return _then(
      _$PopularSeriesFailureImpl(
        null == errorMsg
            ? _value.errorMsg
            : errorMsg // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$PopularSeriesFailureImpl implements PopularSeriesFailure {
  const _$PopularSeriesFailureImpl(this.errorMsg);

  @override
  final String errorMsg;

  @override
  String toString() {
    return 'PopularSeriesState.failure(errorMsg: $errorMsg)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PopularSeriesFailureImpl &&
            (identical(other.errorMsg, errorMsg) ||
                other.errorMsg == errorMsg));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorMsg);

  /// Create a copy of PopularSeriesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PopularSeriesFailureImplCopyWith<_$PopularSeriesFailureImpl>
  get copyWith =>
      __$$PopularSeriesFailureImplCopyWithImpl<_$PopularSeriesFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<AiringTodayResults> results) loaded,
    required TResult Function(String errorMsg) failure,
  }) {
    return failure(errorMsg);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<AiringTodayResults> results)? loaded,
    TResult? Function(String errorMsg)? failure,
  }) {
    return failure?.call(errorMsg);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<AiringTodayResults> results)? loaded,
    TResult Function(String errorMsg)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(errorMsg);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PopularSeriesInitial value) initial,
    required TResult Function(PopularSeriesLoading value) loading,
    required TResult Function(PopularSeriesLoaded value) loaded,
    required TResult Function(PopularSeriesFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PopularSeriesInitial value)? initial,
    TResult? Function(PopularSeriesLoading value)? loading,
    TResult? Function(PopularSeriesLoaded value)? loaded,
    TResult? Function(PopularSeriesFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PopularSeriesInitial value)? initial,
    TResult Function(PopularSeriesLoading value)? loading,
    TResult Function(PopularSeriesLoaded value)? loaded,
    TResult Function(PopularSeriesFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class PopularSeriesFailure implements PopularSeriesState {
  const factory PopularSeriesFailure(final String errorMsg) =
      _$PopularSeriesFailureImpl;

  String get errorMsg;

  /// Create a copy of PopularSeriesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PopularSeriesFailureImplCopyWith<_$PopularSeriesFailureImpl>
  get copyWith => throw _privateConstructorUsedError;
}
