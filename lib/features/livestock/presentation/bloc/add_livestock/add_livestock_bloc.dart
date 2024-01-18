import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:malshy/core/utils/data_state.dart';
import 'package:malshy/core/utils/key_value_storage_service.dart';
import 'package:malshy/features/livestock/data/models/livestock_model.dart';
import 'package:malshy/features/livestock/domain/usecases/create_livestock_usecase.dart';
import 'package:malshy/features/livestock/domain/usecases/edit_livestock_usecase.dart';
import 'package:malshy/injection_container.dart';
import 'package:tuple/tuple.dart';

part 'add_livestock_event.dart';
part 'add_livestock_state.dart';
part 'add_livestock_bloc.freezed.dart';

mixin AddLivestockBloc on Bloc<LivestockEvent, LivestockState> {}

mixin EditLivestockBloc on Bloc<LivestockEvent, LivestockState> {}

class LivestockBloc extends Bloc<LivestockEvent, LivestockState> with AddLivestockBloc, EditLivestockBloc {
  final CreateLivestockUsecase _createLiveStockUseCase = sl();
  final EditLivestockUsecase _editLiveStockUseCase = sl();

  LivestockBloc()
      : super(
          LivestockState(status: LivestockStateStatus.initial),
        ) {
    on<_CreateLivestock>(_createLivestock);
    on<_EditLivestock>(_editLivestock);
  }

  _createLivestock(_CreateLivestock event, Emitter<LivestockState> emit) async {
    emit(LivestockState(status: LivestockStateStatus.loading));

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
      emit(LivestockState(status: LivestockStateStatus.success));
    }

    if (data is DataFailed) {
      emit(LivestockState(status: LivestockStateStatus.error));
    }
  }

  _editLivestock(_EditLivestock event, Emitter<LivestockState> emit) async {
    emit(LivestockState(status: LivestockStateStatus.loading));
    final data = await _editLiveStockUseCase.call(
      params: Tuple2(
        LivestockModel(
          id: event.livestockId,
          createdAt: null,
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
            for (final photo in event.newImages) Photo(id: 0, livestockId: 0, photo: photo.path),
          ],
          status: null,
        ),
        event.deletedImages,
      ),
    );
    if (data is DataSuccess) {
      emit(LivestockState(status: LivestockStateStatus.success));
    }

    if (data is DataFailed) {
      emit(LivestockState(status: LivestockStateStatus.error));
    }
  }
}
