import 'dart:io';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:malshy/core/const/app_colors.dart';
import 'package:malshy/core/function/age_calculator.dart';
import 'package:malshy/core/function/validation_functions.dart';
import 'package:malshy/core/widgets/date_picker_widget.dart';
import 'package:malshy/core/widgets/dropdown_textfield_widget.dart';
import 'package:malshy/core/widgets/lable_with_asterisk.dart';
import 'package:malshy/core/widgets/primary_button.dart';
import 'package:malshy/features/livestock/data/models/addition_type_model.dart';
import 'package:malshy/features/livestock/data/models/type_model.dart';
import 'package:malshy/features/livestock/presentation/bloc/add_livestock/add_livestock_bloc.dart';
import 'package:malshy/features/livestock/presentation/widgets/add_livestock_images_widget.dart';
import 'package:malshy/features/livestock/presentation/widgets/gender_radio_buttons_widget.dart';
import '../../../../core/const/app_icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddLivestockPage extends StatefulWidget {
  const AddLivestockPage({super.key, required this.types, required this.additionTypes});

  final List<TypeModel> types;
  final List<AdditionTypeModel> additionTypes;

  @override
  State<AddLivestockPage> createState() => _AddLivestockPageState();
}

class _AddLivestockPageState extends State<AddLivestockPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _rfidController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final ValueNotifier<DateTime?> _birthdayNotifier = ValueNotifier<DateTime?>(null);
  final ValueNotifier<int?> _selectedType = ValueNotifier<int?>(null);
  final ValueNotifier<int?> _selectedBreed = ValueNotifier<int?>(null);
  final ValueNotifier<int> _sexController = ValueNotifier<int>(0);
  final TextEditingController _weightController = TextEditingController();
  final ValueNotifier<int?> _selectedAdditionType = ValueNotifier<int?>(null);
  final TextEditingController _motherRfidController = TextEditingController();
  final TextEditingController _fatherRfidController = TextEditingController();

  List<File> images = [];

  // dropdown options
  final Map<String, int> _breedOptions = {};

  @override
  void initState() {
    for (final type in widget.types) {
      _breedOptions.addEntries(
        type.breeds.map((e) => MapEntry(e.breed, e.id)),
      );
    }
    _selectedType.addListener(() => setState(() {}));
    _selectedBreed.addListener(() => setState(() {}));
    _birthdayNotifier.addListener(() => setState(() {}));
    _sexController.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddLivestockBloc, LivestockState>(
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
            'Успешно добавлено',
            duration: 1.seconds,
            maskType: EasyLoadingMaskType.custom,
            dismissOnTap: true,
          );
          if (context.mounted) context.pop();
        } else if (state.status == LivestockStateStatus.error) {
          await EasyLoading.showError(
            'Ошибка при добавлении',
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
        bottomNavigationBar: PrimaryButton(
          text: 'Сохранить',
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              context.read<AddLivestockBloc>().add(
                    LivestockEvent.createLivestock(
                      rfid: _rfidController.text,
                      nickname: _nicknameController.text.isEmpty ? null : _nicknameController.text,
                      birthday: _birthdayNotifier.value ?? DateTime.now(),
                      type: _selectedType.value ?? 0,
                      breed: _selectedBreed.value ?? 0,
                      sex: _sexController.value,
                      age: calculateAge(_birthdayNotifier.value ?? DateTime.now()),
                      weight: double.tryParse(_weightController.text) ?? 0,
                      additionMethod: _selectedBreed.value ?? 0,
                      motherRfid: _motherRfidController.text.isEmpty ? null : _motherRfidController.text,
                      fatherRfid: _fatherRfidController.text.isEmpty ? null : _fatherRfidController.text,
                      images: images,
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
                  AddLivestockImageWidget(images: images).paddingOnly(bottom: 36.h),
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
                  DropdownTextFieldWidget<int>(
                    isRequired: true,
                    label: 'Вид',
                    hint: 'Выберите вид',
                    optionsMap: {
                      for (final e in widget.types) e.name.ru: e.type,
                    },
                    selectedOption: _selectedType,
                    onChanged: (_) {
                      if ((_selectedBreed.value ?? -1) > 0) _selectedBreed.value = null;
                      _breedOptions.removeWhere((key, value) => value >= 0);
                      for (final type in widget.types) {
                        _breedOptions.addEntries(
                          type.breeds.map((e) => MapEntry(e.breed, e.id)),
                        );
                      }
                    },
                  ).paddingOnly(bottom: 16.h),
                  // breed
                  Builder(
                    builder: (context) {
                      // если null значит ничего не выбрано, поэтому мы покажем все породы
                      final selectedType = widget.types.firstWhereOrNull((e) => e.type == _selectedType.value)?.breeds;

                      // если был выбран вид скота, мы будем показывать только соответствующие породы
                      // в другом случае мы покажем все породы и автоматически выберем вид скота при выборе породы
                      if (selectedType != null) {
                        _breedOptions.removeWhere((key, value) => value >= 0);
                        for (final t in selectedType) _breedOptions[t.breed] = t.id;
                      }

                      return DropdownTextFieldWidget(
                        addOption: (option) {
                          final minValue = _breedOptions.values.minOrNull;
                          _breedOptions[option] = minValue != null && minValue < 0 ? minValue - 1 : -1;
                        },
                        isRequired: true,
                        label: 'Порода',
                        hint: 'Выберите породу',
                        optionsMap: {
                          for (final sorted in _breedOptions.entries.sorted((a, b) => a.key.compareTo(b.key)))
                            sorted.key: sorted.value,
                        },
                        onChanged: (int selectedId) {
                          // автоматический выбор вида домашнего скота в соответствии с породой
                          final typeToSelect = widget.types
                              .firstWhereOrNull((e) => e.breeds.any((element) => element.id == selectedId))
                              ?.type;

                          if (typeToSelect != null) _selectedType.value = typeToSelect;
                        },
                        selectedOption: _selectedBreed,
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
                  DropdownTextFieldWidget<int>(
                    isRequired: true,
                    label: 'Способ добавления к поголовью',
                    hint: 'Выберите способ',
                    optionsMap: {
                      for (final additionType in widget.additionTypes) additionType.name.ru: additionType.type,
                    },
                    selectedOption: _selectedAdditionType,
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
