// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fav_movie_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$FavMovieEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchFavMovies,
    required TResult Function(Result movie) addFavMovie,
    required TResult Function(String movieId) removeFavMovie,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchFavMovies,
    TResult? Function(Result movie)? addFavMovie,
    TResult? Function(String movieId)? removeFavMovie,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchFavMovies,
    TResult Function(Result movie)? addFavMovie,
    TResult Function(String movieId)? removeFavMovie,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchFavMovies value) fetchFavMovies,
    required TResult Function(AddFavMovie value) addFavMovie,
    required TResult Function(RemoveFavMovie value) removeFavMovie,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchFavMovies value)? fetchFavMovies,
    TResult? Function(AddFavMovie value)? addFavMovie,
    TResult? Function(RemoveFavMovie value)? removeFavMovie,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchFavMovies value)? fetchFavMovies,
    TResult Function(AddFavMovie value)? addFavMovie,
    TResult Function(RemoveFavMovie value)? removeFavMovie,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavMovieEventCopyWith<$Res> {
  factory $FavMovieEventCopyWith(
    FavMovieEvent value,
    $Res Function(FavMovieEvent) then,
  ) = _$FavMovieEventCopyWithImpl<$Res, FavMovieEvent>;
}

/// @nodoc
class _$FavMovieEventCopyWithImpl<$Res, $Val extends FavMovieEvent>
    implements $FavMovieEventCopyWith<$Res> {
  _$FavMovieEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FavMovieEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$FetchFavMoviesImplCopyWith<$Res> {
  factory _$$FetchFavMoviesImplCopyWith(
    _$FetchFavMoviesImpl value,
    $Res Function(_$FetchFavMoviesImpl) then,
  ) = __$$FetchFavMoviesImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FetchFavMoviesImplCopyWithImpl<$Res>
    extends _$FavMovieEventCopyWithImpl<$Res, _$FetchFavMoviesImpl>
    implements _$$FetchFavMoviesImplCopyWith<$Res> {
  __$$FetchFavMoviesImplCopyWithImpl(
    _$FetchFavMoviesImpl _value,
    $Res Function(_$FetchFavMoviesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FavMovieEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$FetchFavMoviesImpl implements FetchFavMovies {
  const _$FetchFavMoviesImpl();

  @override
  String toString() {
    return 'FavMovieEvent.fetchFavMovies()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FetchFavMoviesImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchFavMovies,
    required TResult Function(Result movie) addFavMovie,
    required TResult Function(String movieId) removeFavMovie,
  }) {
    return fetchFavMovies();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchFavMovies,
    TResult? Function(Result movie)? addFavMovie,
    TResult? Function(String movieId)? removeFavMovie,
  }) {
    return fetchFavMovies?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchFavMovies,
    TResult Function(Result movie)? addFavMovie,
    TResult Function(String movieId)? removeFavMovie,
    required TResult orElse(),
  }) {
    if (fetchFavMovies != null) {
      return fetchFavMovies();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchFavMovies value) fetchFavMovies,
    required TResult Function(AddFavMovie value) addFavMovie,
    required TResult Function(RemoveFavMovie value) removeFavMovie,
  }) {
    return fetchFavMovies(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchFavMovies value)? fetchFavMovies,
    TResult? Function(AddFavMovie value)? addFavMovie,
    TResult? Function(RemoveFavMovie value)? removeFavMovie,
  }) {
    return fetchFavMovies?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchFavMovies value)? fetchFavMovies,
    TResult Function(AddFavMovie value)? addFavMovie,
    TResult Function(RemoveFavMovie value)? removeFavMovie,
    required TResult orElse(),
  }) {
    if (fetchFavMovies != null) {
      return fetchFavMovies(this);
    }
    return orElse();
  }
}

abstract class FetchFavMovies implements FavMovieEvent {
  const factory FetchFavMovies() = _$FetchFavMoviesImpl;
}

/// @nodoc
abstract class _$$AddFavMovieImplCopyWith<$Res> {
  factory _$$AddFavMovieImplCopyWith(
    _$AddFavMovieImpl value,
    $Res Function(_$AddFavMovieImpl) then,
  ) = __$$AddFavMovieImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Result movie});
}

/// @nodoc
class __$$AddFavMovieImplCopyWithImpl<$Res>
    extends _$FavMovieEventCopyWithImpl<$Res, _$AddFavMovieImpl>
    implements _$$AddFavMovieImplCopyWith<$Res> {
  __$$AddFavMovieImplCopyWithImpl(
    _$AddFavMovieImpl _value,
    $Res Function(_$AddFavMovieImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FavMovieEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? movie = null}) {
    return _then(
      _$AddFavMovieImpl(
        null == movie
            ? _value.movie
            : movie // ignore: cast_nullable_to_non_nullable
                  as Result,
      ),
    );
  }
}

/// @nodoc

class _$AddFavMovieImpl implements AddFavMovie {
  const _$AddFavMovieImpl(this.movie);

  @override
  final Result movie;

