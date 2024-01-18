import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:malshy/features/livestock/data/models/addition_type_model.dart';
import 'package:malshy/features/livestock/data/models/livestock_model.dart';
import 'package:malshy/features/livestock/data/models/type_model.dart';

class LivestockDetailsPage extends StatefulWidget {
  const LivestockDetailsPage({
    super.key,
    required this.livestockModel,
    required this.types,
    required this.additionTypes,
  });

  final List<TypeModel> types;
  final List<AdditionTypeModel> additionTypes;
  final LivestockModel livestockModel;

  @override
  State<LivestockDetailsPage> createState() => _LivestockDetailsPageState();
}

class _LivestockDetailsPageState extends State<LivestockDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.livestockModel.rfid),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('assets/icons/edit.svg'),
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Livestock Details',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
