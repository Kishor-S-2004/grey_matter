import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:grey_matter/model/users/userDetails_model.dart';

part 'userdetails_state.freezed.dart';

@freezed
class UserdetailsState with _$UserdetailsState{
  const factory UserdetailsState.initial() = UserDetailsInitial;
  const factory UserdetailsState.loading() = UserDetailsLoading;
  const factory UserdetailsState.loaded(UserdetailsModel userData) = UserDetailsLoaded;
  const factory UserdetailsState.error(String error) = UserDetailsError;
}