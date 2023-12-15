import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:malshy/core/navigation/nav_services.dart';
import 'package:malshy/features/auth/presentation/page/log_in_page.dart';
import 'package:malshy/features/auth/presentation/page/sms_code_auth.dart';
import 'package:malshy/features/auth/presentation/splash/splash_screen.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _name = TextEditingController();
    TextEditingController _number = TextEditingController();

    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (_, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Color(0xffebedff),
          body: Stack(
            children: [
              Positioned(
                bottom: ScreenUtil().setHeight(520),
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
                  margin: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  height: ScreenUtil().setHeight(450),
                  child: Column(
                    children: [
                      SizedBox(height: ScreenUtil().setHeight(25)),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                77, 0, 0, 0),
                            child: Text(
                              'Регистрация',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  fontSize: ScreenUtil().setSp(27),
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                17, 0, 0, 0),
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
                                size: ScreenUtil().setWidth(34),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 8),
                        child: Text(
                          'Введите номер телефона,и мы отправим вам код подтверждения',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: ScreenUtil().setSp(12),
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(ScreenUtil().setWidth(8)),
                        child: TextField(
                          controller: _name,
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: 'ФИО',
                            labelStyle: TextStyle(
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w200,
                              fontSize: 14,
                            ),
                            hintText: 'Введите ФИО',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(ScreenUtil().setWidth(8)),
                        child: TextField(
                          controller: _number,
                          decoration: InputDecoration(
                              labelText: 'Номер телефона',
                              labelStyle: TextStyle(
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w200,
                                fontSize: ScreenUtil().setSp(14),
                              ),
                              hintText: '+7 (777) 777 77 77'),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
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
                                  'Получить код подтверждения',
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
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                90, 0, 0, 0),
                            child: Text(
                              'Eсть аккаунт?',
                              style: TextStyle(
                                fontFamily: 'Gilroy',
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              navService.push(
                                MaterialPageRoute(
                                  builder: (_) => LogInPage(),
                                ),
                              );
                            },
                            child: Text(
                              'Войти',
                              style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      )
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
