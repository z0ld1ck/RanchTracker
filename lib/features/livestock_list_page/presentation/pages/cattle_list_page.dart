import 'dart:async';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:malshy/core/const/app_colors.dart';
import 'package:malshy/core/const/app_icons.dart';
import 'package:malshy/core/navigation/route_names.dart';
import 'package:malshy/features/livestock_list_page/data/models/get_livestock_model.dart';
import 'package:malshy/features/livestock_list_page/presentation/bloc/cattle_list_pagination_bloc.dart';
import 'package:malshy/features/livestock_list_page/presentation/widgets/livestock_tile_widget.dart';
import '../widgets/add_cattle_button_widget.dart';

class CattleListPage extends StatefulWidget {
  const CattleListPage({super.key});

  @override
  State<CattleListPage> createState() => _CattleListPageState();
}

class _CattleListPageState extends State<CattleListPage> {
  // pagination
  final CattleListPaginationBloc _paginationBloc = CattleListPaginationBloc();
  final PagingController<int, GetLivestockModel> _pagingController = PagingController(firstPageKey: 1);
  late StreamSubscription _blocListingStateSubscription;

  // search
  Timer? _debounce;

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _paginationBloc.onPageRequestSink.add(pageKey);
    });
    _blocListingStateSubscription = _paginationBloc.onNewListingState.listen((listingState) {
      _pagingController.value = PagingState(
        nextPageKey: listingState.nextPageKey,
        error: listingState.error,
        itemList: listingState.itemList,
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    _paginationBloc.dispose();
    _pagingController.dispose();
    _blocListingStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AddCattleButtonWidget(
        onPressed: () {
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
                context.pushNamed(RouteNames.cattleListFilter.name);
              },
              icon: SvgPicture.asset(AppIcons.filter),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (String value) {
              if (_debounce?.isActive ?? false) _debounce!.cancel();
              _debounce = Timer(
                const Duration(milliseconds: 300),
                () {
                  _paginationBloc.onSearchInputChangedSink.add(value);
                },
              );
            },
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
            decoration: InputDecoration(
              fillColor: Colors.white,
              hintText: 'Поиск животных по ушной бирке и имени',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12.r),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primary(context), width: 2.w),
                borderRadius: BorderRadius.circular(12.r),
              ),
              prefixIconConstraints: BoxConstraints(minWidth: 48.w, minHeight: 24.h),
              prefixIcon: SvgPicture.asset('assets/icons/search.svg').paddingSymmetric(horizontal: 12.w),
            ),
          ).paddingAll(16.w),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                _pagingController.itemList?.clear();
                _pagingController.refresh();
              },
              child: PagedListView<int, GetLivestockModel>(
                pagingController: _pagingController,
                shrinkWrap: true,
                builderDelegate: PagedChildBuilderDelegate<GetLivestockModel>(
                  newPageErrorIndicatorBuilder: (context) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        'asdf',
                        // AppLocalizations.of(context)!.error.capitalize(),
                        textAlign: TextAlign.center,
                        // style: AppTextStyles.h3px14(context).copyWith(
                        //   color: Color(0xFF868882),
                        // ),
                      ),
                    );
                  },
                  firstPageErrorIndicatorBuilder: (context) {
                    return Text('qwer');
                  },
                  noItemsFoundIndicatorBuilder: (context) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        'zxcv',
                        // AppLocalizations.of(context)!.noData.capitalize(),
                        textAlign: TextAlign.center,
                        // style: AppTextStyles.h3px14(context).copyWith(
                        //   color: Color(0xFF868882),
                        // ),
                      ),
                    );
                  },
                  itemBuilder: (context, item, index) {
                    return LivestockTileWidget(livestockModel: item).paddingOnly(
                      bottom: 8.h,
                      left: 16.w,
                      right: 16.w,
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
