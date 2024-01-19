import 'dart:async';
import 'dart:io';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:malshy/core/const/app_colors.dart';
import 'package:malshy/core/function/date_formatter.dart';
import 'package:malshy/features/livestock/data/models/livestock_model.dart';
import 'package:swipe_image_gallery/swipe_image_gallery.dart';

class AddLivestockImageWidget extends StatefulWidget {
  const AddLivestockImageWidget({
    super.key,
    required this.images,
  });

  final List<File> images;

  @override
  State<AddLivestockImageWidget> createState() =>
      _AddLivestockImageWidgetState();
}

class _AddLivestockImageWidgetState extends State<AddLivestockImageWidget> {
  StreamController<Widget> overlayController =
      StreamController<Widget>.broadcast();

  @override
  void dispose() {
    overlayController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // открывается галерея
        InkWell(
          onTap: () async {
            if (widget.images.isEmpty) return;
            await SwipeImageGallery(
              context: context,
              itemCount: widget.images.length,
              initialIndex: 0,
              hideStatusBar: false,
              onSwipe: (index) {
                overlayController.add(
                  _OverlayWidget(
                    title: '${index + 1}/${widget.images.length}',
                    lastModified: widget.images.first
                        .lastModifiedSync()
                        .toDatetimeWithDots(),
                    deleteImage: () {
                      widget.images.removeAt(index);
                      setState(() {});
                    },
                  ),
                );
              },
              initialOverlay: _OverlayWidget(
                title: '1/${widget.images.length}',
                lastModified:
                    widget.images.first.lastModifiedSync().toDatetimeWithDots(),
                deleteImage: () {
                  widget.images.removeAt(0);
                  setState(() {});
                },
              ),
              overlayController: overlayController,
              itemBuilder: (context, index) {
                if (widget.images.isEmpty) return const SizedBox.shrink();
                return Image.file(
                  widget.images.elementAt(index),
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
          child: Stack(
            children: [
              CircleAvatar(
                radius: 42.w,
                backgroundColor: AppColors.primary(context),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: widget.images.isEmpty
                      ? SvgPicture.asset('assets/icons/cow_logo.svg')
                      : CircleAvatar(
                          radius: 42.w,
                          backgroundImage:
                              Image.file(widget.images.first).image,
                        ),
                ),
              ),
            ],
          ).paddingOnly(bottom: 16.h),
        ),
        // добавление фото
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              onTap: () async {
                FocusManager.instance.primaryFocus?.unfocus();
                await showModalBottomSheet(
                  context: context,
                  elevation: 0,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return Wrap(
                      children: [
                        Container(
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                          ),
                          child: Wrap(
                            children: [
                              InkWell(
                                onTap: () async {
                                  final ImagePicker picker = ImagePicker();
                                  final XFile? photo = await picker.pickImage(
                                      source: ImageSource.camera,
                                      imageQuality: 50);
                                  if (photo != null) {
                                    File file = File(photo.path);
                                    widget.images.add(file);
                                    // final isFirst = widget.images.isEmpty;
                                    // widget.images[file] = isFirst;
                                    setState(() {});
                                    if (context.mounted) Navigator.pop(context);
                                  }
                                },
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/camera.svg',
                                      width: 24.h,
                                      height: 24.h,
                                    ).paddingOnly(right: 8.w),
                                    Text(
                                      'Открыть камеру',
                                      style: TextStyle(
                                        color: Color(0xFF2EA1D9),
                                        fontSize: 16.sp,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                ).paddingSymmetric(
                                    horizontal: 12.w, vertical: 16.h),
                              ),
                              InkWell(
                                onTap: () async {
                                  final ImagePicker picker = ImagePicker();
                                  final photos = await picker.pickMultiImage(
                                      imageQuality: 50);
                                  for (int i = 0; i < photos.length; i++) {
                                    File file = File(photos[i].path);
                                    widget.images.add(file);
                                    // widget.images[file] = i == 0;
                                  }
                                  setState(() {});
                                  if (context.mounted) Navigator.pop(context);
                                },
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/gallery.svg',
                                      width: 24.h,
                                      height: 24.h,
                                    ).paddingOnly(right: 8.w),
                                    Text(
                                      'Выбрать из галереи',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF2EA1D9),
                                        fontSize: 16.sp,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ).paddingSymmetric(
                                    horizontal: 12.w, vertical: 16.h),
                              ),
                            ],
                          ),
                        ).paddingSymmetric(horizontal: 28.w),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            minimumSize: Size(double.infinity, 48.h),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.r)),
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Отмена',
                            style: TextStyle(
                              color: Color(0xFF1B1B1B),
                              fontSize: 16.sp,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ).paddingSymmetric(horizontal: 28.w, vertical: 12.h)
                      ],
                    );
                  },
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 4.h),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 5,
                    style: BorderStyle.solid,
                    strokeAlign: BorderSide.strokeAlignOutside,
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(24.r),
                  color: AppColors.primary(context),
                ),
                child: SvgPicture.asset('assets/icons/add_photo.svg'),
              ),
            ),
          ),
        ),
      ],
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
