import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:malshy/core/const/app_colors.dart';
import 'package:malshy/core/widgets/primary_button.dart';
import 'package:malshy/features/cattle_list_page/presentation/widgets/add_cattle_dropdown.dart';
import 'package:malshy/features/cattle_list_page/presentation/widgets/gender_radio_buttons.dart';
import '../../../../core/const/app_icons.dart';
import '../../../../core/navigation/nav_services.dart';
import '../../../../core/routes/global_routes.dart';

class AddCattlePage extends StatefulWidget {
  const AddCattlePage({super.key});

  @override
  State<AddCattlePage> createState() => _AddCattlePageState();
}

class _AddCattlePageState extends State<AddCattlePage> {
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

  // @override
  // void dispose() {
  //   super.dispose();
  //   RFD.dispose();
  //   cattleName.dispose();
  //   dateInput.dispose();
  //   weight.dispose();
  //   RFIDm.dispose();
  //   RFIDf.dispose();
  // }

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
              navService.pushNamed(GlobalRoutes.nav);
            },
            icon: SvgPicture.asset(AppIcons.back),
          ),
        ),
      ),
      body: SingleChildScrollView(
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
              padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
              child: TextField(
                controller: RFD,
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: 'Ушная бирка(RFD)*',
                  labelStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.black),
                  hintText: 'Введите ушную бирку',
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
              padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
              child: TextField(
                controller: cattleName,
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: 'Кличка',
                  labelStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.black),
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
              padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
              child: TextField(
                controller: dateInput,
                maxLines: 1,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: SvgPicture.asset(AppIcons.date),
                    onPressed: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: date,
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      );
                      if (selectedDate != null) {
                        String formattedDate =
                            DateFormat.yMd().format(selectedDate);

                        setState(() {
                          dateInput.text = formattedDate;
                        });
                      }
                    },
                  ),
                  labelText: 'Дата рождения',
                  labelStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.black),
                  hintText: 'Выберите дату',
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
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
              child: AddCattleDropDown(
                items: const [
                  DropdownMenuItem(
                    value: "КРС",
                    child: Text("КРС"),
                  ),
                  DropdownMenuItem(
                    value: "МРС",
                    child: Text("МРС"),
                  ),
                  DropdownMenuItem(
                    value: "Лошади",
                    child: Text("Лошади"),
                  ),
                ],
                label: 'Виды',
                hint: 'Выберите вид',
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Container(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
              child: AddCattleDropDown(
                items: [
                  DropdownMenuItem(
                    value: "Голштинская",
                    child: Text("Голштинская"),
                  ),
                  DropdownMenuItem(
                    value: "Швицкая",
                    child: Text("Швицкая"),
                  ),
                  DropdownMenuItem(
                    value: "породы",
                    child: InkWell(
                      onTap: () {},
                      child: SizedBox(
                        width: double.infinity,
                        height: 48.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AppIcons.add_blue,
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            Text(
                              'Добавить новую породу',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: AppColors.blueLight,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
                label: 'Породы',
                hint: 'Выберите породу',
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
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
                    children: const [
                      GenderRadioButton(),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
              child: TextField(
                controller: weight,
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: 'Вес',
                  labelStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.black),
                  hintText: 'Введите текст',
                  suffixText: 'кг',
                  suffixStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.w400,
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
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
              child: AddCattleDropDown(
                hint: 'Выберите способ',
                items: const [
                  DropdownMenuItem(
                    value: "КРС",
                    child: Text("КРС"),
                  ),
                  DropdownMenuItem(
                    value: "МРС",
                    child: Text("МРС"),
                  ),
                  DropdownMenuItem(
                    value: "Лошади",
                    child: Text("Лошади"),
                  ),
                ],
                label: 'Способ добавления к поголовью*',
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
                  labelStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.black),
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
                  labelStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.black),
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
              onPressed: () {},
            ),
            SizedBox(
              height: 30.h,
            ),
          ],
        ),
      ),
    );
  }
}
