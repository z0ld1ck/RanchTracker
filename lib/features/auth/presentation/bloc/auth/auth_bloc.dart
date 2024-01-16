import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:malshy/core/utils/data_state.dart';
import 'package:malshy/core/utils/key_value_storage_service.dart';
import 'package:malshy/features/auth/data/models/user_model.dart';
import 'package:malshy/features/auth/domain/usecases/get_farm_id_usecase.dart';
import 'package:malshy/features/auth/domain/usecases/log_in_usecase.dart';

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

  AuthGlobalState authGlobalState() => GetIt.I.get<AuthBloc>().state.globalState;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _loginUsecase = GetIt.I.get<LoginUsecase>();
  final _getFarmIdUsecase = GetIt.I.get<GetFarmIdUsecase>();

  AuthBloc() : super(AuthState(globalState: AuthGlobalState.unknown, localState: AuthLocalState.unknown)) {
    on<AuthEvent>(
      (event, emit) async {
        await event.map(
          logIn: (_LogIn e) async => await _logIn(e, emit),
          checkIfLoggedIn: (_CheckIfLoggedIn e) async => await _checkIfLoggedIn(e, emit),
          logOut: (_LogOut e) => _logOut(e, emit),
        );
      },
    );
  }

  _logIn(_LogIn event, Emitter<AuthState> emit) async {
    emit(state.copyWith(localState: AuthLocalState.loading));
    final DataState<UserModel> result =
        await _loginUsecase.call(params: {'phone': event.phone, 'password': event.password});
    if (result is DataSuccess && result.data != null) {
      // записывает UserModel и password в KeyValueStorageService
      GetIt.I.get<KeyValueStorageService>().setUserModel(result.data!);
      GetIt.I.get<KeyValueStorageService>().setAuthPassword(event.password);

      emit(AuthState(globalState: AuthGlobalState.authenticated, localState: AuthLocalState.success));
    }

    if (result is DataFailed) {
      emit(AuthState(globalState: AuthGlobalState.unauthenticated, localState: AuthLocalState.failed));
    }

    final farmIdResult = await _getFarmIdUsecase();

    if (farmIdResult is DataSuccess && farmIdResult.data != null) {
      GetIt.I.get<KeyValueStorageService>().setFarmId(farmIdResult.data!);
    }
  }

  _checkIfLoggedIn(AuthEvent event, Emitter<AuthState> emit) async {
    final token = await GetIt.I.get<KeyValueStorageService>().getAccessToken();
    emit(AuthState(
      globalState: token != null ? AuthGlobalState.authenticated : AuthGlobalState.unauthenticated,
      localState: AuthLocalState.success,
    ));
    // splash будет стоять пока не узнаем есть ли accessToken
    FlutterNativeSplash.remove();
  }

  _logOut(AuthEvent event, Emitter<AuthState> emit) {
    GetIt.I.get<KeyValueStorageService>().resetKeys();

    emit(AuthState(
      globalState: AuthGlobalState.unauthenticated,
      localState: AuthLocalState.unknown,
    ));
  }
}
