import 'dart:async';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:malshy/core/const/app_colors.dart';
import 'package:malshy/core/function/date_formatter.dart';
import 'package:malshy/features/app/app.dart';
import 'package:go_router/go_router.dart';
import 'package:malshy/core/navigation/route_names.dart';
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
  StreamController<Widget> overlayController =
      StreamController<Widget>.broadcast();
  late List<Map<String, dynamic>> typesData;
  late String typeName;

  final assets = const [
    Image(image: AssetImage('Screenshot_1.png')),
    Image(image: AssetImage('Screenshot_3.png')),
  ];

  String getSexText(int sex) {
    return sex == 1 ? "Самка" : (sex == 2 ? "Самец" : "Неизвестно");
  }

  @override
  Widget build(BuildContext context) {
    final List<String> imageUrls =
        widget.livestockModel.photos.map((photo) => photo.photo).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.livestockModel.rfid),
        actions: [
          IconButton(
            onPressed: () {
              context.pushNamed(
                RouteNames.editLivestock.name,
                extra: {
                  'types': widget.types,
                  'additionTypes': widget.additionTypes,
                  'livestockModel': widget.livestockModel,
                },
              );
            },
            icon: SvgPicture.asset('assets/icons/edit.svg'),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(alignment: AlignmentDirectional.center, children: [
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                height: 200,
                color: AppColors.blueLight,
              ),
            ),
            Container(
              width: 263,
              height: 175,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                onTap: () async {
                  if (imageUrls.isEmpty) {
                    return;
                  }
                  await SwipeImageGallery(
                    context: context,
                    itemCount: imageUrls.length,
                    initialIndex: 0,
                    hideStatusBar: false,
                    onSwipe: (index) {
                      overlayController.add(
                        _OverlayWidget(
                          title: '${index + 1}/${imageUrls.length}',
                        ),
                      );
                    },
                    initialOverlay: _OverlayWidget(
                      title: '1/${imageUrls.length}',
                    ),
                    overlayController: overlayController,
                    itemBuilder: (context, index) {
                      if (imageUrls.isEmpty) {
                        return Image.asset('assets/images/Screenshot_1.png');
                      }
                      return Image.network(
                        Uri.encodeFull(imageUrls.elementAt(index)),
                        errorBuilder: (context, _, __) {
                          return Center(
                            child: Text(
                              'error', //AppLocalizations.of(context)!.error.capitalize(),
                              // style: AppTextStyles.h1px18(context).copyWith(color: Colors.white),
                            ),
                          );
                        },
                      );
                    },
                  ).show();
                },
                child: Image.network(
                  imageUrls.isNotEmpty ? Uri.encodeFull(imageUrls.first) : '',
                ),
              ),
            ).paddingOnly(top:30.h),
          ]),
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
  const _OverlayWidget({required this.title});

  final String title;

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
        ],
      ),
    );
  }
}
