import 'dart:async';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:malshy/core/const/app_colors.dart';
import 'package:malshy/core/const/app_icons.dart';
import 'package:malshy/core/navigation/route_names.dart';
import 'package:malshy/features/livestock/data/models/livestock_model.dart';
import 'package:malshy/features/livestock/presentation/bloc/filter_livestock/filter_livestock_bloc.dart';
import 'package:malshy/features/livestock/presentation/bloc/livestock_list_pagination_bloc.dart';
import 'package:malshy/features/livestock/presentation/widgets/livestock_tile_widget.dart';
import '../widgets/add_cattle_button_widget.dart';

class LivestockListPage extends StatefulWidget {
  const LivestockListPage({super.key});

  @override
  State<LivestockListPage> createState() => _LivestockListPageState();
}

class _LivestockListPageState extends State<LivestockListPage> {
  // pagination
  final LivestockListPaginationBloc _paginationBloc = LivestockListPaginationBloc();
  final PagingController<int, LivestockModel> _pagingController = PagingController(firstPageKey: 1);
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
    return BlocListener<FilterLivestockBloc, FilterLivestockState>(
      listenWhen: (previous, current) => previous.status == current.status,
      listener: (context, state) {
        _paginationBloc.onFilterChangedSink.add(state);
      },
      child: Scaffold(
        floatingActionButton: AddCattleButtonWidget(
          onPressed: () {
            final filterBloc = context.read<FilterLivestockBloc>();
            if (filterBloc.state.status == FilterLivestockStatus.success) {
              context.pushNamed(
                RouteNames.addLivestock.name,
                extra: {
                  'types': filterBloc.state.types,
                  'additionTypes': filterBloc.state.additionTypes,
                },
              ).then(
                (_) => context.read<FilterLivestockBloc>().add(FilterLivestockEvent.fetchFilters()),
              );
            }
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
                  context.pushNamed(
                    RouteNames.livestockListFilter.name,
                    extra: context.read<FilterLivestockBloc>(),
                  );
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
                child: PagedListView<int, LivestockModel>(
                  pagingController: _pagingController,
                  shrinkWrap: true,
                  builderDelegate: PagedChildBuilderDelegate<LivestockModel>(
                    newPageErrorIndicatorBuilder: (context) {
                      return Text(
                        'Ошибка',
                        textAlign: TextAlign.center,
                      ).paddingSymmetric(horizontal: 16.w);
                    },
                    firstPageErrorIndicatorBuilder: (context) {
                      return Text(
                        'Ошибка',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFA7A7A7),
                          fontSize: 20.sp,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ).paddingSymmetric(horizontal: 16.w);
                    },
                    noItemsFoundIndicatorBuilder: (context) {
                      return Column(
                        children: const [
                          Text(
                            'Результатов не найдено!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFFA7A7A7),
                              fontSize: 20,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Пожалуйста, попробуйте еще раз с другими критериями поиска',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFFA7A7A7),
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      );
                    },
                    itemBuilder: (context, item, index) {
                      return InkWell(
                        onTap: () {
                          final filterBloc = context.read<FilterLivestockBloc>();

                          context.push(
                            RouteNames.livestockDetails.name,
                            extra: {
                              'types': filterBloc.state.types,
                              'additionTypes': filterBloc.state.additionTypes,
                              'livestockModel': item,
                            },
                          );
                        },
                        child: LivestockTileWidget(livestockModel: item),
                      ).paddingOnly(
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
      ),
    );
  }
}
