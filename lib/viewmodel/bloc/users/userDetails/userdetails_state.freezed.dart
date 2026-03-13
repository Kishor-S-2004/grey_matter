// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'userdetails_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$UserdetailsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(UserdetailsModel userData) loaded,
    required TResult Function(String error) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(UserdetailsModel userData)? loaded,
    TResult? Function(String error)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(UserdetailsModel userData)? loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserDetailsInitial value) initial,
    required TResult Function(UserDetailsLoading value) loading,
    required TResult Function(UserDetailsLoaded value) loaded,
    required TResult Function(UserDetailsError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UserDetailsInitial value)? initial,
    TResult? Function(UserDetailsLoading value)? loading,
    TResult? Function(UserDetailsLoaded value)? loaded,
    TResult? Function(UserDetailsError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserDetailsInitial value)? initial,
    TResult Function(UserDetailsLoading value)? loading,
    TResult Function(UserDetailsLoaded value)? loaded,
    TResult Function(UserDetailsError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserdetailsStateCopyWith<$Res> {
  factory $UserdetailsStateCopyWith(
    UserdetailsState value,
    $Res Function(UserdetailsState) then,
  ) = _$UserdetailsStateCopyWithImpl<$Res, UserdetailsState>;
}

/// @nodoc
class _$UserdetailsStateCopyWithImpl<$Res, $Val extends UserdetailsState>
    implements $UserdetailsStateCopyWith<$Res> {
  _$UserdetailsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserdetailsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$UserDetailsInitialImplCopyWith<$Res> {
  factory _$$UserDetailsInitialImplCopyWith(
    _$UserDetailsInitialImpl value,
    $Res Function(_$UserDetailsInitialImpl) then,
  ) = __$$UserDetailsInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UserDetailsInitialImplCopyWithImpl<$Res>
    extends _$UserdetailsStateCopyWithImpl<$Res, _$UserDetailsInitialImpl>
    implements _$$UserDetailsInitialImplCopyWith<$Res> {
  __$$UserDetailsInitialImplCopyWithImpl(
    _$UserDetailsInitialImpl _value,
    $Res Function(_$UserDetailsInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserdetailsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$UserDetailsInitialImpl implements UserDetailsInitial {
  const _$UserDetailsInitialImpl();

  @override
  String toString() {
    return 'UserdetailsState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UserDetailsInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(UserdetailsModel userData) loaded,
    required TResult Function(String error) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(UserdetailsModel userData)? loaded,
    TResult? Function(String error)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(UserdetailsModel userData)? loaded,
    TResult Function(String error)? error,
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
    required TResult Function(UserDetailsInitial value) initial,
    required TResult Function(UserDetailsLoading value) loading,
    required TResult Function(UserDetailsLoaded value) loaded,
    required TResult Function(UserDetailsError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UserDetailsInitial value)? initial,
    TResult? Function(UserDetailsLoading value)? loading,
    TResult? Function(UserDetailsLoaded value)? loaded,
    TResult? Function(UserDetailsError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserDetailsInitial value)? initial,
    TResult Function(UserDetailsLoading value)? loading,
    TResult Function(UserDetailsLoaded value)? loaded,
    TResult Function(UserDetailsError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class UserDetailsInitial implements UserdetailsState {
  const factory UserDetailsInitial() = _$UserDetailsInitialImpl;
}

/// @nodoc
abstract class _$$UserDetailsLoadingImplCopyWith<$Res> {
  factory _$$UserDetailsLoadingImplCopyWith(
    _$UserDetailsLoadingImpl value,
    $Res Function(_$UserDetailsLoadingImpl) then,
  ) = __$$UserDetailsLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UserDetailsLoadingImplCopyWithImpl<$Res>
    extends _$UserdetailsStateCopyWithImpl<$Res, _$UserDetailsLoadingImpl>
    implements _$$UserDetailsLoadingImplCopyWith<$Res> {
  __$$UserDetailsLoadingImplCopyWithImpl(
    _$UserDetailsLoadingImpl _value,
    $Res Function(_$UserDetailsLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserdetailsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$UserDetailsLoadingImpl implements UserDetailsLoading {
  const _$UserDetailsLoadingImpl();

  @override
  String toString() {
    return 'UserdetailsState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UserDetailsLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(UserdetailsModel userData) loaded,
    required TResult Function(String error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(UserdetailsModel userData)? loaded,
    TResult? Function(String error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(UserdetailsModel userData)? loaded,
    TResult Function(String error)? error,
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
    required TResult Function(UserDetailsInitial value) initial,
    required TResult Function(UserDetailsLoading value) loading,
    required TResult Function(UserDetailsLoaded value) loaded,
    required TResult Function(UserDetailsError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UserDetailsInitial value)? initial,
    TResult? Function(UserDetailsLoading value)? loading,
    TResult? Function(UserDetailsLoaded value)? loaded,
    TResult? Function(UserDetailsError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserDetailsInitial value)? initial,
    TResult Function(UserDetailsLoading value)? loading,
    TResult Function(UserDetailsLoaded value)? loaded,
    TResult Function(UserDetailsError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class UserDetailsLoading implements UserdetailsState {
  const factory UserDetailsLoading() = _$UserDetailsLoadingImpl;
}

/// @nodoc
abstract class _$$UserDetailsLoadedImplCopyWith<$Res> {
  factory _$$UserDetailsLoadedImplCopyWith(
    _$UserDetailsLoadedImpl value,
    $Res Function(_$UserDetailsLoadedImpl) then,
  ) = __$$UserDetailsLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({UserdetailsModel userData});
}

/// @nodoc
class __$$UserDetailsLoadedImplCopyWithImpl<$Res>
    extends _$UserdetailsStateCopyWithImpl<$Res, _$UserDetailsLoadedImpl>
    implements _$$UserDetailsLoadedImplCopyWith<$Res> {
  __$$UserDetailsLoadedImplCopyWithImpl(
    _$UserDetailsLoadedImpl _value,
    $Res Function(_$UserDetailsLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserdetailsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? userData = null}) {
    return _then(
      _$UserDetailsLoadedImpl(
        null == userData
            ? _value.userData
            : userData // ignore: cast_nullable_to_non_nullable
                  as UserdetailsModel,
      ),
    );
  }
}

/// @nodoc

class _$UserDetailsLoadedImpl implements UserDetailsLoaded {
  const _$UserDetailsLoadedImpl(this.userData);

  @override
  final UserdetailsModel userData;

  @override
  String toString() {
    return 'UserdetailsState.loaded(userData: $userData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserDetailsLoadedImpl &&
            (identical(other.userData, userData) ||
                other.userData == userData));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userData);

  /// Create a copy of UserdetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserDetailsLoadedImplCopyWith<_$UserDetailsLoadedImpl> get copyWith =>
      __$$UserDetailsLoadedImplCopyWithImpl<_$UserDetailsLoadedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(UserdetailsModel userData) loaded,
    required TResult Function(String error) error,
  }) {
    return loaded(userData);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(UserdetailsModel userData)? loaded,
    TResult? Function(String error)? error,
  }) {
    return loaded?.call(userData);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(UserdetailsModel userData)? loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(userData);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserDetailsInitial value) initial,
    required TResult Function(UserDetailsLoading value) loading,
    required TResult Function(UserDetailsLoaded value) loaded,
    required TResult Function(UserDetailsError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UserDetailsInitial value)? initial,
    TResult? Function(UserDetailsLoading value)? loading,
    TResult? Function(UserDetailsLoaded value)? loaded,
    TResult? Function(UserDetailsError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserDetailsInitial value)? initial,
    TResult Function(UserDetailsLoading value)? loading,
    TResult Function(UserDetailsLoaded value)? loaded,
    TResult Function(UserDetailsError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class UserDetailsLoaded implements UserdetailsState {
  const factory UserDetailsLoaded(final UserdetailsModel userData) =
      _$UserDetailsLoadedImpl;

  UserdetailsModel get userData;

  /// Create a copy of UserdetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserDetailsLoadedImplCopyWith<_$UserDetailsLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UserDetailsErrorImplCopyWith<$Res> {
  factory _$$UserDetailsErrorImplCopyWith(
    _$UserDetailsErrorImpl value,
    $Res Function(_$UserDetailsErrorImpl) then,
  ) = __$$UserDetailsErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$UserDetailsErrorImplCopyWithImpl<$Res>
    extends _$UserdetailsStateCopyWithImpl<$Res, _$UserDetailsErrorImpl>
    implements _$$UserDetailsErrorImplCopyWith<$Res> {
  __$$UserDetailsErrorImplCopyWithImpl(
    _$UserDetailsErrorImpl _value,
    $Res Function(_$UserDetailsErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserdetailsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? error = null}) {
    return _then(
      _$UserDetailsErrorImpl(
        null == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$UserDetailsErrorImpl implements UserDetailsError {
  const _$UserDetailsErrorImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'UserdetailsState.error(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserDetailsErrorImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of UserdetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserDetailsErrorImplCopyWith<_$UserDetailsErrorImpl> get copyWith =>
      __$$UserDetailsErrorImplCopyWithImpl<_$UserDetailsErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(UserdetailsModel userData) loaded,
    required TResult Function(String error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(UserdetailsModel userData)? loaded,
    TResult? Function(String error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(UserdetailsModel userData)? loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserDetailsInitial value) initial,
    required TResult Function(UserDetailsLoading value) loading,
    required TResult Function(UserDetailsLoaded value) loaded,
    required TResult Function(UserDetailsError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UserDetailsInitial value)? initial,
    TResult? Function(UserDetailsLoading value)? loading,
    TResult? Function(UserDetailsLoaded value)? loaded,
    TResult? Function(UserDetailsError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserDetailsInitial value)? initial,
    TResult Function(UserDetailsLoading value)? loading,
    TResult Function(UserDetailsLoaded value)? loaded,
    TResult Function(UserDetailsError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class UserDetailsError implements UserdetailsState {
  const factory UserDetailsError(final String error) = _$UserDetailsErrorImpl;

  String get error;

  /// Create a copy of UserdetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserDetailsErrorImplCopyWith<_$UserDetailsErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
