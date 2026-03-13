// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'watch_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$WatchListState {
  List<Result> get movies => throw _privateConstructorUsedError;
  List<AiringTodayResults> get series => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of WatchListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WatchListStateCopyWith<WatchListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WatchListStateCopyWith<$Res> {
  factory $WatchListStateCopyWith(
    WatchListState value,
    $Res Function(WatchListState) then,
  ) = _$WatchListStateCopyWithImpl<$Res, WatchListState>;
  @useResult
  $Res call({
    List<Result> movies,
    List<AiringTodayResults> series,
    bool isLoading,
    String? error,
  });
}

/// @nodoc
class _$WatchListStateCopyWithImpl<$Res, $Val extends WatchListState>
    implements $WatchListStateCopyWith<$Res> {
  _$WatchListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WatchListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? movies = null,
    Object? series = null,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
            movies: null == movies
                ? _value.movies
                : movies // ignore: cast_nullable_to_non_nullable
                      as List<Result>,
            series: null == series
                ? _value.series
                : series // ignore: cast_nullable_to_non_nullable
                      as List<AiringTodayResults>,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WatchListImplCopyWith<$Res>
    implements $WatchListStateCopyWith<$Res> {
  factory _$$WatchListImplCopyWith(
    _$WatchListImpl value,
    $Res Function(_$WatchListImpl) then,
  ) = __$$WatchListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<Result> movies,
    List<AiringTodayResults> series,
    bool isLoading,
    String? error,
  });
}

/// @nodoc
class __$$WatchListImplCopyWithImpl<$Res>
    extends _$WatchListStateCopyWithImpl<$Res, _$WatchListImpl>
    implements _$$WatchListImplCopyWith<$Res> {
  __$$WatchListImplCopyWithImpl(
    _$WatchListImpl _value,
    $Res Function(_$WatchListImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WatchListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? movies = null,
    Object? series = null,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(
      _$WatchListImpl(
        movies: null == movies
            ? _value._movies
            : movies // ignore: cast_nullable_to_non_nullable
                  as List<Result>,
        series: null == series
            ? _value._series
            : series // ignore: cast_nullable_to_non_nullable
                  as List<AiringTodayResults>,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$WatchListImpl implements WatchList {
  const _$WatchListImpl({
    final List<Result> movies = const [],
    final List<AiringTodayResults> series = const [],
    this.isLoading = false,
    this.error,
  }) : _movies = movies,
       _series = series;

  final List<Result> _movies;
  @override
  @JsonKey()
  List<Result> get movies {
    if (_movies is EqualUnmodifiableListView) return _movies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_movies);
  }

  final List<AiringTodayResults> _series;
  @override
  @JsonKey()
  List<AiringTodayResults> get series {
    if (_series is EqualUnmodifiableListView) return _series;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_series);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;

  @override
  String toString() {
    return 'WatchListState(movies: $movies, series: $series, isLoading: $isLoading, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WatchListImpl &&
            const DeepCollectionEquality().equals(other._movies, _movies) &&
            const DeepCollectionEquality().equals(other._series, _series) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_movies),
    const DeepCollectionEquality().hash(_series),
    isLoading,
    error,
  );

  /// Create a copy of WatchListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WatchListImplCopyWith<_$WatchListImpl> get copyWith =>
      __$$WatchListImplCopyWithImpl<_$WatchListImpl>(this, _$identity);
}

abstract class WatchList implements WatchListState {
  const factory WatchList({
    final List<Result> movies,
    final List<AiringTodayResults> series,
    final bool isLoading,
    final String? error,
  }) = _$WatchListImpl;

  @override
  List<Result> get movies;
  @override
  List<AiringTodayResults> get series;
  @override
  bool get isLoading;
  @override
  String? get error;

  /// Create a copy of WatchListState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WatchListImplCopyWith<_$WatchListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
