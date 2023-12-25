import 'package:flutter/material.dart';

import '../../../core/const/app_colors.dart';


class Events extends StatefulWidget {
  const Events({Key? key}) : super(key: key);

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blueLight,
      body: Column(
        children: const [
          Center(
            child: Text('Map'),
          )
        ],
      ),
    );
  }
}
