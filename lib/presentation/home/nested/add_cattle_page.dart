import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/const/app_icons.dart';
import '../../../core/navigation/nav_services.dart';
import '../../../core/routes/global_routes.dart';

class AddCattlePage extends StatefulWidget {
  const AddCattlePage({Key? key}) : super(key: key);

  @override
  State<AddCattlePage> createState() => _AddCattlePageState();
}

class _AddCattlePageState extends State<AddCattlePage> {
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
          actions: [
            IconButton(
              onPressed: () {
                navService.pushNamed(GlobalRoutes.filter);
              },
              icon: Icon(Icons.filter_alt),
            ),
          ],
        ),
      ),
      body: Container(
        decoration:BoxDecoration(
          shape:BoxShape.circle,
        ) ,
        child: IconButton(
          icon: SvgPicture.asset(AppIcons.avatar),
          onPressed: () {

          },
        ),
      ),
    );
  }
}
