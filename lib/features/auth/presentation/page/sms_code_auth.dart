import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:malshy/core/navigation/nav_services.dart';
import 'package:malshy/features/auth/presentation/page/auth.dart';
import 'package:malshy/features/auth/presentation/page/password_page.dart';

class SmSCodeAuthPage extends StatefulWidget {
  const SmSCodeAuthPage({super.key});

  @override
  State<SmSCodeAuthPage> createState() => _SmSCodeAuthPageState();
}

class _SmSCodeAuthPageState extends State<SmSCodeAuthPage> {
  final TextEditingController _first = TextEditingController();
  final TextEditingController _second = TextEditingController();
  final TextEditingController _third = TextEditingController();
  final TextEditingController _fourth = TextEditingController();

  late FocusNode pinFocusNode;
  late FocusNode pin2FocusNode;
  late FocusNode pin3FocusNode;
  late FocusNode pin4FocusNode;

  @override
  void initState() {
    super.initState();
    pinFocusNode = FocusNode();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pinFocusNode.dispose();
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
  }

  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }


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
                  bottom: ScreenUtil().setHeight(420),
                  child: Transform.scale(
                    scale: 1.35,
                    child: Container(
                      height: ScreenUtil().setHeight(600),
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
                      (ScreenUtil().screenWidth - ScreenUtil().setWidth(180)) /
                          2,
                  child: Image.asset(
                    'assets/images/Screenshot_1.png',
                    height: 180,
                    width: 180,
                  ),
                ),
                Positioned(
                  top: ScreenUtil().setHeight(191),
                  left: 16,
                  right: 16,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    height: ScreenUtil().setHeight(450),
                    child: Column(
                      children: [
                        SizedBox(height: ScreenUtil().setHeight(25)),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => AuthPage(),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  size: ScreenUtil().setSp(34),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(50, 0, 0, 0),
                                child: Text(
                                  'Регистрация',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Gilroy',
                                      fontSize: ScreenUtil().setSp(24),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 8),
                          child: Text(
                            'Введите код, который мы отправили на номер +7 707 695 08 16',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontSize: ScreenUtil().setSp(14),
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ),
                        Form(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width: ScreenUtil().screenWidth * 0.15,
                                    child: TextFormField(
                                      controller: _first,
                                      style: TextStyle(
                                          fontSize: ScreenUtil().setSp(24)),
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      onChanged: (value) {
                                        nextField(value, pin2FocusNode);
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: ScreenUtil().screenWidth * 0.15,
                                    child: TextFormField(
                                      controller: _second,
                                      focusNode: pin2FocusNode,
                                      style: TextStyle(
                                          fontSize: ScreenUtil().setSp(24)),
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      onChanged: (value) =>
                                          nextField(value, pin3FocusNode),
                                    ),
                                  ),
                                  SizedBox(
                                    width: ScreenUtil().screenWidth * 0.15,
                                    child: TextFormField(
                                      controller: _third,
                                      focusNode: pin3FocusNode,
                                      style: TextStyle(
                                          fontSize: ScreenUtil().setSp(24)),
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      onChanged: (value) =>
                                          nextField(value, pin4FocusNode),
                                    ),
                                  ),
                                  SizedBox(
                                    width: ScreenUtil().screenWidth * 0.15,
                                    child: TextFormField(
                                      controller: _fourth,
                                      focusNode: pin4FocusNode,
                                      style: TextStyle(
                                          fontSize: ScreenUtil().setSp(24)),
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      onChanged: (value) {
                                        if (value.length == 1) {
                                          pin4FocusNode.unfocus();
                                          // Then you need to check is the code is correct or not
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            navService.push(
                              MaterialPageRoute(
                                builder: (_) => PasswordPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Отправить заново',
                            style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
