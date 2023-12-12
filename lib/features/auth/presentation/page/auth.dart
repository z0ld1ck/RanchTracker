import 'package:flutter/material.dart';
import 'package:malshy/core/navigation/nav_services.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text(
              'Auth',
              style: TextStyle(color: Colors.black),
            ),
            TextButton(
              onPressed: () {
                navService.pushNamed('/');
              },
              child: Text(
                'go to home page',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
