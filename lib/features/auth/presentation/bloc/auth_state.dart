part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({required bool isLoggedIn}) = _AuthState;
}
