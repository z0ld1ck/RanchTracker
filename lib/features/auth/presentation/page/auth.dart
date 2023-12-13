import 'package:flutter/material.dart';
import 'package:malshy/core/navigation/nav_services.dart';

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

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffebedff),
      appBar: AppBar(),
      body: Stack(
        children: [
          Positioned(
            bottom: 580,
            left: 0,
            right: 0,
            child: Transform.scale(
              scale: 1.5,
              child: Container(
                height: 400,
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
              margin: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
              height: 450,
              child: Column(
                children: [
                  SizedBox(height: 25),
                  Row(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(85, 0, 0, 0),
                        child: Text(
                          'Регистрация',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 27, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(37, 0, 0, 0),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.close,
                            size: 34,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 8),
                    child: Text(
                      'Введите номер телефона,и мы отправим вам код подтверждения',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _name,
                      maxLines: 1,
                      decoration: InputDecoration(
                        labelText: 'ФИО',
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 14,
                        ),
                        hintText: 'Введите ФИО',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _number,
                      decoration: InputDecoration(
                          labelText: 'Номер телефона',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 14,
                          ),
                          hintText: '+7 (777) 777 77 77'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          color: Color(0xffA8A8A8),
                          width: 330,
                          height: 60,
                          child: Center(
                            child: Text(
                              'Получить код подтверждения',
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
                  Row(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(90, 0, 0, 0),
                        child: Text('Eсть аккаунт?'),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text('Войти'),
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
  }
}
