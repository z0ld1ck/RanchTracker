import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:malshy/core/const/app_colors.dart';

Future<dynamic> showDateRangeTimePicker({
  required BuildContext context,
  required List<DateTime>? initialDates,
  required Function(List<DateTime?> dates) onSelect,
  DateTime? lastDate,
  DateTime? firstDate,
}) async {
  List<DateTime> dates = initialDates ??
      [
        DateTime.now(),
        DateTime.now(),
      ];
  int radioBttonIndex = initialDates == null ? 1 : -1;
  TextEditingController firstHour = TextEditingController(
      text: initialDates != null
          ? initialDates.first.hour < 10
              ? '0${initialDates.first.hour}'
              : '${initialDates.first.hour}'
          : '00');
  TextEditingController firstMinute = TextEditingController(
      text: initialDates != null
          ? initialDates.first.minute < 10
              ? '0${initialDates.first.minute}'
              : '${initialDates.first.minute}'
          : '00');
  TextEditingController secondHour = TextEditingController(
      text: initialDates != null
          ? initialDates.last.hour < 10
              ? '0${initialDates.last.hour}'
              : '${initialDates.last.hour}'
          : '23');
  TextEditingController secondMinute = TextEditingController(
      text: initialDates != null
          ? initialDates.last.minute < 10
              ? '0${initialDates.last.minute}'
              : '${initialDates.last.minute}'
          : '59');
  bool timeError1 = false;
  bool timeError2 = false;
  bool timeError3 = false;
  bool timeError4 = false;
  await showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, StateSetter setState) {
          return Dialog(
            elevation: 0,
            insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
            backgroundColor: Colors.transparent,
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Scrollbar(
                thumbVisibility: true,
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: AppColors.white,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(12.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  final startTime = TimeOfDay(
                                    hour: int.tryParse(firstHour.text) ?? 0,
                                    minute: int.tryParse(firstMinute.text) ?? 0,
                                  );
                                  final endTime = TimeOfDay(
                                    hour: int.tryParse(secondHour.text) ?? 0,
                                    minute: int.tryParse(secondMinute.text) ?? 0,
                                  );
                                  if (startTime.hour > endTime.hour ||
                                      (startTime.hour == endTime.hour && startTime.minute > endTime.minute)) {
                                    setState(() {
                                      secondHour.text = firstHour.text;
                                      secondMinute.text = firstMinute.text;
                                    });
                                  }
                                  setState(() {
                                    dates = [
                                      DateTime(
                                        DateTime.now().year,
                                        DateTime.now().month,
                                        DateTime.now().day,
                                        int.parse(firstHour.text),
                                        int.parse(firstMinute.text),
                                      ),
                                      DateTime(
                                        DateTime.now().year,
                                        DateTime.now().month,
                                        DateTime.now().day,
                                        int.parse(secondHour.text),
                                        int.parse(secondMinute.text),
                                      ),
                                    ];
                                    radioBttonIndex = 1;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Radio.adaptive(
                                      groupValue: 1,
                                      value: radioBttonIndex,
                                      visualDensity: VisualDensity.compact,
                                      onChanged: null,
                                    ),
                                    Text('Сегодня')
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  final startTime = TimeOfDay(
                                    hour: int.tryParse(firstHour.text) ?? 0,
                                    minute: int.tryParse(firstMinute.text) ?? 0,
                                  );
                                  final endTime = TimeOfDay(
                                    hour: int.tryParse(secondHour.text) ?? 0,
                                    minute: int.tryParse(secondMinute.text) ?? 0,
                                  );
                                  if (startTime.hour > endTime.hour ||
                                      (startTime.hour == endTime.hour && startTime.minute > endTime.minute)) {
                                    setState(() {
                                      secondHour.text = firstHour.text;
                                      secondMinute.text = firstMinute.text;
                                    });
                                  }
                                  setState(() {
                                    dates = [
                                      DateTime(
                                        DateTime.now().subtract(Duration(days: 1)).year,
                                        DateTime.now().subtract(Duration(days: 1)).month,
                                        DateTime.now().subtract(Duration(days: 1)).day,
                                        int.parse(firstHour.text),
                                        int.parse(firstMinute.text),
                                      ),
                                      DateTime(
                                        DateTime.now().subtract(Duration(days: 1)).year,
                                        DateTime.now().subtract(Duration(days: 1)).month,
                                        DateTime.now().subtract(Duration(days: 1)).day,
                                        int.parse(secondHour.text),
                                        int.parse(secondMinute.text),
                                      ),
                                    ];
                                    radioBttonIndex = 0;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Radio.adaptive(
                                      groupValue: 0,
                                      value: radioBttonIndex,
                                      visualDensity: VisualDensity.compact,
                                      onChanged: null,
                                    ),
                                    Text(
                                      'Вчера',
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  if (lastDate != null && lastDate.isAfter(DateTime.now())) {
                                    dates = [
                                      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day,
                                          int.parse(firstHour.text), int.parse(firstMinute.text)),
                                      DateTime(
                                          DateTime.now().add(Duration(days: 6)).year,
                                          DateTime.now().add(Duration(days: 6)).month,
                                          DateTime.now().add(Duration(days: 6)).day,
                                          int.parse(secondHour.text),
                                          int.parse(secondMinute.text)),
                                    ];
                                  } else {
                                    dates = [
                                      DateTime(
                                          DateTime.now().subtract(Duration(days: 6)).year,
                                          DateTime.now().subtract(Duration(days: 6)).month,
                                          DateTime.now().subtract(Duration(days: 6)).day,
                                          int.parse(firstHour.text),
                                          int.parse(firstMinute.text)),
                                      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day,
                                          int.parse(secondHour.text), int.parse(secondMinute.text)),
                                    ];
                                  }

                                  radioBttonIndex = 2;

                                  setState(() {});
                                },
                                child: Row(
                                  children: [
                                    Radio.adaptive(
                                      groupValue: 2,
                                      value: radioBttonIndex,
                                      visualDensity: VisualDensity.compact,
                                      onChanged: null,
                                    ),
                                    Text('7 дней')
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                          thickness: 1,
                          color: Color(0xFFA7A7A7),
                        ),
                        // calendar
                        CalendarDatePicker2(
                          config: CalendarDatePicker2Config(
                            // dayTextStyle: AppTextStyles.caption(context),
                            controlsTextStyle: TextStyle(
                              color: Color(0xFF1B1B1B),
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),
                            // TextStyle(fontSize: 16),
                            lastMonthIcon: ImageIcon(AssetImage('assets/icons/arrow_left.png')),
                            nextMonthIcon: ImageIcon(AssetImage('assets/icons/arrow_right.png')),
                            firstDayOfWeek: 1,
                            calendarType: CalendarDatePicker2Type.range,
                            firstDate: firstDate,
                            lastDate: lastDate ?? DateTime.now(),
                          ),
                          value: dates,
                          onValueChanged: (datesVal) {
                            radioBttonIndex = -1;

                            if (datesVal.length == 2) {
                              final isSameDay = datesVal.length == 2 &&
                                  datesVal[0]!.year == datesVal[1]!.year &&
                                  datesVal[0]!.month == datesVal[1]!.month &&
                                  datesVal[0]!.day == datesVal[1]!.day;

                              if (!isSameDay) {
                                final fh = int.tryParse(firstHour.text) ?? 0;
                                timeError1 = fh > 23 || fh < 0;
                                final fm = int.tryParse(firstMinute.text) ?? 0;
                                timeError2 = fm > 59 || fm < 0;
                                final sh = int.tryParse(secondHour.text) ?? 0;
                                timeError3 = sh > 23 || sh < 0;
                                final sm = int.tryParse(secondMinute.text) ?? 0;
                                timeError4 = sm > 59 || sm < 0;
                                setState(() {});
                              }

                              final startTime = TimeOfDay(
                                hour: int.tryParse(firstHour.text) ?? 0,
                                minute: int.tryParse(firstMinute.text) ?? 0,
                              );
                              final endTime = TimeOfDay(
                                hour: int.tryParse(secondHour.text) ?? 0,
                                minute: int.tryParse(secondMinute.text) ?? 0,
                              );
                              if (isSameDay && startTime.hour > endTime.hour) {
                                secondHour.text = firstHour.text;
                                if (startTime.minute > endTime.minute) {
                                  secondMinute.text = firstMinute.text;
                                }
                                dates = [
                                  DateTime(
                                    datesVal[0]!.year,
                                    datesVal[0]!.month,
                                    datesVal[0]!.day,
                                    int.parse(firstHour.text),
                                    int.parse(firstMinute.text),
                                  ),
                                  DateTime(
                                    datesVal[1]!.year,
                                    datesVal[1]!.month,
                                    datesVal[1]!.day,
                                    int.parse(firstHour.text),
                                    int.parse(secondMinute.text),
                                  ),
                                ];
                                timeError3 = false;
                                setState(() {});
                              } else if (isSameDay &&
                                  startTime.hour == endTime.hour &&
                                  startTime.minute > endTime.minute) {
                                secondMinute.text = firstMinute.text;
                                dates = [
                                  DateTime(
                                    datesVal[0]!.year,
                                    datesVal[0]!.month,
                                    datesVal[0]!.day,
                                    int.parse(firstHour.text),
                                    int.parse(firstMinute.text),
                                  ),
                                  DateTime(
                                    datesVal[1]!.year,
                                    datesVal[1]!.month,
                                    datesVal[1]!.day,
                                    int.parse(secondHour.text),
                                    int.parse(firstMinute.text),
                                  ),
                                ];
                                timeError4 = false;
                                setState(() {});
                              } else if (!timeError1 && !timeError2 && !timeError3 && !timeError4) {
                                dates = [
                                  DateTime(
                                    datesVal[0]!.year,
                                    datesVal[0]!.month,
                                    datesVal[0]!.day,
                                    int.parse(firstHour.text),
                                    int.parse(firstMinute.text),
                                  ),
                                  DateTime(
                                    datesVal[1]!.year,
                                    datesVal[1]!.month,
                                    datesVal[1]!.day,
                                    int.parse(secondHour.text),
                                    int.parse(secondMinute.text),
                                  ),
                                ];
                                setState(() {});
                              }
                            }
                          },
                        ),
                        Divider(
                          height: 1,
                          thickness: 1,
                          color: Color(0xFFA7A7A7),
                        ),
                        // time textfields
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ...[
                                SizedBox(
                                  width: 45.w,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      errorText: timeError1 ? '' : null,
                                      errorStyle: TextStyle(fontSize: 0),
                                      contentPadding: EdgeInsets.all(14.0),
                                      counterText: '',
                                    ),
                                    controller: firstHour,
                                    keyboardType: TextInputType.number,
                                    maxLength: 2,
                                    textInputAction: TextInputAction.next,
                                    onSubmitted: (p0) {
                                      firstMinute.selection =
                                          TextSelection(baseOffset: 0, extentOffset: firstMinute.value.text.length);
                                      setState(() {});
                                    },
                                    onTap: () {
                                      firstHour.selection =
                                          TextSelection(baseOffset: 0, extentOffset: firstHour.value.text.length);
                                    },
                                    onChanged: (val) {
                                      final temp = int.tryParse(val);
                                      if (temp == null) {
                                        timeError1 = true;
                                        setState(() {});
                                        return;
                                      } else if (temp > 23 || temp < 0) {
                                        timeError1 = true;
                                        setState(() {});
                                        return;
                                      } else {
                                        timeError1 = false;
                                      }

                                      final isSameDay = dates.length == 2 &&
                                          dates[0].year == dates[1].year &&
                                          dates[0].month == dates[1].month &&
                                          dates[0].day == dates[1].day;

                                      if (isSameDay) {
                                        final startTime = TimeOfDay(
                                          hour: int.tryParse(firstHour.text) ?? 0,
                                          minute: int.tryParse(firstMinute.text) ?? 0,
                                        );
                                        final endTime = TimeOfDay(
                                          hour: int.tryParse(secondHour.text) ?? 0,
                                          minute: int.tryParse(secondMinute.text) ?? 0,
                                        );

                                        if (isSameDay && startTime.hour > endTime.hour) {
                                          timeError1 = true;
                                        } else if (isSameDay &&
                                            startTime.hour == endTime.hour &&
                                            startTime.minute > endTime.minute) {
                                          timeError2 = true;
                                        } else {
                                          timeError1 = false;
                                          timeError2 = false;
                                          timeError3 = false;
                                          timeError4 = false;
                                          dates = [
                                            DateTime(
                                              dates.first.year,
                                              dates.first.month,
                                              dates.first.day,
                                              int.tryParse(firstHour.text) ?? 0,
                                              int.tryParse(firstMinute.text) ?? 0,
                                            ),
                                            DateTime(
                                              dates.last.year,
                                              dates.last.month,
                                              dates.last.day,
                                              int.tryParse(secondHour.text) ?? 0,
                                              int.tryParse(secondMinute.text) ?? 0,
                                            ),
                                          ];
                                        }
                                      }

                                      setState(() {});
                                      if (val.length == 2) {
                                        FocusScope.of(context).nextFocus();
                                        firstMinute.selection =
                                            TextSelection(baseOffset: 0, extentOffset: firstMinute.value.text.length);
                                        setState(() {});
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  ':',
                                  // style: AppTextStyles.paragraphSmall(context),
                                ),
                                SizedBox(width: 8),
                                SizedBox(
                                  width: 45.w,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      errorText: timeError2 ? '' : null,
                                      errorStyle: TextStyle(fontSize: 0),
                                      contentPadding: EdgeInsets.all(14.0),
                                      counterText: '',
                                    ),
                                    controller: firstMinute,
                                    keyboardType: TextInputType.number,
                                    maxLength: 2,
                                    textInputAction: TextInputAction.next,
                                    onSubmitted: (p0) {
                                      secondHour.selection =
                                          TextSelection(baseOffset: 0, extentOffset: secondHour.value.text.length);
                                      setState(() {});
                                    },
                                    onTap: () {
                                      firstMinute.selection =
                                          TextSelection(baseOffset: 0, extentOffset: firstMinute.value.text.length);
                                    },
                                    onChanged: (val) {
                                      final temp = int.tryParse(val);
                                      if (temp == null) {
                                        timeError2 = true;
                                        setState(() {});
                                        return;
                                      } else if (temp > 59 || temp < 0) {
                                        timeError2 = true;
                                        setState(() {});
                                        return;
                                      } else {
                                        timeError2 = false;
                                      }

                                      final isSameDay = dates.length == 2 &&
                                          dates[0].year == dates[1].year &&
                                          dates[0].month == dates[1].month &&
                                          dates[0].day == dates[1].day;

                                      if (isSameDay) {
                                        final startTime = TimeOfDay(
                                          hour: int.tryParse(firstHour.text) ?? 0,
                                          minute: int.tryParse(firstMinute.text) ?? 0,
                                        );
                                        final endTime = TimeOfDay(
                                          hour: int.tryParse(secondHour.text) ?? 0,
                                          minute: int.tryParse(secondMinute.text) ?? 0,
                                        );

                                        if (isSameDay && startTime.hour > endTime.hour) {
                                          timeError1 = true;
                                        } else if (isSameDay &&
                                            startTime.hour == endTime.hour &&
                                            startTime.minute > endTime.minute) {
                                          timeError2 = true;
                                        } else {
                                          timeError1 = false;
                                          timeError2 = false;
                                          timeError3 = false;
                                          timeError4 = false;
                                          dates = [
                                            DateTime(
                                              dates.first.year,
                                              dates.first.month,
                                              dates.first.day,
                                              int.tryParse(firstHour.text) ?? 0,
                                              int.tryParse(firstMinute.text) ?? 0,
                                            ),
                                            DateTime(
                                              dates.last.year,
                                              dates.last.month,
                                              dates.last.day,
                                              int.tryParse(secondHour.text) ?? 0,
                                              int.tryParse(secondMinute.text) ?? 0,
                                            ),
                                          ];
                                        }
                                      }

                                      setState(() {});
                                      if (val.length == 2) {
                                        FocusScope.of(context).nextFocus();
                                        secondHour.selection =
                                            TextSelection(baseOffset: 0, extentOffset: secondHour.value.text.length);
                                        setState(() {});
                                      }
                                    },
                                  ),
                                ),
                              ],
                              SizedBox(
                                height: 75,
                                width: 50,
                              ),
                              ...[
                                SizedBox(
                                  width: 45.w,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      errorText: timeError3 ? '' : null,
                                      errorStyle: TextStyle(fontSize: 0),
                                      contentPadding: EdgeInsets.all(14.0),
                                      counterText: '',
                                    ),
                                    controller: secondHour,
                                    keyboardType: TextInputType.number,
                                    maxLength: 2,
                                    textInputAction: TextInputAction.next,
                                    onSubmitted: (p0) {
                                      secondMinute.selection =
                                          TextSelection(baseOffset: 0, extentOffset: secondMinute.value.text.length);
                                      setState(() {});
                                    },
                                    onTap: () {
                                      secondHour.selection =
                                          TextSelection(baseOffset: 0, extentOffset: secondHour.value.text.length);
                                    },
                                    onChanged: (val) {
                                      final temp = int.tryParse(val);
                                      if (temp == null) {
                                        timeError3 = true;
                                        setState(() {});
                                        return;
                                      } else if (temp > 23 || temp < 0) {
                                        timeError3 = true;
                                        setState(() {});
                                        return;
                                      } else {
                                        timeError3 = false;
                                      }

                                      final isSameDay = dates.length == 2 &&
                                          dates[0].year == dates[1].year &&
                                          dates[0].month == dates[1].month &&
                                          dates[0].day == dates[1].day;
                                      if (isSameDay) {
                                        final startTime = TimeOfDay(
                                          hour: int.tryParse(firstHour.text) ?? 0,
                                          minute: int.tryParse(firstMinute.text) ?? 0,
                                        );
                                        final endTime = TimeOfDay(
                                          hour: int.tryParse(secondHour.text) ?? 0,
                                          minute: int.tryParse(secondMinute.text) ?? 0,
                                        );

                                        if (isSameDay && startTime.hour > endTime.hour) {
                                          timeError3 = true;
                                        } else if (isSameDay &&
                                            startTime.hour == endTime.hour &&
                                            startTime.minute > endTime.minute) {
                                          timeError4 = true;
                                        } else {
                                          timeError1 = false;
                                          timeError2 = false;
                                          timeError3 = false;
                                          timeError4 = false;
                                          dates = [
                                            DateTime(
                                              dates.first.year,
                                              dates.first.month,
                                              dates.first.day,
                                              int.tryParse(firstHour.text) ?? 0,
                                              int.tryParse(firstMinute.text) ?? 0,
                                            ),
                                            DateTime(
                                              dates.last.year,
                                              dates.last.month,
                                              dates.last.day,
                                              int.tryParse(secondHour.text) ?? 0,
                                              int.tryParse(secondMinute.text) ?? 0,
                                            ),
                                          ];
                                        }
                                      }

                                      setState(() {});
                                      if (val.length == 2) {
                                        FocusScope.of(context).nextFocus();
                                        secondMinute.selection =
                                            TextSelection(baseOffset: 0, extentOffset: secondMinute.value.text.length);
                                        setState(() {});
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  ':',
                                  // style: AppTextStyles.paragraphSmall(context),
                                ),
                                SizedBox(width: 8),
                                SizedBox(
                                  width: 45.w,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      errorText: timeError4 ? '' : null,
                                      errorStyle: TextStyle(fontSize: 0),
                                      contentPadding: EdgeInsets.all(14.0),
                                      counterText: '',
                                    ),
                                    controller: secondMinute,
                                    keyboardType: TextInputType.number,
                                    maxLength: 2,
                                    textInputAction: TextInputAction.next,
                                    onTap: () {
                                      secondMinute.selection =
                                          TextSelection(baseOffset: 0, extentOffset: secondMinute.value.text.length);
                                    },
                                    onChanged: (val) {
                                      final temp = int.tryParse(val);
                                      if (temp == null) {
                                        timeError4 = true;
                                        setState(() {});
                                        return;
                                      } else if (temp > 59 || temp < 0) {
                                        timeError4 = true;
                                        setState(() {});
                                        return;
                                      } else {
                                        timeError4 = false;
                                      }

                                      final isSameDay = dates.length == 2 &&
                                          dates[0].year == dates[1].year &&
                                          dates[0].month == dates[1].month &&
                                          dates[0].day == dates[1].day;

                                      if (isSameDay) {
                                        final startTime = TimeOfDay(
                                          hour: int.tryParse(firstHour.text) ?? 0,
                                          minute: int.tryParse(firstMinute.text) ?? 0,
                                        );
                                        final endTime = TimeOfDay(
                                          hour: int.tryParse(secondHour.text) ?? 0,
                                          minute: int.tryParse(secondMinute.text) ?? 0,
                                        );

                                        if (isSameDay && startTime.hour > endTime.hour) {
                                          timeError3 = true;
                                        } else if (isSameDay &&
                                            startTime.hour == endTime.hour &&
                                            startTime.minute > endTime.minute) {
                                          timeError4 = true;
                                        } else {
                                          timeError1 = false;
                                          timeError2 = false;
                                          timeError3 = false;
                                          timeError4 = false;
                                          dates = [
                                            DateTime(
                                              dates.first.year,
                                              dates.first.month,
                                              dates.first.day,
                                              int.tryParse(firstHour.text) ?? 0,
                                              int.tryParse(firstMinute.text) ?? 0,
                                            ),
                                            DateTime(
                                              dates.last.year,
                                              dates.last.month,
                                              dates.last.day,
                                              int.tryParse(secondHour.text) ?? 0,
                                              int.tryParse(secondMinute.text) ?? 0,
                                            ),
                                          ];
                                        }
                                      }

                                      setState(() {});
                                      if (val.length == 2) {
                                        FocusScope.of(context).unfocus();
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        if (timeError1 || timeError2 || timeError3 || timeError4)
                          Text(
                            'AppLocalizations.of(context)!.timeFormatErr',
                            // style: AppTextStyles.caption(context).copyWith(color: AppColors.error),
                          ),
                        // close
                        // SizedBox(
                        //   width: 300,
                        //   child: PrimaryButton(
                        //     text: AppLocalizations.of(context)!.confirm,
                        //     isDisabled: dates.length < 2,
                        //     onPress: () {
                        //       final isSameDay = dates.length == 2 &&
                        //           dates[0].year == dates[1].year &&
                        //           dates[0].month == dates[1].month &&
                        //           dates[0].day == dates[1].day;
                        //       final startTime = TimeOfDay(
                        //         hour: int.tryParse(firstHour.text) ?? 0,
                        //         minute: int.tryParse(firstMinute.text) ?? 0,
                        //       );
                        //       final endTime = TimeOfDay(
                        //         hour: int.tryParse(secondHour.text) ?? 0,
                        //         minute: int.tryParse(secondMinute.text) ?? 0,
                        //       );

                        //       if (isSameDay && startTime.hour > endTime.hour) {
                        //         timeError3 = true;
                        //         setState(() {});
                        //       } else if (isSameDay &&
                        //           startTime.hour == endTime.hour &&
                        //           startTime.minute > endTime.minute) {
                        //         timeError4 = true;
                        //         setState(() {});
                        //       } else if (!timeError1 && !timeError2 && !timeError3 && !timeError4) {
                        //         dates = [
                        //           DateTime(
                        //             dates.first.year,
                        //             dates.first.month,
                        //             dates.first.day,
                        //             int.parse(firstHour.text),
                        //             int.parse(firstMinute.text),
                        //           ),
                        //           DateTime(
                        //             dates.last.year,
                        //             dates.last.month,
                        //             dates.last.day,
                        //             int.parse(secondHour.text),
                        //             int.parse(secondMinute.text),
                        //           ),
                        //         ];

                        //         setState(() {});
                        //         onSelect(dates);
                        //         Navigator.pop(context);
                        //       }
                        //     },
                        //   ),
                        // ),
                        SizedBox(height: 8.0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
