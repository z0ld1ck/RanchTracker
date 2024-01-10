import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:malshy/core/utils/data_state.dart';
import 'package:malshy/features/auth/domain/usecases/register_usecase.dart';

part 'registration_event.dart';
part 'registration_state.dart';
part 'registration_bloc.freezed.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final _registerUsecase = GetIt.I.get<RegisterUsecase>();

  RegistrationBloc()
      : super(RegistrationState(
          status: RegistrationStatus.initial,
          firstName: null,
          lastName: null,
          thirdName: null,
          phone: null,
          password: null,
        )) {
    on<_GetSMScode>(_getSMScode);
    on<_Register>(_register);
  }

  Future<void> _register(_Register event, emit) async {
    emit(state.copyWith(status: RegistrationStatus.loading));
    final result = await _registerUsecase(
      params: {
        'phone': state.phone,
        'password': event.password,
        'first_name': state.firstName,
        'last_name': state.lastName,
        'third_name': state.thirdName,
      },
    );
    if (result is DataSuccess) {
      emit(state.copyWith(status: RegistrationStatus.success));
    }

    if (result is DataFailed) {
      emit(state.copyWith(status: RegistrationStatus.failed));
    }
  }

  FutureOr<void> _getSMScode(_GetSMScode event, emit) {
    // пока что просто меняет [firstName], [lastName], [thirdName] и [phone] в [RegistrationState]
    emit(
      state.copyWith(
          firstName: event.firstName, lastName: event.lastName, thirdName: event.thirdName, phone: event.phone),
    );
  }
}
