import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:malshy/core/const/app_colors.dart';

import '../page/auth.dart';
import '../page/sms_code_auth.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (_, child) {
        return Scaffold(
          backgroundColor: AppColors.splash,
          body: Column(
            children: [
              SizedBox(height: 90),
              Transform.scale(
                scale: 0.5,
                child: Image.asset(
                  'assets/images/Screenshot_3.png',
                ),
              ),
              Text('Добро пожаловать в',style:TextStyle(
                fontSize: 30,
              ),),
              Text('Malshi'),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                child: ClipRRect(
                  borderRadius:
                  BorderRadius.circular(ScreenUtil().setWidth(20)),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AuthPage(),
                        ),
                      );
                    },
                    child: Container(
                      color: Color(0xffA8A8A8),
                      width: ScreenUtil().setWidth(330),
                      height: ScreenUtil().setHeight(60),
                      child: Center(
                        child: Text(
                          'Войти',
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: ScreenUtil().setSp(16),
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              ClipRRect(
                borderRadius:
                BorderRadius.circular(ScreenUtil().setWidth(20)),
                child: InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SmSCodeAuthPage(),
                      ),
                    );
                  },
                  child: Container(
                    color: Color(0xffA8A8A8),
                    width: ScreenUtil().setWidth(330),
                    height: ScreenUtil().setHeight(60),
                    child: Center(
                      child: Text(
                        'Войти',
                        style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontSize: ScreenUtil().setSp(16),
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
