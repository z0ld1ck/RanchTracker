import 'package:flutter/material.dart';

class SmSCodeAuthPage extends StatefulWidget {
  const SmSCodeAuthPage({super.key});

  @override
  State<SmSCodeAuthPage> createState() => _SmSCodeAuthPageState();
}

class _SmSCodeAuthPageState extends State<SmSCodeAuthPage> {
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
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(),
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
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 34,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(50, 0, 0, 0),
                          child: Text(
                            'Регистрация',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 8),
                    child: Text(
                      'Введите код, который мы отправили на номер +7 707 695 08 16',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ),
                  Form(
                    child: Column(
                      children: [
                        const SizedBox(height: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.15,
                              child: TextFormField(
                                obscureText: true,
                                style: const TextStyle(fontSize: 24),
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                onChanged: (value) {
                                  nextField(value, pin2FocusNode);
                                },
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.15,
                              child: TextFormField(
                                focusNode: pin2FocusNode,
                                obscureText: true,
                                style: const TextStyle(fontSize: 24),
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                onChanged: (value) =>
                                    nextField(value, pin3FocusNode),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.15,
                              child: TextFormField(
                                focusNode: pin3FocusNode,
                                style: const TextStyle(fontSize: 24),
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                onChanged: (value) =>
                                    nextField(value, pin4FocusNode),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.15,
                              child: TextFormField(
                                focusNode: pin4FocusNode,
                                style: const TextStyle(fontSize: 24),
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
                    onPressed: () {},
                    child: Text('Отправить обратно'),
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
