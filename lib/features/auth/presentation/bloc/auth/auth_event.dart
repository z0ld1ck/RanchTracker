part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.logIn({
    required String phone,
    required String password,
  }) = _LogIn;

  const factory AuthEvent.checkIfLoggedIn() = _CheckIfLoggedIn;

  const factory AuthEvent.logOut() = _LogOut;
}
