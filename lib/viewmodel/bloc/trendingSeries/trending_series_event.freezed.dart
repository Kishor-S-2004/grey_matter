// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trending_series_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TrendingSeriesEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchTrendingSeries,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchTrendingSeries,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchTrendingSeries,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchTrendingSeries value) fetchTrendingSeries,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchTrendingSeries value)? fetchTrendingSeries,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchTrendingSeries value)? fetchTrendingSeries,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrendingSeriesEventCopyWith<$Res> {
  factory $TrendingSeriesEventCopyWith(
    TrendingSeriesEvent value,
    $Res Function(TrendingSeriesEvent) then,
  ) = _$TrendingSeriesEventCopyWithImpl<$Res, TrendingSeriesEvent>;
}

/// @nodoc
class _$TrendingSeriesEventCopyWithImpl<$Res, $Val extends TrendingSeriesEvent>
    implements $TrendingSeriesEventCopyWith<$Res> {
  _$TrendingSeriesEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TrendingSeriesEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$FetchTrendingSeriesImplCopyWith<$Res> {
  factory _$$FetchTrendingSeriesImplCopyWith(
    _$FetchTrendingSeriesImpl value,
    $Res Function(_$FetchTrendingSeriesImpl) then,
  ) = __$$FetchTrendingSeriesImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FetchTrendingSeriesImplCopyWithImpl<$Res>
    extends _$TrendingSeriesEventCopyWithImpl<$Res, _$FetchTrendingSeriesImpl>
    implements _$$FetchTrendingSeriesImplCopyWith<$Res> {
  __$$FetchTrendingSeriesImplCopyWithImpl(
    _$FetchTrendingSeriesImpl _value,
    $Res Function(_$FetchTrendingSeriesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TrendingSeriesEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$FetchTrendingSeriesImpl implements FetchTrendingSeries {
  const _$FetchTrendingSeriesImpl();

  @override
  String toString() {
    return 'TrendingSeriesEvent.fetchTrendingSeries()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchTrendingSeriesImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchTrendingSeries,
  }) {
    return fetchTrendingSeries();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchTrendingSeries,
  }) {
    return fetchTrendingSeries?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchTrendingSeries,
    required TResult orElse(),
  }) {
    if (fetchTrendingSeries != null) {
      return fetchTrendingSeries();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchTrendingSeries value) fetchTrendingSeries,
  }) {
    return fetchTrendingSeries(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchTrendingSeries value)? fetchTrendingSeries,
  }) {
    return fetchTrendingSeries?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchTrendingSeries value)? fetchTrendingSeries,
    required TResult orElse(),
  }) {
    if (fetchTrendingSeries != null) {
      return fetchTrendingSeries(this);
    }
    return orElse();
  }
}

abstract class FetchTrendingSeries implements TrendingSeriesEvent {
  const factory FetchTrendingSeries() = _$FetchTrendingSeriesImpl;
}
