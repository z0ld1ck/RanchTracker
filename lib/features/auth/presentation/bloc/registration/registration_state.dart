part of 'registration_bloc.dart';

enum RegistrationStatus { initial, loading, success, failed }

@freezed
class RegistrationState with _$RegistrationState {
  const factory RegistrationState({
    required RegistrationStatus status,
    required String? firstName,
    required String? lastName,
    required String? thirdName,
    required String? phone,
    required String? password,
  }) = _RegistrationState;
}
