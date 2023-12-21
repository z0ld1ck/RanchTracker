import 'package:flutter/material.dart';
import 'package:malshy/core/const/app_colors.dart';
import 'package:malshy/presentation/home/pages/profile.dart';

import '../widgets/bottom_navbar.dart';
import 'cattle_list_page.dart';
import 'map_page.dart';
import 'events_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.deepOrangeAccent,
    );
  }
}
