part of 'filter_livestock_bloc.dart';

enum FilterLivestockStatus { loading, error, success }

@freezed
class FilterLivestockState with _$FilterLivestockState {
  const factory FilterLivestockState({
    required FilterLivestockStatus status,
    required List<TypeModel> types,
    required List<AdditionTypeModel> additionTypes,
    required int? selectedType,
    required int? selectedBreed,
    required double? minWeight,
    required double? maxWeight,
    required int? minAge,
    required int? maxAge,
    required bool? isPregnant,
  }) = _FilterLivestockState;
}
