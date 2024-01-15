part of 'filter_livestock_bloc.dart';

@freezed
class FilterLivestockEvent with _$FilterLivestockEvent {
  const factory FilterLivestockEvent.fetchFilters() = _FetchFilters;

  const factory FilterLivestockEvent.changeFilter({
    required int? selectedType,
    required int? selectedBreed,
    required double? minWeight,
    required double? maxWeight,
    required int? minAge,
    required int? maxAge,
    required bool? isPregnant,
  }) = _ChangeFilter;
}
