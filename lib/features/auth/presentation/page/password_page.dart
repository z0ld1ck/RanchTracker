import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:malshy/features/auth/presentation/page/sms_code_auth.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage>{
  TextEditingController _passwordController = TextEditingController();
  bool _obsecureText = true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
            bottom: ScreenUtil().setHeight(420),
            left: 0,
            right: 0,
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
            left: (ScreenUtil().screenWidth - ScreenUtil().setWidth(180)) / 2,
            child: Image.asset(
              'assets/images/Screenshot_1.png',
              height:ScreenUtil().setHeight(180),
              width:ScreenUtil().setWidth(180),
            ),
          ),
          Positioned(
            top: ScreenUtil().setHeight(201),
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
                  SizedBox(height:ScreenUtil().setHeight(25)),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SmSCodeAuthPage(),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: ScreenUtil().setSp(34),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              50, 0, 0, 0),
                          child: Text(
                            'Новый пароль',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize:ScreenUtil().setSp(24),
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      obscureText: _obsecureText,
                      controller: _passwordController,
                      maxLines: 1,
                      decoration: InputDecoration(
                        labelText: 'Пароль',
                        labelStyle: TextStyle(
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w200,
                          fontSize:ScreenUtil().setSp(14),
                        ),
                        hintText: 'Введите пароль',
                        suffixIcon: IconButton(
                          icon: Icon(
                              _obsecureText ? Icons.visibility_off : Icons
                                  .visibility, color: Colors.grey),
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
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      obscureText: true,
                      // controller: _number,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obsecureText ? Icons.visibility_off : Icons
                                  .visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _obsecureText = !_obsecureText;
                              });
                            },
                          ),
                          labelText: 'Повторите пароль',
                          labelStyle: TextStyle(
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w200,
                            fontSize:ScreenUtil().setSp(14),
                          ),
                          hintText: 'Повторите пароль'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0, 16, 0, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
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
                          height:ScreenUtil().setHeight(60),
                          child: Center(
                            child: Text(
                              'Сохранить',
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
