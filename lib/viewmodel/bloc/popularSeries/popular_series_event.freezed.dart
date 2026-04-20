// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'popular_series_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PopularSeriesEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchPopularSeries,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchPopularSeries,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchPopularSeries,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchPopularSeriesEvent value) fetchPopularSeries,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchPopularSeriesEvent value)? fetchPopularSeries,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchPopularSeriesEvent value)? fetchPopularSeries,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PopularSeriesEventCopyWith<$Res> {
  factory $PopularSeriesEventCopyWith(
    PopularSeriesEvent value,
    $Res Function(PopularSeriesEvent) then,
  ) = _$PopularSeriesEventCopyWithImpl<$Res, PopularSeriesEvent>;
}

/// @nodoc
class _$PopularSeriesEventCopyWithImpl<$Res, $Val extends PopularSeriesEvent>
    implements $PopularSeriesEventCopyWith<$Res> {
  _$PopularSeriesEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PopularSeriesEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$FetchPopularSeriesEventImplCopyWith<$Res> {
  factory _$$FetchPopularSeriesEventImplCopyWith(
    _$FetchPopularSeriesEventImpl value,
    $Res Function(_$FetchPopularSeriesEventImpl) then,
  ) = __$$FetchPopularSeriesEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FetchPopularSeriesEventImplCopyWithImpl<$Res>
    extends
        _$PopularSeriesEventCopyWithImpl<$Res, _$FetchPopularSeriesEventImpl>
    implements _$$FetchPopularSeriesEventImplCopyWith<$Res> {
  __$$FetchPopularSeriesEventImplCopyWithImpl(
    _$FetchPopularSeriesEventImpl _value,
    $Res Function(_$FetchPopularSeriesEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PopularSeriesEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$FetchPopularSeriesEventImpl implements FetchPopularSeriesEvent {
  const _$FetchPopularSeriesEventImpl();

  @override
  String toString() {
    return 'PopularSeriesEvent.fetchPopularSeries()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchPopularSeriesEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchPopularSeries,
  }) {
    return fetchPopularSeries();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchPopularSeries,
  }) {
    return fetchPopularSeries?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchPopularSeries,
    required TResult orElse(),
  }) {
    if (fetchPopularSeries != null) {
      return fetchPopularSeries();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchPopularSeriesEvent value) fetchPopularSeries,
  }) {
    return fetchPopularSeries(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchPopularSeriesEvent value)? fetchPopularSeries,
  }) {
    return fetchPopularSeries?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchPopularSeriesEvent value)? fetchPopularSeries,
    required TResult orElse(),
  }) {
    if (fetchPopularSeries != null) {
      return fetchPopularSeries(this);
    }
    return orElse();
  }
}

abstract class FetchPopularSeriesEvent implements PopularSeriesEvent {
  const factory FetchPopularSeriesEvent() = _$FetchPopularSeriesEventImpl;
}
