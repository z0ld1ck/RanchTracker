import 'dart:convert';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:malshy/core/const/app_colors.dart';
import 'package:malshy/core/function/age_calculator.dart';
import 'package:malshy/core/widgets/date_picker_widget.dart';
import 'package:malshy/core/widgets/dropdown_textfield_widget.dart';
import 'package:malshy/core/widgets/primary_button.dart';
import 'package:malshy/features/livestock/presentation/bloc/add_livestock/add_livestock_bloc.dart';
import 'package:malshy/features/livestock/presentation/widgets/gender_radio_buttons_widget.dart';
import '../../../../core/const/app_icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';

class AddLivestockPage extends StatefulWidget {
  const AddLivestockPage({super.key});

  @override
  State<AddLivestockPage> createState() => _AddLivestockPageState();
}

class _AddLivestockPageState extends State<AddLivestockPage> {
  DateTime date = DateTime.now();
  String? selectedValue;
  TextEditingController rfid = TextEditingController();
  TextEditingController nickname = TextEditingController();
  TextEditingController dateInput = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController breed = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController way = TextEditingController();
  TextEditingController mother_rfid = TextEditingController();
  TextEditingController father_rfid = TextEditingController();
  ValueNotifier<int> gender = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 50.h),
        child: AppBar(
          title: Text('Добавить животное'),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: SvgPicture.asset(AppIcons.back),
          ),
        ),
      ),
      body: BlocBuilder<AddLivestockBloc, AddLivestockState>(
        builder: (context, state) {
          final List<String> options =
              state.types?.map((e) => e.type.toString()).toList() ?? [];
          final List<String> optionStrings =
              state.types?.map((e) => e.type.toString()).toList() ?? [];

          return SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: SvgPicture.asset(AppIcons.avatar),
                        onPressed: () {},
                      ),
                    ],
                  ).paddingOnly(bottom: 16.h),
                  TextFormField(
                    controller: rfid,
                    maxLines: 1,
                    decoration: InputDecoration(
                      label: RichText(
                        text: TextSpan(
                          text: 'Ушная бирка(RFID)',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.black),
                          children: const [
                            TextSpan(
                              text: ' *',
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                      hintText: 'Введите ушную бирку',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: AppColors.grayMedium),
                    ),
                  ).paddingOnly(bottom: 16.h),
                  TextFormField(
                    controller: nickname,
                    maxLines: 1,
                    decoration: InputDecoration(
                      labelText: 'Кличка',
                      labelStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.black),
                      hintText: 'Введите кличку',
                      hintStyle:
                          Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: AppColors.grayMedium,
                                fontWeight: FontWeight.w500,
                              ),
                    ),
                  ).paddingOnly(bottom: 16.h),
                  DatePickerWidget(
                    isRequired: false,
                    label: 'Дата рождения',
                    hint: 'Выберите дату ',
                    isDatePicker: true,
                    controller: dateInput,
                    firstDate: DateTime(1990, 1, 1),
                    lastDate: DateTime(2100, 1, 1),
                  ).paddingOnly(bottom: 16.h),
                  DropdownTextFieldWidget(
                    controller: type,
                    isRequired: false,
                    label: 'Вид',
                    hint: 'Выберите вид',
                    options: options,
                    optionsString: optionStrings,
                  ).paddingOnly(bottom: 16.h),
                  DropdownTextFieldWidget(
                    canEdit: true,
                    controller: breed,
                    isRequired: false,
                    label: 'Порода',
                    hint: 'Выберите породу',
                    options: (state.types
                            ?.firstWhereOrNull((element) =>
                                element.type == int.tryParse(type.text))
                            ?.breeds
                            .map((e) => e.id.toString())
                            .toList() ??
                        []),
                    optionsString: (state.types
                            ?.firstWhereOrNull((element) =>
                                element.type == int.tryParse(type.text))
                            ?.breeds
                            .map((e) => e.breed.toString())
                            .toList() ??
                        []),
                  ).paddingOnly(bottom: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Укажите пол:',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GenderRadioButtonWidget(controller: gender),
                        ],
                      ),
                    ],
                  ).paddingOnly(bottom: 16.h),
                  TextFormField(
                    controller: weight,
                    maxLines: 1,
                    decoration: InputDecoration(
                      labelText: 'Вес',
                      labelStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.black),
                      hintText: 'Введите текст',
                      suffixIcon: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(90, 0, 13, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text('кг'),
                          ],
                        ),
                      ),
                      hintStyle:
                          Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: AppColors.grayMedium,
                                fontWeight: FontWeight.w500,
                              ),
                    ),
                  ).paddingOnly(bottom: 16.h),
                  DropdownTextFieldWidget(
                    controller: type,
                    isRequired: true,
                    label: 'Способ добавления к поголовью',
                    hint: 'Выберите способ',
                    options: const [
                      'Приплод',
                    ],
                    optionsString: const [
                      'Приплод',
                    ],
                  ).paddingOnly(bottom: 16.h),
                  TextFormField(
                    controller: mother_rfid,
                    maxLines: 1,
                    decoration: InputDecoration(
                      labelText: 'Бирка матери(RFID)',
                      labelStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.black),
                      hintText: 'Введите бирку',
                      hintStyle:
                          Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: AppColors.grayMedium,
                                fontWeight: FontWeight.w500,
                              ),
                    ),
                  ).paddingOnly(bottom: 16.h),
                  TextFormField(
                    controller: father_rfid,
                    maxLines: 1,
                    decoration: InputDecoration(
                      labelText: 'Бирка отца(RFID)',
                      labelStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.black),
                      hintText: 'Введите бирку',
                      hintStyle:
                          Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: AppColors.grayMedium,
                                fontWeight: FontWeight.w500,
                              ),
                    ),
                  ).paddingOnly(bottom: 16.h),
                  PrimaryButton(
                    text: 'Сохранить',
                    onPressed: () {
                      context
                          .read<AddLivestockBloc>()
                          .add(AddLivestockEvent.createLivestock());

                      DateTime selectedDate =
                          DateFormat('dd.MM.yyyy').parse(dateInput.text);
                      int age = calculateAge(selectedDate);
                    },
                  ),
                ],
              ).paddingAll(16.w),
            ),
          );
        },
      ),
    );
  }
}