  @override
  String toString() {
    return 'FavMovieEvent.addFavMovie(movie: $movie)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddFavMovieImpl &&
            (identical(other.movie, movie) || other.movie == movie));
  }

  @override
  int get hashCode => Object.hash(runtimeType, movie);

  /// Create a copy of FavMovieEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddFavMovieImplCopyWith<_$AddFavMovieImpl> get copyWith =>
      __$$AddFavMovieImplCopyWithImpl<_$AddFavMovieImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchFavMovies,
    required TResult Function(Result movie) addFavMovie,
    required TResult Function(String movieId) removeFavMovie,
  }) {
    return addFavMovie(movie);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchFavMovies,
    TResult? Function(Result movie)? addFavMovie,
    TResult? Function(String movieId)? removeFavMovie,
  }) {
    return addFavMovie?.call(movie);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchFavMovies,
    TResult Function(Result movie)? addFavMovie,
    TResult Function(String movieId)? removeFavMovie,
    required TResult orElse(),
  }) {
    if (addFavMovie != null) {
      return addFavMovie(movie);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchFavMovies value) fetchFavMovies,
    required TResult Function(AddFavMovie value) addFavMovie,
    required TResult Function(RemoveFavMovie value) removeFavMovie,
  }) {
    return addFavMovie(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchFavMovies value)? fetchFavMovies,
    TResult? Function(AddFavMovie value)? addFavMovie,
    TResult? Function(RemoveFavMovie value)? removeFavMovie,
  }) {
    return addFavMovie?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchFavMovies value)? fetchFavMovies,
    TResult Function(AddFavMovie value)? addFavMovie,
    TResult Function(RemoveFavMovie value)? removeFavMovie,
    required TResult orElse(),
  }) {
    if (addFavMovie != null) {
      return addFavMovie(this);
    }
    return orElse();
  }
}

abstract class AddFavMovie implements FavMovieEvent {
  const factory AddFavMovie(final Result movie) = _$AddFavMovieImpl;

  Result get movie;

  /// Create a copy of FavMovieEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddFavMovieImplCopyWith<_$AddFavMovieImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RemoveFavMovieImplCopyWith<$Res> {
  factory _$$RemoveFavMovieImplCopyWith(
    _$RemoveFavMovieImpl value,
    $Res Function(_$RemoveFavMovieImpl) then,
  ) = __$$RemoveFavMovieImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String movieId});
}

/// @nodoc
class __$$RemoveFavMovieImplCopyWithImpl<$Res>
    extends _$FavMovieEventCopyWithImpl<$Res, _$RemoveFavMovieImpl>
    implements _$$RemoveFavMovieImplCopyWith<$Res> {
  __$$RemoveFavMovieImplCopyWithImpl(
    _$RemoveFavMovieImpl _value,
    $Res Function(_$RemoveFavMovieImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FavMovieEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? movieId = null}) {
    return _then(
      _$RemoveFavMovieImpl(
        null == movieId
            ? _value.movieId
            : movieId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$RemoveFavMovieImpl implements RemoveFavMovie {
  const _$RemoveFavMovieImpl(this.movieId);

  @override
  final String movieId;

  @override
  String toString() {
    return 'FavMovieEvent.removeFavMovie(movieId: $movieId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoveFavMovieImpl &&
            (identical(other.movieId, movieId) || other.movieId == movieId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, movieId);

  /// Create a copy of FavMovieEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RemoveFavMovieImplCopyWith<_$RemoveFavMovieImpl> get copyWith =>
      __$$RemoveFavMovieImplCopyWithImpl<_$RemoveFavMovieImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchFavMovies,
    required TResult Function(Result movie) addFavMovie,
    required TResult Function(String movieId) removeFavMovie,
  }) {
    return removeFavMovie(movieId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchFavMovies,
    TResult? Function(Result movie)? addFavMovie,
    TResult? Function(String movieId)? removeFavMovie,
  }) {
    return removeFavMovie?.call(movieId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchFavMovies,
    TResult Function(Result movie)? addFavMovie,
    TResult Function(String movieId)? removeFavMovie,
    required TResult orElse(),
  }) {
    if (removeFavMovie != null) {
      return removeFavMovie(movieId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchFavMovies value) fetchFavMovies,
    required TResult Function(AddFavMovie value) addFavMovie,
    required TResult Function(RemoveFavMovie value) removeFavMovie,
  }) {
    return removeFavMovie(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchFavMovies value)? fetchFavMovies,
    TResult? Function(AddFavMovie value)? addFavMovie,
    TResult? Function(RemoveFavMovie value)? removeFavMovie,
  }) {
    return removeFavMovie?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchFavMovies value)? fetchFavMovies,
    TResult Function(AddFavMovie value)? addFavMovie,
    TResult Function(RemoveFavMovie value)? removeFavMovie,
    required TResult orElse(),
  }) {
    if (removeFavMovie != null) {
      return removeFavMovie(this);
    }
    return orElse();
  }
}

abstract class RemoveFavMovie implements FavMovieEvent {
  const factory RemoveFavMovie(final String movieId) = _$RemoveFavMovieImpl;

  String get movieId;

  /// Create a copy of FavMovieEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RemoveFavMovieImplCopyWith<_$RemoveFavMovieImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
