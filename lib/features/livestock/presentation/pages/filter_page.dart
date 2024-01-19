import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:malshy/core/widgets/dropdown_textfield_widget.dart';
import 'package:malshy/features/livestock/presentation/bloc/filter_livestock/filter_livestock_bloc.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import '../../../../core/const/app_colors.dart';
import '../../../../core/const/app_icons.dart';
import '../../../../core/widgets/primary_button.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  SfRangeValues _weight = SfRangeValues(0, 1000);
  SfRangeValues _age = SfRangeValues(4.0, 6.0);
  late ValueNotifier<int?> _selectedType;
  late ValueNotifier<int?> _selectedBreed;
  late final ValueNotifier<bool?> _isPregnant;

  @override
  void initState() {
    final bloc = context.read<FilterLivestockBloc>();
    _weight = SfRangeValues(bloc.state.minWeight ?? 0, bloc.state.maxWeight ?? 1000);
    _age = SfRangeValues(bloc.state.minAge ?? 0, bloc.state.maxAge ?? 35);
    _selectedType = ValueNotifier<int?>(bloc.state.selectedType)..addListener(() {});
    _selectedBreed = ValueNotifier<int?>(bloc.state.selectedBreed)..addListener(() => setState(() {}));
    _isPregnant = ValueNotifier<bool?>(bloc.state.isPregnant)..addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 50.h),
        child: AppBar(
          title: Text('Фильтрация списка'),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: SvgPicture.asset(AppIcons.back),
          ),
        ),
      ),
      bottomNavigationBar: PrimaryButton(
        text: 'Сохранить',
        onPressed: () {
          context.read<FilterLivestockBloc>().add(
                FilterLivestockEvent.changeFilter(
                  selectedType: _selectedType.value,
                  selectedBreed: _selectedBreed.value,
                  minWeight: (_weight.start as num).roundToDouble(),
                  maxWeight: (_weight.end as num).roundToDouble(),
                  minAge: int.tryParse((_age.start as num).toStringAsFixed(0)),
                  maxAge: int.tryParse((_age.end as num).toStringAsFixed(0)),
                  isPregnant: _isPregnant.value,
                ),
              );
          context.pop();
        },
      ).paddingAll(16.w),
      body: BlocBuilder<FilterLivestockBloc, FilterLivestockState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // виды
                  DropdownTextFieldWidget<int>(
                    isRequired: false,
                    label: 'Вид',
                    hint: 'Выберите вид',
                    optionsMap: {
                      for (final e in state.types) e.name.ru: e.type,
                    },
                    selectedOption: _selectedType,
                    onChanged: (_) {
                      _selectedBreed.value = null;
                    },
                  ).paddingOnly(bottom: 16.h),
                  // породы
                  Builder(
                    builder: (context) {
                      Map<String, int> breedOptions = {};

                      // если null значит ничего не выбрано, поэтому мы покажем все породы
                      final selectedTypeBreeds =
                          state.types.firstWhereOrNull((e) => e.type == _selectedType.value)?.breeds;

                      // если был выбран вид скота, мы будем показывать только соответствующие породы
                      // в другом случае мы покажем все породы и автоматически выберем вид скота при выборе породы
                      if (selectedTypeBreeds != null) {
                        for (final b in selectedTypeBreeds) breedOptions[b.breed] = b.id;
                      } else {
                        for (final t in state.types) {
                          breedOptions.addEntries(
                            t.breeds.map((e) => MapEntry(e.breed, e.id)),
                          );
                        }
                      }

                      return DropdownTextFieldWidget(
                        isRequired: false,
                        label: 'Порода',
                        hint: 'Выберите породу',
                        optionsMap: {
                          for (final sorted in breedOptions.entries.sorted((a, b) => a.key.compareTo(b.key)))
                            sorted.key: sorted.value,
                        },
                        onChanged: (int selectedId) {
                          // автоматический выбор вида домашнего скота в соответствии с породой
                          final typeToSelect = state.types
                              .firstWhereOrNull((e) => e.breeds.any((element) => element.id == selectedId))
                              ?.type;

                          if (typeToSelect != null) _selectedType.value = typeToSelect;
                        },
                        selectedOption: _selectedBreed,
                      ).paddingOnly(bottom: 10.h);
                    },
                  ),
                  // масса
                  Text('Масса').paddingOnly(bottom: 8.h),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TextField(
                        controller: TextEditingController(text: '${(_weight.start as num).toStringAsFixed(0)} кг'),
                        decoration: InputDecoration(
                          prefixIcon: Text(
                            'ot',
                            style: TextStyle(color: AppColors.gray),
                          ).paddingSymmetric(horizontal: 8.w),
                          prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                        ),
                      ).expanded(),
                      8.w.widthBox,
                      TextField(
                        controller: TextEditingController(text: '${(_weight.end as num).toStringAsFixed(0)} кг'),
                        decoration: InputDecoration(
                          prefixIcon: Text(
                            'do',
                            style: TextStyle(color: AppColors.gray),
                          ).paddingSymmetric(horizontal: 8.w),
                          prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                        ),
                      ).expanded(),
                    ],
                  ),
                  SfRangeSlider(
                    min: 0,
                    max: 1000,
                    values: _weight,
                    onChanged: (dynamic values) {
                      setState(() {
                        _weight = values;
                      });
                    },
                  ),
                  // возраст
                  Text('Возраст').paddingOnly(bottom: 8.h),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TextField(
                        controller: TextEditingController(text: (_age.start as num).toStringAsFixed(0)),
                        decoration: InputDecoration(
                          prefixIcon: Text(
                            'ot',
                            style: TextStyle(color: AppColors.gray),
                          ).paddingSymmetric(horizontal: 8.w),
                          prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                        ),
                      ).expanded(),
                      8.w.widthBox,
                      TextField(
                        controller: TextEditingController(text: (_age.end as num).toStringAsFixed(0)),
                        decoration: InputDecoration(
                          prefixIcon: Text(
                            'do',
                            style: TextStyle(color: AppColors.gray),
                          ).paddingSymmetric(horizontal: 8.w),
                          prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                        ),
                      ).expanded(),
                    ],
                  ),
                  SfRangeSlider(
                    min: 0,
                    max: 35,
                    values: _age,
                    onChanged: (dynamic values) {
                      setState(() {
                        _age = values;
                      });
                    },
                  ),
                  // стельность
                  DropdownTextFieldWidget<bool>(
                    selectedOption: _isPregnant,
                    hint: 'Стельность',
                    label: 'Стельность',
                    optionsMap: const {
                      'Да': true,
                      'Нет': false,
                    },
                    isRequired: false,
                  ).paddingOnly(bottom: 16.h),
                ],
              ),
            ).paddingAll(16.w),
          );
        },
      ),
    );
  }
}
