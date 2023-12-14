import 'package:flutter/material.dart';
import 'package:malshy/features/auth/presentation/page/sms_code_auth.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  TextEditingController _passwordController = TextEditingController();
  bool _obsecureText = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 460,
            left: 0,
            right: 0,
            child: Transform.scale(
              scale: 1.35,
              child: Container(
                height: 600,
                width: size.width,
                decoration: BoxDecoration(
                  color: Color(0xff1D297E),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: (MediaQuery.of(context).size.width - 180) / 2,
            child: Image.asset(
              'assets/images/Screenshot_2.png',
              height: 180,
              width: 180,
            ),
          ),
          Positioned(
            top: 181,
            left: 16,
            right: 16,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              height: 450,
              child: Column(
                children: [
                  SizedBox(height: 25),
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
                            size: 34,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(50, 0, 0, 0),
                          child: Text(
                            'Новый пароль',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
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
                          fontWeight: FontWeight.w200,
                          fontSize: 14,
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
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      obscureText: true,
                      // controller: _number,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                                _obsecureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey,),
                            onPressed: () {
                              setState(() {
                                _obsecureText = !_obsecureText;
                              });
                            },
                          ),
                          labelText: 'Повторите пароль',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 14,
                          ),
                          hintText: 'Повторите пароль'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
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
                          width: 330,
                          height: 60,
                          child: Center(
                            child: Text(
                              'Сохранить',
                              style: TextStyle(
                                fontSize: 16,
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
