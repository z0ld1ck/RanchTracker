import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:malshy/core/const/app_colors.dart';
import 'package:malshy/features/auth/presentation/page/log_in_page.dart';

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
              Text(
                'Добро пожаловать в',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w600),
              ),
              Text(
                'MALSHI',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.w800,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(ScreenUtil().setWidth(10)),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LogInPage(),
                        ),
                      );
                    },
                    child: Container(
                      color: Color(0xff2EA1D9),
                      width: ScreenUtil().setWidth(330),
                      height: ScreenUtil().setHeight(45),
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
                borderRadius: BorderRadius.circular(ScreenUtil().setWidth(10)),
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
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Color(0xff2f8fd8),
                      ),
                    ),
                    width: ScreenUtil().setWidth(330),
                    height: ScreenUtil().setHeight(45),
                    child: Center(
                      child: Text(
                        'Зарегистрироваться',
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
