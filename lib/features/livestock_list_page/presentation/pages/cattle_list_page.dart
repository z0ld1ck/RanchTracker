import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:malshy/core/const/app_colors.dart';
import 'package:malshy/core/const/app_icons.dart';
import 'package:malshy/core/navigation/route_names.dart';
import 'package:malshy/features/livestock_list_page/presentation/bloc/livestock_bloc.dart';
import '../widgets/add_cattle_button_widget.dart';

class CattleListPage extends StatefulWidget {
  const CattleListPage({super.key});

  @override
  State<CattleListPage> createState() => _CattleListPageState();
}

class _CattleListPageState extends State<CattleListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AddCattleButtonWidget(
        onPressed: () {
          context.read<LivestockBloc>().add(GetTypeAndBreed());
          context.pushNamed(RouteNames.addCattle.name);
        },
        text: 'Добавить животное',
      ),
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 50.h),
        child: AppBar(
          title: Text('Скот'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                // context.pushNamed(RouteNames.cattleListFilter.name);
              },
              icon: SvgPicture.asset(AppIcons.filter),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 26.h),
          TextField(
            decoration: InputDecoration(
              hintText: 'Поиск животных по ушной бирке и имени',
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              prefixIcon: Icon(Icons.search),
              contentPadding: EdgeInsets.symmetric(vertical: 10.h),
            ),
          ),
          SizedBox(
            height: 300.h,
          ),
          Center(
            child: Text(
              'Список пуст',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: AppColors.gray, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
