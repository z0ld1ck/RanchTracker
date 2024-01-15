import 'dart:convert';

import 'package:flutter/material.dart';
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
import 'package:malshy/features/livestock_list_page/presentation/bloc/add_livestock/add_livestock_bloc.dart';
import 'package:malshy/features/livestock_list_page/presentation/widgets/gender_radio_buttons_widget.dart';
import '../../../../core/const/app_icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddLivestockPage extends StatefulWidget {
  const AddLivestockPage({super.key});

  @override
  State<AddLivestockPage> createState() => _AddLivestockPageState();
}

class _AddLivestockPageState extends State<AddLivestockPage> {
  DateTime date = DateTime.now();
  String? selectedValue;
  TextEditingController RFD = TextEditingController();
  TextEditingController cattleName = TextEditingController();
  TextEditingController dateInput = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController breed = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController way = TextEditingController();
  TextEditingController RFIDm = TextEditingController();
  TextEditingController RFIDf = TextEditingController();
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
      body: BlocConsumer<AddLivestockBloc, AddLivestockState>(
        listenWhen: (context, state) {
          return state is LivestockLoaded || state is LivestockLoading;
        },
        listener: (context, state) {
          if (state is LivestockLoaded) {
            Fluttertoast.showToast(
              msg: 'The livestock was created',
              toastLength: Toast.LENGTH_SHORT,
              timeInSecForIosWeb: 2,
              backgroundColor: AppColors.black,
              textColor: AppColors.white,
              fontSize: 16,
            );
          }
          if (state is LivestockFailure) {
            Fluttertoast.showToast(
              msg: 'Creation failure',
              toastLength: Toast.LENGTH_SHORT,
              fontSize: 16,
              timeInSecForIosWeb: 2,
              backgroundColor: AppColors.black,
              textColor: AppColors.white,
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 16.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: SvgPicture.asset(AppIcons.avatar),
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(
                  height: 16.h,
                ),
                Container(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                  child: TextField(
                    controller: RFD,
                    maxLines: 1,
                    decoration: InputDecoration(
                      label: RichText(
                        text: TextSpan(
                          text: 'Ушная бирка(RFID)',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),
                          children: const [
                            TextSpan(
                              text: ' *',
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                      hintText: 'Введите ушную бирку',
                      hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.grayMedium),
                    ),
                  ),
                ),
                SizedBox(
                  height: 17.h,
                ),
                Container(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                  child: TextField(
                    controller: cattleName,
                    maxLines: 1,
                    decoration: InputDecoration(
                      labelText: 'Кличка',
                      labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),
                      hintText: 'Введите кличку',
                      hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.grayMedium,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 17.h,
                ),
                Container(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                  child: DatePickerWidget(
                    isRequired: false,
                    label: 'Дата рождения',
                    hint: 'Выберите дату ',
                    isDatePicker: true,
                    controller: dateInput,
                    firstDate: DateTime(1990, 1, 1),
                    lastDate: DateTime(2100, 1, 1),
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Container(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                  child: DropdownTextFieldWidget(
                    controller: type,
                    isRequired: false,
                    label: 'Вид',
                    hint: 'Выберите вид',
                    options: const ['kjk', 'asa'],
                    optionsString: const ['asa', 'kjk'],
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Container(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                  child: DropdownTextFieldWidget(
                    canEdit: true,
                    controller: breed,
                    isRequired: false,
                    label: 'Порода',
                    hint: 'Выберите породу',
                    options: const ['kjk', 'asa'],
                    optionsString: const ['asa', 'kjk'],
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                  child: Row(
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
                  ),
                ),
                Container(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 10, 15, 0),
                  child: TextField(
                    controller: weight,
                    maxLines: 1,
                    decoration: InputDecoration(
                      labelText: 'Вес',
                      labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),
                      hintText: 'Введите текст',
                      suffixIcon: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(90, 0, 13, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text('кг'),
                          ],
                        ),
                      ),
                      hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.grayMedium,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Container(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                  child: DropdownTextFieldWidget(
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
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Container(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
                  child: TextField(
                    controller: RFIDm,
                    maxLines: 1,
                    decoration: InputDecoration(
                      labelText: 'Бирка матери(RFID)',
                      labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),
                      hintText: 'Введите бирку',
                      hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.grayMedium,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Container(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
                  child: TextField(
                    controller: RFIDf,
                    maxLines: 1,
                    decoration: InputDecoration(
                      labelText: 'Бирка отца(RFID)',
                      labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),
                      hintText: 'Введите бирку',
                      hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.grayMedium,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                PrimaryButton(
                  text: 'Сохранить',
                  onPressed: () {
                    DateTime selectedDate = DateFormat('dd.MM.yyyy').parse(dateInput.text);
                    int age = calculateAge(selectedDate);

                    final livestockData = {
                      'RFID': RFD.text,
                      'birthday': dateInput.text,
                      'sex': gender.value,
                      'age': age,
                      'weight': weight.text,
                      'addition_method': type.text,
                    };
                    print(jsonEncode(livestockData));

                    context.read<AddLivestockBloc>().add(AddLivestockEvent.createLivestock());
                  },
                ),
                SizedBox(
                  height: 30.h,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
