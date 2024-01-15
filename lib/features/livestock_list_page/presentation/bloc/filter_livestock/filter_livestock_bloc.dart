import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:malshy/core/utils/data_state.dart';
import 'package:malshy/features/livestock_list_page/data/models/type_model.dart';
import 'package:malshy/features/livestock_list_page/domain/usecases/get_types_breeds_usecase.dart';

part 'filter_livestock_event.dart';
part 'filter_livestock_state.dart';
part 'filter_livestock_bloc.freezed.dart';

class FilterLivestockBloc extends Bloc<FilterLivestockEvent, FilterLivestockState> {
  final _getTypesBreedsUsecase = GetIt.I.get<GetTypesAndBreedsUsecase>();

  FilterLivestockBloc()
      : super(FilterLivestockState(
          types: [],
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
    final result = await _getTypesBreedsUsecase();
    if (result is DataSuccess) {
      emit(state.copyWith(types: result.data ?? []));
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
