// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'moviereviews_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$MovieReviewsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int movieId) fetchReview,
    required TResult Function(MovieReviewResults result) addReview,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int movieId)? fetchReview,
    TResult? Function(MovieReviewResults result)? addReview,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int movieId)? fetchReview,
    TResult Function(MovieReviewResults result)? addReview,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchReviews value) fetchReview,
    required TResult Function(MovieReviews value) addReview,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchReviews value)? fetchReview,
    TResult? Function(MovieReviews value)? addReview,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchReviews value)? fetchReview,
    TResult Function(MovieReviews value)? addReview,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MovieReviewsEventCopyWith<$Res> {
  factory $MovieReviewsEventCopyWith(
    MovieReviewsEvent value,
    $Res Function(MovieReviewsEvent) then,
  ) = _$MovieReviewsEventCopyWithImpl<$Res, MovieReviewsEvent>;
}

/// @nodoc
class _$MovieReviewsEventCopyWithImpl<$Res, $Val extends MovieReviewsEvent>
    implements $MovieReviewsEventCopyWith<$Res> {
  _$MovieReviewsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MovieReviewsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$FetchReviewsImplCopyWith<$Res> {
  factory _$$FetchReviewsImplCopyWith(
    _$FetchReviewsImpl value,
    $Res Function(_$FetchReviewsImpl) then,
  ) = __$$FetchReviewsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int movieId});
}

/// @nodoc
class __$$FetchReviewsImplCopyWithImpl<$Res>
    extends _$MovieReviewsEventCopyWithImpl<$Res, _$FetchReviewsImpl>
    implements _$$FetchReviewsImplCopyWith<$Res> {
  __$$FetchReviewsImplCopyWithImpl(
    _$FetchReviewsImpl _value,
    $Res Function(_$FetchReviewsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MovieReviewsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? movieId = null}) {
    return _then(
      _$FetchReviewsImpl(
        null == movieId
            ? _value.movieId
            : movieId // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$FetchReviewsImpl implements FetchReviews {
  const _$FetchReviewsImpl(this.movieId);

  @override
  final int movieId;

  @override
  String toString() {
    return 'MovieReviewsEvent.fetchReview(movieId: $movieId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchReviewsImpl &&
            (identical(other.movieId, movieId) || other.movieId == movieId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, movieId);

  /// Create a copy of MovieReviewsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchReviewsImplCopyWith<_$FetchReviewsImpl> get copyWith =>
      __$$FetchReviewsImplCopyWithImpl<_$FetchReviewsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int movieId) fetchReview,
    required TResult Function(MovieReviewResults result) addReview,
  }) {
    return fetchReview(movieId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int movieId)? fetchReview,
    TResult? Function(MovieReviewResults result)? addReview,
  }) {
    return fetchReview?.call(movieId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int movieId)? fetchReview,
    TResult Function(MovieReviewResults result)? addReview,
    required TResult orElse(),
  }) {
    if (fetchReview != null) {
      return fetchReview(movieId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchReviews value) fetchReview,
    required TResult Function(MovieReviews value) addReview,
  }) {
    return fetchReview(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchReviews value)? fetchReview,
    TResult? Function(MovieReviews value)? addReview,
  }) {
    return fetchReview?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchReviews value)? fetchReview,
    TResult Function(MovieReviews value)? addReview,
    required TResult orElse(),
  }) {
    if (fetchReview != null) {
      return fetchReview(this);
    }
    return orElse();
  }
}

abstract class FetchReviews implements MovieReviewsEvent {
  const factory FetchReviews(final int movieId) = _$FetchReviewsImpl;

  int get movieId;

  /// Create a copy of MovieReviewsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FetchReviewsImplCopyWith<_$FetchReviewsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MovieReviewsImplCopyWith<$Res> {
  factory _$$MovieReviewsImplCopyWith(
    _$MovieReviewsImpl value,
    $Res Function(_$MovieReviewsImpl) then,
  ) = __$$MovieReviewsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({MovieReviewResults result});
}

/// @nodoc
class __$$MovieReviewsImplCopyWithImpl<$Res>
    extends _$MovieReviewsEventCopyWithImpl<$Res, _$MovieReviewsImpl>
    implements _$$MovieReviewsImplCopyWith<$Res> {
  __$$MovieReviewsImplCopyWithImpl(
    _$MovieReviewsImpl _value,
    $Res Function(_$MovieReviewsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MovieReviewsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? result = null}) {
    return _then(
      _$MovieReviewsImpl(
        null == result
            ? _value.result
            : result // ignore: cast_nullable_to_non_nullable
                  as MovieReviewResults,
      ),
    );
  }
}

/// @nodoc

class _$MovieReviewsImpl implements MovieReviews {
  const _$MovieReviewsImpl(this.result);

  @override
  final MovieReviewResults result;

  @override
  String toString() {
    return 'MovieReviewsEvent.addReview(result: $result)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MovieReviewsImpl &&
            (identical(other.result, result) || other.result == result));
  }

  @override
  int get hashCode => Object.hash(runtimeType, result);

  /// Create a copy of MovieReviewsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MovieReviewsImplCopyWith<_$MovieReviewsImpl> get copyWith =>
      __$$MovieReviewsImplCopyWithImpl<_$MovieReviewsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int movieId) fetchReview,
    required TResult Function(MovieReviewResults result) addReview,
  }) {
    return addReview(result);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int movieId)? fetchReview,
    TResult? Function(MovieReviewResults result)? addReview,
  }) {
    return addReview?.call(result);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int movieId)? fetchReview,
    TResult Function(MovieReviewResults result)? addReview,
    required TResult orElse(),
  }) {
    if (addReview != null) {
      return addReview(result);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchReviews value) fetchReview,
    required TResult Function(MovieReviews value) addReview,
  }) {
    return addReview(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchReviews value)? fetchReview,
    TResult? Function(MovieReviews value)? addReview,
  }) {
    return addReview?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchReviews value)? fetchReview,
    TResult Function(MovieReviews value)? addReview,
    required TResult orElse(),
  }) {
    if (addReview != null) {
      return addReview(this);
    }
    return orElse();
  }
}

abstract class MovieReviews implements MovieReviewsEvent {
  const factory MovieReviews(final MovieReviewResults result) =
      _$MovieReviewsImpl;

  MovieReviewResults get result;

  /// Create a copy of MovieReviewsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MovieReviewsImplCopyWith<_$MovieReviewsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
