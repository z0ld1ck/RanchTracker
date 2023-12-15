// import 'package:flutter/material.dart';
// import 'package:malshy/features/app/app.dart';
// import 'package:malshy/features/auth/presentation/page/password_page.dart';
// import 'package:malshy/features/auth/presentation/page/sms_code_auth.dart';
//
// import 'auth.dart';
//
// class TestPage extends StatefulWidget {
//   const TestPage({Key? key}) : super(key: key);
//
//   @override
//   State<TestPage> createState() => _TestPageState();
// }
//
// class _TestPageState extends State<TestPage> {
//   int _currentIndex = 0;
//   final List<Widget> _widgets = [
//     AuthPage(),
//     SmSCodeAuthPage(),
//     PasswordPage(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Stack(
//         children: [
//           Positioned(
//             bottom: 460,
//             left: 0,
//             right: 0,
//             child: Transform.scale(
//               scale: 1.35,
//               child: Container(
//                 height: 600,
//                 width: size.width,
//                 decoration: BoxDecoration(
//                   color: Color(0xff1D297E),
//                   shape: BoxShape.circle,
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             top: 10,
//             left: (MediaQuery.of(context).size.width - 180) / 2,
//             child: Image.asset(
//               'assets/images/Screenshot_2.png',
//               height: 180,
//               width: 180,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
