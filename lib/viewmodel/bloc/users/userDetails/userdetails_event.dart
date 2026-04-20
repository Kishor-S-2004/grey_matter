import 'package:freezed_annotation/freezed_annotation.dart';

part 'userdetails_event.freezed.dart';

@freezed
class UserdetailsEvent with _$UserdetailsEvent{
  const factory UserdetailsEvent.userDetails(String uid)= UserDetails;
}