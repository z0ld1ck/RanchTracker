import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:malshy/core/network/custom_exceptions.dart';
import 'package:malshy/core/utils/data_state.dart';
import 'package:malshy/features/livestock/domain/usecases/create_livestock_usecase.dart';
import 'package:malshy/features/livestock/domain/usecases/get_addition_type_usecase.dart';
import 'package:malshy/features/livestock/domain/usecases/get_types_breeds_usecase.dart';
import 'package:malshy/injection_container.dart';

import '../../../data/models/type_model.dart';

part 'add_livestock_event.dart';

part 'add_livestock_state.dart';

part 'add_livestock_bloc.freezed.dart';

class AddLivestockBloc extends Bloc<AddLivestockEvent, AddLivestockState> {
  final CreateLiveStockUseCase _createLiveStockUseCase = sl();
  final GetTypesAndBreedsUsecase _getTypeAndBreedUseCase = sl();
  final GetAdditionTypeUseCase _getAdditionTypeUseCase = sl();

  AddLivestockBloc()
      : super(AddLivestockState(status: AddLivestockStateStatus.loading)) {
    on<CreateLivestock>((event, emit) async {
      await _createLivestock(event, emit);
    });
    on<GetTypeAndBreed>((event, emit) async {
      await _getTypesAndBreeds(event, emit);
    });
    on<GetAdditionType>((event, emit) async {
      await _getAdditionType(event, emit);
    });
  }

  _createLivestock(
      CreateLivestock value, Emitter<AddLivestockState> emit) async {
    emit(
      AddLivestockState(status: AddLivestockStateStatus.loading),
    );

    final data = await _createLiveStockUseCase.call(params: {
      'rfid': 'RFID',
      'birthday': 'birthday',
      'sex': 'sex',
      'age': 'age',
      'weight': 'weight',
      'addition_method': 'addition_method'
    });
    if (data is DataSuccess) {
      emit(AddLivestockState(status:AddLivestockStateStatus.success));
    }

    if (data is DataFailed) {
      emit(AddLivestockState(status: AddLivestockStateStatus.error));
    }
  }

  _getTypesAndBreeds(
      GetTypeAndBreed value, Emitter<AddLivestockState> emit) async {
    emit(AddLivestockState(status: AddLivestockStateStatus.loading));

    final data = await _getTypeAndBreedUseCase();
    if (data is DataSuccess) {
      emit(
        state.copyWith(
            status: AddLivestockStateStatus.success, types: data.data ?? []),
      );
    }

    if (data is DataFailed) {
      emit(
        AddLivestockState(status: AddLivestockStateStatus.error),
      );
    }
  }

  _getAdditionType(
      GetAdditionType value, Emitter<AddLivestockState> emit) async {
    emit(AddLivestockState(status: AddLivestockStateStatus.loading));

    final data = await _getAdditionTypeUseCase.call(params: {
      'name': 'name',
      'type': 'type',
    });

    if (data is DataSuccess) {
      emit(
        AddLivestockState(status: AddLivestockStateStatus.success),
      );
    } else if (data is DataFailed) {
      emit(
        AddLivestockState(status: AddLivestockStateStatus.error),
      );
    }
  }
}
