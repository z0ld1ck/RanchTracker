import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:malshy/core/const/app_colors.dart';
import 'package:malshy/features/app/app.dart';
import 'package:malshy/features/livestock/data/models/addition_type_model.dart';
import 'package:malshy/features/livestock/data/models/livestock_model.dart';
import 'package:malshy/features/livestock/data/models/type_model.dart';
import 'package:malshy/features/livestock/presentation/widgets/clipper_widget.dart';
import 'package:swipe_image_gallery/swipe_image_gallery.dart';
import 'dart:io';
import '../../../../core/models/localized_string_model.dart';

class LivestockDetailsPage extends StatefulWidget {
  const LivestockDetailsPage({
    super.key,
    required this.livestockModel,
    required this.types,
    required this.additionTypes,
  });

  final List<TypeModel> types;
  final List<AdditionTypeModel> additionTypes;
  final LivestockModel livestockModel;

  @override
  State<LivestockDetailsPage> createState() => _LivestockDetailsPageState();
}

class _LivestockDetailsPageState extends State<LivestockDetailsPage> {
  late List<Map<String, dynamic>> typesData;
  late String typeName;
  late final List<File> images;

  final assets = const [
    Image(image: AssetImage('Screenshot_1.png')),
    Image(image: AssetImage('Screenshot_3.png')),
  ];

  String getSexText(int sex) {
    return sex == 1 ? "Самка" : (sex == 2 ? "Самец" : "Неизвестно");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.livestockModel.rfid),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('assets/icons/edit.svg'),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              ClipPath(
                clipper: MyClipper(),
                child: Container(
                  height: 200,
                  color: AppColors.blueLight,
                ),
              ),
              Container(
                color: Colors.grey,
                width: 263.w,
                height: 175.h,
                child: InkWell(
                  onTap: () {},
                ),
              ).paddingOnly(top: 50),
            ],
          ),
          Text(
            widget.livestockModel.nickname.toString(),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 20,
                ),
          ),
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/tag.svg',
                width: 24.w,
                height: 24.h,
              ),
              Text(
                widget.livestockModel.rfid,
                style: TextStyle(
                  color: Color(0xFF1B1B1B),
                  fontSize: 14.sp,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ).paddingSymmetric(horizontal: 8.w),
            ],
          ).paddingOnly(bottom: 8.h, left: 130.w),
          Row(
            children: [
              Container(
                width: 95.w,
                height: 60.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: AppColors.blueLight,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Возраст",
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            widget.livestockModel.age.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w600),
                          ),
                        ),
                        Text(
                          ' лет',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
              ).paddingOnly(left: 16.w),
              Container(
                width: 95.w,
                height: 60.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: AppColors.blueLight,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Пол",
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        getSexText(widget.livestockModel.sex),
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ).paddingOnly(left: 16.w),
              Container(
                width: 95.w,
                height: 60.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: AppColors.blueLight,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Порода",
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Голштинкая',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ).paddingOnly(left: 16.w),
            ],
          ).paddingAll(16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Вес',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.black, fontWeight: FontWeight.w600),
              ),
              Text('${widget.livestockModel.weight.toString()} кг'),
            ],
          ).paddingOnly(
            bottom: 12.h,
            left: 32,
            right: 28,
            top: 24,
          ),
          Divider(
            indent: 28,
            endIndent: 28,
            color: AppColors.grayLight,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Способ добавления к \nпоголовью',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.black, fontWeight: FontWeight.w600),
              ),
              Text(widget.livestockModel.additionMethod.toString()),
            ],
          ).paddingOnly(
            bottom: 12.h,
            left: 32,
            right: 28,
          ),
          Divider(
            indent: 28,
            endIndent: 28,
            color: AppColors.grayLight,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Бирка матери',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.black, fontWeight: FontWeight.w600),
              ),
              Text(widget.livestockModel.motherRfid.toString()),
            ],
          ).paddingOnly(
            bottom: 12.h,
            left: 32,
            right: 28,
          ),
          Divider(
            indent: 28,
            endIndent: 28,
            color: AppColors.grayLight,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Бирка отца',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.black, fontWeight: FontWeight.w600),
              ),
              Text(widget.livestockModel.fatherRfid.toString()),
            ],
          ).paddingOnly(
            bottom: 12.h,
            left: 32,
            right: 28,
          ),
        ],
      ),
    );
  }
}

class _OverlayWidget extends StatelessWidget {
  const _OverlayWidget({
    super.key,
    required this.title,
    required this.lastModified,
    this.deleteImage,
  });

  final String title;
  final String lastModified;
  final Function()? deleteImage;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: IconButton(
                  iconSize: 24.h,
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Image.asset(
                    'assets/icons/arrow_left.png',
                    height: 24.h,
                    width: 24.h,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ).paddingAll(16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {},
                child: SvgPicture.asset(
                  'assets/icons/share.svg',
                  height: 24.h,
                  width: 24.h,
                ),
              ),
              Text(
                lastModified,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ).expanded(),
              if (deleteImage != null)
                InkWell(
                  onTap: () async {
                    deleteImage!();
                    if (context.mounted) Navigator.pop(context);
                  },
                  child: SvgPicture.asset(
                    'assets/icons/delete.svg',
                    height: 24.h,
                    width: 24.h,
                  ),
                ),
            ],
          ).paddingSymmetric(vertical: 12.h, horizontal: 16.w)
        ],
      ),
    );
  }
}
