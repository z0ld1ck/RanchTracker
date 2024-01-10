part of 'registration_bloc.dart';

@freezed
class RegistrationEvent with _$RegistrationEvent {
  const factory RegistrationEvent.getSMScode({
    required String firstName,
    required String lastName,
    required String thirdName,
    required String phone,
  }) = _GetSMScode;

  const factory RegistrationEvent.register({required String password}) = _Register;
}
