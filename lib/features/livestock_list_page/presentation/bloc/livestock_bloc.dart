import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:malshy/core/network/custom_exceptions.dart';
import 'package:malshy/core/utils/data_state.dart';
import 'package:malshy/features/livestock_list_page/domain/usecases/get_addition_type_usecase.dart';
import 'package:malshy/features/livestock_list_page/domain/usecases/get_types_breeds_usecase.dart';
import '../../../../injection_container.dart';
import '../../domain/usecases/create_livestock_usecase.dart';

part 'livestock_event.dart';

part 'livestock_state.dart';

part 'livestock_bloc.freezed.dart';

class LivestockBloc extends Bloc<LivestockEvent, LivestockState> {
  final CreateLiveStockUseCase _createLiveStockUseCase = sl();
  final GetTypesAndBreedsUsecase _getTypeAndBreedUseCase = sl();
  final GetAdditionTypeUseCase _getAdditionTypeUseCase = sl();

  LivestockBloc() : super(_Initial()) {
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

  _createLivestock(CreateLivestock value, Emitter<LivestockState> emit) async {
    emit(LivestockLoading());

    final data = await _createLiveStockUseCase.call(params: {
      'RFID': 'RFID',
      'birthday': 'birthday',
      'sex': 'sex',
      'age': 'age',
      'weight': 'weight',
      'addition_method': 'addition_method'
    });
    if (data is DataSuccess) {
      emit(LivestockState.livestockLoaded());
    }

    if (data is DataFailed) {
      emit(
        LivestockState.livestockFailure(data.error as CustomException),
      );
    }
  }

  _getTypesAndBreeds(
      GetTypeAndBreed value, Emitter<LivestockState> emit) async {
    emit(LivestockLoading());

    final data = await _getTypeAndBreedUseCase();
    if (data is DataSuccess) {
      emit(LivestockState.livestockLoaded());
    }

    if (data is DataFailed) {
      emit(
        LivestockState.livestockFailure(data.error as CustomException),
      );
    }
  }

  _getAdditionType(GetAdditionType value, Emitter<LivestockState> emit) async {
    emit(LivestockLoading());

    final data = await _getAdditionTypeUseCase.call(params: {
      'name': 'name',
      'type': 'type',
    });

    if (data is DataSuccess) {
      emit(
        LivestockState.livestockLoaded(),
      );
    } else if (data is DataFailed) {
      emit(
        LivestockState.livestockFailure(data.error as CustomException),
      );
    }
  }
}
