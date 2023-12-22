import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/const/app_icons.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
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
