import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:malshy/core/services/shared_pref.dart';
import 'package:malshy/features/auth/presentation/page/auth.dart';
import 'package:malshy/features/auth/presentation/page/sms_code_auth.dart';
import 'package:malshy/features/auth/presentation/splash/splash_screen.dart';

import '../../../../core/navigation/nav_services.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final TextEditingController _number = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool _obsecureText = true;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (_, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Positioned(
                bottom: ScreenUtil().setHeight(520),
                left: 0,
                right: 0,
                child: Transform.scale(
                  scale: 1.35,
                  child: Container(
                    height: ScreenUtil().setHeight(400),
                    width: ScreenUtil().screenWidth,
                    decoration: BoxDecoration(
                      color: Color(0xff2EA1D9),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: ScreenUtil().setHeight(30),
                left:
                    (ScreenUtil().screenWidth - ScreenUtil().setWidth(180)) / 2,
                child: Image.asset(
                  'assets/images/Screenshot_1.png',
                  height: ScreenUtil().setHeight(180),
                  width: ScreenUtil().setWidth(180),
                ),
              ),
              Positioned(
                top: ScreenUtil().setHeight(201),
                left: ScreenUtil().setWidth(16),
                right: ScreenUtil().setWidth(16),
                child: Container(
                  padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().setWidth(30)),
                    color: Colors.white,
                  ),
                  height: ScreenUtil().setHeight(450),
                  child: Column(
                    children: [
                      SizedBox(
                        height: ScreenUtil().setHeight(25),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            child: Text(
                              'Войти',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(80, 0, 0, 0),
                            child: IconButton(
                              onPressed: () {
                                navService.push(
                                  MaterialPageRoute(
                                    builder: (_) => Splash(),
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.close,
                                size: ScreenUtil().setWidth(30),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(ScreenUtil().setWidth(8)),
                        child: TextField(
                          controller: _number,
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: 'Номер телефона',
                            labelStyle: TextStyle(
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w200,
                              fontSize: ScreenUtil().setSp(14),
                            ),
                            hintText: '+7 (777) 777 77 77',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(ScreenUtil().setWidth(8)),
                        child: TextField(
                          obscureText: _obsecureText,
                          controller: _password,
                          decoration: InputDecoration(
                            labelText: 'Пароль',
                            labelStyle: TextStyle(
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w200,
                              fontSize: ScreenUtil().setSp(14),
                            ),
                            hintText: 'Введите пароль',
                            suffixIcon: IconButton(
                              icon: Icon(
                                  _obsecureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.grey),
                              onPressed: () {
                                setState(() {
                                  _obsecureText = !_obsecureText;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0, ScreenUtil().setHeight(16), 0, 0),
                        child: ClipRRect(
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
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                ScreenUtil().setWidth(40), 0, 0, 0),
                            child: Text(
                              'Нет аккаунта?',
                              style: TextStyle(
                                fontFamily: 'Gilroy',
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              navService.push(
                                MaterialPageRoute(
                                  builder: (_) => AuthPage(),
                                ),
                              );
                            },
                            child: Text(
                              'Зарегистрироваться',
                              style: TextStyle(
                                fontFamily: 'Gilroy',
                                color: Color(0xff2EA1D9),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                ScreenUtil().setWidth(50), 0, 0, 0),
                            child: Text(
                              'Забыли пароль?',
                              style: TextStyle(
                                fontFamily: 'Gilroy',
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'Восстановить',
                              style: TextStyle(
                                fontFamily: 'Gilroy',
                                color: Color(0xff2EA1D9),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
