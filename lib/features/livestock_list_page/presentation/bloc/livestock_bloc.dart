import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:malshy/core/network/custom_exceptions.dart';
import 'package:provider/provider.dart';
import '../../../../core/error/data_state.dart';
import '../../../../injection_container.dart';
import '../../data/models/livestock_model.dart';
import '../../domain/usecases/create_livestock_usecase.dart';

part 'livestock_event.dart';

part 'livestock_state.dart';

part 'livestock_bloc.freezed.dart';

class LivestockBloc extends Bloc<LivestockEvent, LivestockState> {
  final CreateLiveStockUseCase _createLiveStockUseCase = sl();

  LivestockBloc() : super(_Initial()) {
    on<LivestockEvent>((event, emit) async {
      await event.map(
        createLivestock: (CreateLivestock value) async =>
            await _createLivestock(value, emit),
      );
    });
  }

  _createLivestock(CreateLivestock value, Emitter<LivestockState> emit) async {
    emit(CreateLivestockLoading());

    final data = await _createLiveStockUseCase.call({
      'RFID': 'RFID',
      'birthday': 'birthday',
      'sex': 'sex',
      'age': 'age',
      'weight': 'weight',
      'addition_method': 'addition_method'
    });
    if (data is DataSuccess) {
      emit(LivestockState.livestockCreated());
    }

    if (data is DataFailed) {
      emit(
        LivestockState.createLivestockFailure(data.error as CustomException),
      );
    }
  }
}
