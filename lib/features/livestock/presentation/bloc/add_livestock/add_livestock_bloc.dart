import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:malshy/core/utils/data_state.dart';
import 'package:malshy/features/livestock/data/models/get_livestock_model.dart';
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

  _createLivestock(_CreateLivestock value, Emitter<AddLivestockState> emit) async {
    emit(state.copyWith(status: AddLivestockStateStatus.loading)
        // AddLivestockState(status: AddLivestockStateStatus.loading),
        );

    final data = await _createLiveStockUseCase.call(
      params: LivestockModel(
        createdAt: null,
        id: 0,
        rfid: 'rfid',
        nickname: 'nickname',
        birthday: DateTime.now(),
        type: 0,
        breed: 0,
        sex: 0,
        age: 0,
        weight: 0,
        additionMethod: 0,
        motherRfid: 'motherRfid',
        fatherRfid: 'fatherRfid',
        farmId: 0,
        photos: [],
        status: null,
      ),
    );
    if (data is DataSuccess) {
      emit(state.copyWith(status: AddLivestockStateStatus.success));
      // emit(AddLivestockState(status: AddLivestockStateStatus.success));
    }

    if (data is DataFailed) {
      emit(state.copyWith(status: AddLivestockStateStatus.error));
      // emit(AddLivestockState(status: AddLivestockStateStatus.error));
    }
  }
}
