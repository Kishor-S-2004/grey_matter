// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recommended_series_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$RecommendedSeriesEvent {
  int get seriesId => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int seriesId) fetchRecommendedSeries,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int seriesId)? fetchRecommendedSeries,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int seriesId)? fetchRecommendedSeries,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RecommendedSeries value) fetchRecommendedSeries,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RecommendedSeries value)? fetchRecommendedSeries,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RecommendedSeries value)? fetchRecommendedSeries,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of RecommendedSeriesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecommendedSeriesEventCopyWith<RecommendedSeriesEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecommendedSeriesEventCopyWith<$Res> {
  factory $RecommendedSeriesEventCopyWith(
    RecommendedSeriesEvent value,
    $Res Function(RecommendedSeriesEvent) then,
  ) = _$RecommendedSeriesEventCopyWithImpl<$Res, RecommendedSeriesEvent>;
  @useResult
  $Res call({int seriesId});
}

/// @nodoc
class _$RecommendedSeriesEventCopyWithImpl<
  $Res,
  $Val extends RecommendedSeriesEvent
>
    implements $RecommendedSeriesEventCopyWith<$Res> {
  _$RecommendedSeriesEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecommendedSeriesEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? seriesId = null}) {
    return _then(
      _value.copyWith(
            seriesId: null == seriesId
                ? _value.seriesId
                : seriesId // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RecommendedSeriesImplCopyWith<$Res>
    implements $RecommendedSeriesEventCopyWith<$Res> {
  factory _$$RecommendedSeriesImplCopyWith(
    _$RecommendedSeriesImpl value,
    $Res Function(_$RecommendedSeriesImpl) then,
  ) = __$$RecommendedSeriesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int seriesId});
}

/// @nodoc
class __$$RecommendedSeriesImplCopyWithImpl<$Res>
    extends _$RecommendedSeriesEventCopyWithImpl<$Res, _$RecommendedSeriesImpl>
    implements _$$RecommendedSeriesImplCopyWith<$Res> {
  __$$RecommendedSeriesImplCopyWithImpl(
    _$RecommendedSeriesImpl _value,
    $Res Function(_$RecommendedSeriesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RecommendedSeriesEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? seriesId = null}) {
    return _then(
      _$RecommendedSeriesImpl(
        null == seriesId
            ? _value.seriesId
            : seriesId // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$RecommendedSeriesImpl implements RecommendedSeries {
  const _$RecommendedSeriesImpl(this.seriesId);

  @override
  final int seriesId;

  @override
  String toString() {
    return 'RecommendedSeriesEvent.fetchRecommendedSeries(seriesId: $seriesId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecommendedSeriesImpl &&
            (identical(other.seriesId, seriesId) ||
                other.seriesId == seriesId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, seriesId);

  /// Create a copy of RecommendedSeriesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecommendedSeriesImplCopyWith<_$RecommendedSeriesImpl> get copyWith =>
      __$$RecommendedSeriesImplCopyWithImpl<_$RecommendedSeriesImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int seriesId) fetchRecommendedSeries,
  }) {
    return fetchRecommendedSeries(seriesId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int seriesId)? fetchRecommendedSeries,
  }) {
    return fetchRecommendedSeries?.call(seriesId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int seriesId)? fetchRecommendedSeries,
    required TResult orElse(),
  }) {
    if (fetchRecommendedSeries != null) {
      return fetchRecommendedSeries(seriesId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RecommendedSeries value) fetchRecommendedSeries,
  }) {
    return fetchRecommendedSeries(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RecommendedSeries value)? fetchRecommendedSeries,
  }) {
    return fetchRecommendedSeries?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RecommendedSeries value)? fetchRecommendedSeries,
    required TResult orElse(),
  }) {
    if (fetchRecommendedSeries != null) {
      return fetchRecommendedSeries(this);
    }
    return orElse();
  }
}

abstract class RecommendedSeries implements RecommendedSeriesEvent {
  const factory RecommendedSeries(final int seriesId) = _$RecommendedSeriesImpl;

  @override
  int get seriesId;

  /// Create a copy of RecommendedSeriesEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecommendedSeriesImplCopyWith<_$RecommendedSeriesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
