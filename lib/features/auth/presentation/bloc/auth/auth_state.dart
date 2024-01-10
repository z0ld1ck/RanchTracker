part of 'auth_bloc.dart';

enum AuthGlobalState { unknown, authenticated, unauthenticated }

enum AuthLocalState { unknown, loading, success, failed }

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    // нужен для GoRouter redirect-а
    required AuthGlobalState globalState,
    // для того что бы показывать лоадеры и тосты
    required AuthLocalState localState,
  }) = _AuthState;
}
