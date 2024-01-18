import 'dart:io';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:malshy/core/const/app_colors.dart';
import 'package:malshy/core/const/app_icons.dart';
import 'package:malshy/core/function/age_calculator.dart';
import 'package:malshy/core/function/validation_functions.dart';
import 'package:malshy/core/widgets/date_picker_widget.dart';
import 'package:malshy/core/widgets/dropdown_textfield_widget.dart';
import 'package:malshy/core/widgets/lable_with_asterisk.dart';
import 'package:malshy/core/widgets/primary_button.dart';
import 'package:malshy/features/livestock/data/models/addition_type_model.dart';
import 'package:malshy/features/livestock/data/models/livestock_model.dart';
import 'package:malshy/features/livestock/data/models/type_model.dart';
import 'package:malshy/features/livestock/presentation/bloc/add_livestock/add_livestock_bloc.dart';
import 'package:malshy/features/livestock/presentation/widgets/edit_livestock_images_widget.dart';
import 'package:malshy/features/livestock/presentation/widgets/gender_radio_buttons_widget.dart';

class EditLivestockPage extends StatefulWidget {
  const EditLivestockPage({
    super.key,
    required this.types,
    required this.additionTypes,
    required this.livestockModel,
  });

  final List<TypeModel> types;
  final List<AdditionTypeModel> additionTypes;
  final LivestockModel livestockModel;

  @override
  State<EditLivestockPage> createState() => _EditLivestockPageState();
}

