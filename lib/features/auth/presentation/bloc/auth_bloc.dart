import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:malshy/core/utils/key_value_storage_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

class AuthStreamScope extends InheritedNotifier<AuthStream> {
  AuthStreamScope({super.key, required super.child}) : super(notifier: AuthStream(GetIt.I.get<AuthBloc>().stream));

  static AuthStream of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AuthStreamScope>()!.notifier!;
}

class AuthStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;

  AuthStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  bool isLoggedIn() => GetIt.I.get<AuthBloc>().state.isLoggedIn;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState(isLoggedIn: false)) {
    on<AuthEvent>(
      (event, emit) async {
        await event.map(
          logIn: (_LogIn e) => _logIn(e, emit),
          checkIfLoggedIn: (_CheckIfLoggedIn e) async => await _checkIfLoggedIn(e, emit),
          logOut: (_LogOut e) => _logOut(e, emit),
        );
      },
    );
  }

  _logIn(AuthEvent event, Emitter<AuthState> emit) {
    emit(state.copyWith(isLoggedIn: true));
  }

  _checkIfLoggedIn(AuthEvent event, Emitter<AuthState> emit) async {
    final token = await GetIt.I.get<KeyValueStorageService>().getAccessToken();
    emit(state.copyWith(isLoggedIn: token != null));
  }

  _logOut(AuthEvent event, Emitter<AuthState> emit) {
    emit(state.copyWith(isLoggedIn: false));
  }
}
