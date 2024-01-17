import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:malshy/core/utils/data_state.dart';
import 'package:malshy/core/utils/key_value_storage_service.dart';
import 'package:malshy/features/livestock/data/models/livestock_model.dart';
import 'package:malshy/features/livestock/domain/usecases/create_livestock_usecase.dart';
import 'package:malshy/injection_container.dart';

part 'add_livestock_event.dart';
part 'add_livestock_state.dart';
part 'add_livestock_bloc.freezed.dart';

class AddLivestockBloc extends Bloc<AddLivestockEvent, AddLivestockState> {
  final CreateLiveStockUseCase _createLiveStockUseCase = sl();

  AddLivestockBloc()
      : super(
          AddLivestockState(status: AddLivestockStateStatus.initial),
        ) {
    on<_CreateLivestock>(_createLivestock);
  }

  _createLivestock(_CreateLivestock event, Emitter<AddLivestockState> emit) async {
    emit(AddLivestockState(status: AddLivestockStateStatus.loading));

    final data = await _createLiveStockUseCase.call(
      params: LivestockModel(
        createdAt: null,
        id: 0,
        rfid: event.rfid,
        nickname: event.nickname,
        birthday: event.birthday,
        type: event.type,
        breed: event.breed,
        sex: event.sex,
        age: event.age,
        weight: event.weight,
        additionMethod: event.additionMethod,
        motherRfid: event.motherRfid,
        fatherRfid: event.fatherRfid,
        farmId: GetIt.I.get<KeyValueStorageService>().getFarmId() ?? 0,
        photos: [
          for (final photo in event.images) Photo(id: 0, livestockId: 0, photo: photo.path),
        ],
        status: null,
      ),
    );
    if (data is DataSuccess) {
      emit(AddLivestockState(status: AddLivestockStateStatus.success));
    }

    if (data is DataFailed) {
      emit(AddLivestockState(status: AddLivestockStateStatus.error));
    }
  }
}
