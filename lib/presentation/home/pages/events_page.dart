import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:malshy/presentation/home/pages/profile.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/const/app_icons.dart';
import 'cattle_list_page.dart';
import 'dashboard_page.dart';
import 'package:malshy/presentation/home/pages/events_page.dart';

import 'map_page.dart';

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
