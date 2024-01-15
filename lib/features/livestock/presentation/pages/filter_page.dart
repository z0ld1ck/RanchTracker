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
  late TextEditingController _typeController;
  late TextEditingController _breedController;
  late TextEditingController _pregnantController;

  @override
  void initState() {
    final bloc = context.read<FilterLivestockBloc>();
    _weight = SfRangeValues(bloc.state.minWeight ?? 0, bloc.state.maxWeight ?? 1000);
    _age = SfRangeValues(bloc.state.minAge ?? 0, bloc.state.maxAge ?? 35);
    _typeController = TextEditingController(text: bloc.state.selectedType?.toString())
      ..addListener(() => setState(() => _breedController.clear()));
    _breedController = TextEditingController(text: bloc.state.selectedBreed?.toString())
      ..addListener(() => setState(() {}));
    _pregnantController = TextEditingController(text: bloc.state.isPregnant?.toString())
      ..addListener(() => setState(() {}));
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
                  selectedType: int.tryParse(_typeController.text),
                  selectedBreed: int.tryParse(_breedController.text),
                  minWeight: (_weight.start as num).roundToDouble(),
                  maxWeight: (_weight.end as num).roundToDouble(),
                  minAge: int.tryParse((_age.start as num).toStringAsFixed(0)),
                  maxAge: int.tryParse((_age.end as num).toStringAsFixed(0)),
                  isPregnant: bool.tryParse(_pregnantController.text),
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
                  DropdownTextFieldWidget(
                    controller: _typeController,
                    hint: 'Выберите вид',
                    label: 'Виды',
                    options: state.types.map((e) => e.type.toString()).toList(),
                    optionsString: state.types.map((e) => e.name.ru).toList(),
                    isRequired: false,
                  ).paddingOnly(bottom: 16.h),
                  // породы
                  DropdownTextFieldWidget(
                    controller: _breedController,
                    hint: 'Выберите породу',
                    label: 'Породы',
                    options: (state.types
                            .firstWhereOrNull((element) => element.type == int.tryParse(_typeController.text))
                            ?.breeds
                            .map((e) => e.id.toString())
                            .toList() ??
                        []),
                    optionsString: (state.types
                            .firstWhereOrNull((element) => element.type == int.tryParse(_typeController.text))
                            ?.breeds
                            .map((e) => e.breed.toString())
                            .toList() ??
                        []),
                    isRequired: false,
                  ).paddingOnly(bottom: 16.h),
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
                  DropdownTextFieldWidget(
                    controller: _pregnantController,
                    hint: 'стельность',
                    label: 'стельность',
                    options: const ['true', 'false'],
                    optionsString: const ['Да', 'Нет'],
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
