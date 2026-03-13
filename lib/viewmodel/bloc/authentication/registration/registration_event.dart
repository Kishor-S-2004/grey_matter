import 'package:freezed_annotation/freezed_annotation.dart';

part 'registration_event.freezed.dart';

@freezed
class RegistrationEvent with _$RegistrationEvent{
  const factory RegistrationEvent.registrationUser({
    required String userName,
  required String email,
  required String password
}) = RegistrationUser;
}