class _EditLivestockPageState extends State<EditLivestockPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _rfidController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final ValueNotifier<DateTime?> _birthdayNotifier = ValueNotifier<DateTime?>(null);
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _breedController = TextEditingController();
  final ValueNotifier<int> _sexController = ValueNotifier<int>(0);
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _additionTypeController = TextEditingController();
  final TextEditingController _motherRfidController = TextEditingController();
  final TextEditingController _fatherRfidController = TextEditingController();

  List<File> newImages = [];
  List<Photo> existingImages = [];
  List<int> deletedImages = [];

  @override
  void initState() {
    existingImages = [...widget.livestockModel.photos];

    _rfidController.text = widget.livestockModel.rfid;
    _nicknameController.text = widget.livestockModel.nickname ?? '';
    _birthdayNotifier.value = widget.livestockModel.birthday;
    _typeController.text = widget.livestockModel.type.toString();
    _breedController.text = widget.livestockModel.breed.toString();
    _sexController.value = widget.livestockModel.sex;
    _weightController.text = widget.livestockModel.weight.toString();
    _additionTypeController.text = widget.livestockModel.additionMethod.toString();
    _motherRfidController.text = widget.livestockModel.motherRfid ?? '';
    _fatherRfidController.text = widget.livestockModel.fatherRfid ?? '';

    _birthdayNotifier.addListener(() => setState(() {}));
    _typeController.addListener(() => setState(() {}));
    _breedController.addListener(() => setState(() {}));
    _sexController.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditLivestockBloc, LivestockState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) async {
        EasyLoading.removeAllCallbacks();
        EasyLoading.instance
          ..loadingStyle = EasyLoadingStyle.custom
          ..indicatorSize = 75.w
          ..indicatorType = EasyLoadingIndicatorType.circle
          ..indicatorColor = Color(0xFF2EA1D9)
          ..backgroundColor = Colors.white
          ..maskColor = Colors.black38
          ..animationDuration = Duration.zero
          ..animationStyle = EasyLoadingAnimationStyle.offset
          ..textColor = AppColors.primary(context)
          ..animationStyle = EasyLoadingAnimationStyle.scale
          ..userInteractions = false
          ..successWidget = SvgPicture.asset('assets/icons/success.svg')
          ..boxShadow = const []
          ..dismissOnTap = false;

        if (state.status == LivestockStateStatus.success) {
          await EasyLoading.showSuccess(
            'Успешно отредактировано',
            duration: 1.seconds,
            maskType: EasyLoadingMaskType.custom,
            dismissOnTap: true,
          );
          if (context.mounted) context.pop();
        } else if (state.status == LivestockStateStatus.error) {
          await EasyLoading.showError(
            'Ошибка при редактировании',
            duration: 1.seconds,
            maskType: EasyLoadingMaskType.custom,
            dismissOnTap: true,
          );
        } else if (state.status == LivestockStateStatus.loading) {
          await EasyLoading.show(
            maskType: EasyLoadingMaskType.custom,
            dismissOnTap: false,
          );
        }
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 50.h),
          child: AppBar(
            title: Text('Edit животное'),
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
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              context.read<EditLivestockBloc>().add(
                    LivestockEvent.editLivestock(
                      livestockId: widget.livestockModel.id,
                      rfid: _rfidController.text,
                      nickname: _nicknameController.text.isEmpty ? null : _nicknameController.text,
                      birthday: _birthdayNotifier.value ?? DateTime.now(),
                      type: int.tryParse(_typeController.text) ?? 0,
                      breed: int.tryParse(_breedController.text) ?? 0,
                      sex: _sexController.value,
                      age: calculateAge(_birthdayNotifier.value ?? DateTime.now()),
                      weight: double.tryParse(_weightController.text) ?? 0,
                      additionMethod: int.tryParse(_additionTypeController.text) ?? 0,
                      motherRfid: _motherRfidController.text.isEmpty ? null : _motherRfidController.text,
                      fatherRfid: _fatherRfidController.text.isEmpty ? null : _fatherRfidController.text,
                      newImages: newImages,
                      deletedImages: deletedImages,
                    ),
                  );
            }
          },
        ).paddingSymmetric(horizontal: 28.w, vertical: 12.h),
        body: SingleChildScrollView(
          child: Container(
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // image widget
                  // Text(existingImages.toString()),
                  // Text(newImages.length.toString()),
                  // Text(deletedImages.toString()),
                  EditLivestockImageWidget(
                    newImages: newImages,
                    existingImages: existingImages,
                    deleteExistingImage: (id) {
                      deletedImages.add(id);
                      existingImages.removeWhere((element) => element.id == id);
                      setState(() {});
                    },
                  ).paddingOnly(bottom: 36.h),
                  // rfid
                  TextFormField(
                    controller: _rfidController,
                    validator: ValidationFunctions().isEmpty(context),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      label: LabelWithAsterisk(label: 'Ушная бирка(RFID)'),
                      hintText: 'Введите ушную бирку',
                      hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.grayMedium),
                    ),
                  ).paddingOnly(bottom: 16.h),
                  // nickname
                  TextFormField(
                    controller: _nicknameController,
                    decoration: InputDecoration(
                      labelText: 'Кличка',
                      labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),
                      hintText: 'Введите кличку',
                      hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.grayMedium,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ).paddingOnly(bottom: 16.h),
                  // birthday
                  DatePickerWidget(
                    dateValue: _birthdayNotifier,
                    isRequired: true,
                    label: 'Дата рождения',
                    hint: 'Выберите дату ',
                    firstDate: DateTime(1990, 1, 1),
                    lastDate: DateTime.now(),
                  ).paddingOnly(bottom: 16.h),
                  // type
                  DropdownTextFieldWidget(
                    controller: _typeController,
                    isRequired: true,
                    label: 'Вид',
                    hint: 'Выберите вид',
                    onChanged: (_) => _breedController.clear(),
                    options: widget.types.map((e) => e.type.toString()).toList(),
                    optionsString: widget.types.map((e) => e.name.ru).toList(),
                  ).paddingOnly(bottom: 16.h),
                  // breed
                  Builder(
                    builder: (context) {
                      final isTypeSelected =
                          _typeController.text.isNotEmpty && int.tryParse(_typeController.text) != null;
                      List<BreedModel> breeds = [];
                      // если был выбран вид скота, мы будем показывать только соответствующие породы
                      // в другом случае мы покажем все породы и автоматически выберем вид скота при выборе породы
                      if (isTypeSelected) {
                        breeds.addAll(
                          widget.types.firstWhereOrNull((e) => e.type == int.tryParse(_typeController.text))?.breeds ??
                              [],
                        );
                      } else {
                        for (TypeModel type in widget.types) breeds.addAll(type.breeds);
                      }

                      return DropdownTextFieldWidget(
                        // canEdit: true,
                        controller: _breedController,
                        isRequired: true,
                        label: 'Порода',
                        hint: 'Выберите породу',
                        onChanged: (value) {
                          // автоматический выбор вида домашнего скота в соответствии с породой
                          final typeToSelect =
                              breeds.firstWhereOrNull((e) => e.id == int.tryParse(value))?.livestockType;
                          if (typeToSelect != null) _typeController.text = typeToSelect.toString();
                        },
                        options: breeds.map((e) => e.id.toString()).toList(),
                        optionsString: breeds.map((e) => e.breed.toString()).toList(),
                      ).paddingOnly(bottom: 10.h);
                    },
                  ),
                  // sex
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Укажите пол ',
                          style: TextStyle(
                            color: Color(0xFF1C1C11),
                            fontSize: 14.sp,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                          ),
                          children: const [
                            TextSpan(text: '*', style: TextStyle(color: AppColors.error)),
                            TextSpan(text: ' :'),
                          ],
                        ),
                      ).paddingOnly(right: 12.w),
                      GenderRadioButtonWidget(controller: _sexController),
                    ],
                  ).paddingOnly(bottom: 16.h),
                  // weight
                  TextFormField(
                    controller: _weightController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: ValidationFunctions().isEmptyOrInvalidNumber(context),
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      label: LabelWithAsterisk(label: 'Вес'),
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
                  ).paddingOnly(bottom: 16.h),
                  // addition type
                  DropdownTextFieldWidget(
                    controller: _additionTypeController,
                    isRequired: true,
                    label: 'Способ добавления к поголовью',
                    hint: 'Выберите способ',
                    options: widget.additionTypes.map((e) => e.type.toString()).toList(),
                    optionsString: widget.additionTypes.map((e) => e.name.ru).toList(),
                  ).paddingOnly(bottom: 16.h),
                  // mother rfid
                  TextFormField(
                    controller: _motherRfidController,
                    decoration: InputDecoration(
                      labelText: 'Бирка матери(RFID)',
                      labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),
                      hintText: 'Введите бирку',
                      hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.grayMedium,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ).paddingOnly(bottom: 16.h),
                  // father rfid
                  TextFormField(
                    controller: _fatherRfidController,
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
                ],
              ),
            ),
          ).paddingAll(16.w),
        ),
      ),
    );
  }
}
