import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:malshy/core/utils/data_state.dart';
import 'package:malshy/features/livestock/data/models/addition_type_model.dart';
import 'package:malshy/features/livestock/data/models/type_model.dart';
import 'package:malshy/features/livestock/domain/usecases/get_addition_type_usecase.dart';
import 'package:malshy/features/livestock/domain/usecases/get_types_breeds_usecase.dart';

part 'filter_livestock_event.dart';
part 'filter_livestock_state.dart';
part 'filter_livestock_bloc.freezed.dart';

class FilterLivestockBloc extends Bloc<FilterLivestockEvent, FilterLivestockState> {
  final _getTypesBreedsUsecase = GetIt.I.get<GetTypesAndBreedsUsecase>();
  final _getAdditionTypesUsecase = GetIt.I.get<GetAdditionTypeUseCase>();

  FilterLivestockBloc()
      : super(FilterLivestockState(
          status: FilterLivestockStatus.loading,
          types: [],
          additionTypes: [],
          selectedType: null,
          selectedBreed: null,
          minWeight: null,
          maxWeight: null,
          minAge: null,
          maxAge: null,
          isPregnant: null,
        )) {
    on<_FetchFilters>(_fetchFilters);
    on<_ChangeFilter>(_changeFilter);
  }

  FutureOr<void> _fetchFilters(_FetchFilters event, emit) async {
    emit(state.copyWith(status: FilterLivestockStatus.loading));

    final typesAndBreedsResult = await _getTypesBreedsUsecase();
    final additionTypesResult = await _getAdditionTypesUsecase();

    if (typesAndBreedsResult is DataSuccess &&
        additionTypesResult is DataSuccess &&
        typesAndBreedsResult.data != null &&
        additionTypesResult.data != null) {
      emit(
        state.copyWith(
          types: typesAndBreedsResult.data!,
          additionTypes: additionTypesResult.data!,
          status: FilterLivestockStatus.success,
        ),
      );
    } else {
      emit(state.copyWith(status: FilterLivestockStatus.error));
    }
  }

  FutureOr<void> _changeFilter(_ChangeFilter event, emit) async {
    emit(state.copyWith(
      selectedType: event.selectedType,
      selectedBreed: event.selectedBreed,
      minWeight: event.minWeight,
      maxWeight: event.maxWeight,
      minAge: event.minAge,
      maxAge: event.maxAge,
      isPregnant: event.isPregnant,
    ));
  }
}
