import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState{
  const factory LoginState.initial() = _Intial;
  const factory LoginState.loading() = _Loading;
  const factory LoginState.loaded() = _Loaded;
  const factory LoginState.error(String errorMessage) = _Error;
}