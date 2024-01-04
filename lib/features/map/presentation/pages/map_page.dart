import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:malshy/features/cattle_list_page/presentation/widgets/search_bar_widget.dart';

import '../../../../core/const/app_colors.dart';
import '../widgets/cattle_counting_button.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              center: LatLng(50.97181272767628, 71.32178189582423),
              zoom: 17,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://mt1.google.com/vt/lyrs=y&x={x}&y={y}&z={z}',
                userAgentPackageName: 'com.example.app',
              ),
              PolygonLayer(
                polygons: [
                  Polygon(
                    points: [
                      LatLng(50.9727176196799, 71.32054145080292),
                      LatLng(50.972062298127405, 71.32357771150144),
                      LatLng(50.97150145172532, 71.32368497676917),
                      LatLng(50.9702312146473, 71.32283736277056),
                      LatLng(50.97099466934939, 71.31971531724152),
                    ],
                    color: AppColors.white.withOpacity(0.1),
                    borderStrokeWidth: 2,
                    borderColor: AppColors.white,
                    isFilled: true,
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(19, 16, 16, 0),
            child: CustomSearchBar(),
          ),
          Positioned(
            left:130,
            right:125,
            top:686,
            bottom: 12,
            child: CattleCountingButton(
              onPressed: () {},
              text: 'Пересчет скота',
            ),
          ),
        ],
      ),
    );
  }
}
