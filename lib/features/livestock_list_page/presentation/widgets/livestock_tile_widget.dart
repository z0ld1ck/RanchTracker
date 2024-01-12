import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:malshy/features/livestock_list_page/data/models/get_livestock_model.dart';

class LivestockTileWidget extends StatelessWidget {
  const LivestockTileWidget({
    super.key,
    required this.livestockModel,
  });

  final GetLivestockModel livestockModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/tag.svg',
                        width: 24.w,
                        height: 24.h,
                      ),
                      Text(
                        livestockModel.rfid ?? '',
                        style: TextStyle(
                          color: Color(0xFF1B1B1B),
                          fontSize: 14.sp,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ).paddingSymmetric(horizontal: 8.w),
                      Text(
                        livestockModel.sex == 0 ? '• Самец' : '• Самка',
                        style: TextStyle(
                          color: livestockModel.sex == 0 ? Color(0xFF2EA1D9) : Color(0xFFD52ED9),
                          fontSize: 14.sp,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ).paddingOnly(bottom: 8.h),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                        decoration: ShapeDecoration(
                          color: Color(0xFF2EA1D9),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/cow.svg',
                              width: 24.w,
                              height: 24.h,
                            ).paddingOnly(right: 8.w),
                            Text(
                              'Голштинская',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ).paddingOnly(right: 8.w),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                        decoration: ShapeDecoration(
                          color: Color(0xFF2EA1D9),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/scales.svg',
                              width: 24.w,
                              height: 24.h,
                            ).paddingOnly(right: 8.w),
                            Text(
                              '${livestockModel.weight?.toStringAsFixed(0) ?? ''} кг',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // VerticalDivider(
            //   width: 17.w,
            //   thickness: 1.w,
            //   color: Color(0xFFA7A7A7),
            // ),
            // Checkbox(
            //   visualDensity: VisualDensity.compact,
            //   value: true,
            //   onChanged: (_) {},
            // )
          ],
        ),
      ),
    );
  }
}
