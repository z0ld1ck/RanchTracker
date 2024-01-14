part of 'filter_livestock_bloc.dart';

@freezed
class FilterLivestockState with _$FilterLivestockState {
  const factory FilterLivestockState({
    required List<TypeModel> types,
    required int? selectedType,
    required int? selectedBreed,
    required double? minWeight,
    required double? maxWeight,
    required int? minAge,
    required int? maxAge,
    required bool? isPregnant,
  }) = _FilterLivestockState;
}
