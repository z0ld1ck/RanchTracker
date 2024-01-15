import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:malshy/core/network/custom_exceptions.dart';
import 'package:malshy/core/utils/data_state.dart';
import 'package:malshy/features/livestock_list_page/data/models/get_livestock_model.dart';
import 'package:malshy/features/livestock_list_page/domain/usecases/get_livestock_list_usecase.dart';
import 'package:malshy/features/livestock_list_page/presentation/bloc/filter_livestock/filter_livestock_bloc.dart';
import 'package:rxdart/rxdart.dart';

class CattleListPaginationState {
  CattleListPaginationState({
    this.itemList,
    this.error,
    this.nextPageKey = 1,
  });

  final List<GetLivestockModel>? itemList;
  final CustomException? error;
  final int? nextPageKey;
}

class CattleListPaginationBloc {
  final _getLivestockListUsecase = GetIt.I.get<GetLivestockListUsecase>();

  CattleListPaginationBloc() {
    _onPageRequest.stream.flatMap(_fetchAggregateList).listen(_onNewListingStateController.add).addTo(_subscriptions);

    _onSearchInputChangedSubject.stream
        .flatMap((_) => _resetSearch())
        .listen(_onNewListingStateController.add)
        .addTo(_subscriptions);

    _onFilterChangedSubject.stream
        .flatMap((_) => _resetSearch())
        .listen(_onNewListingStateController.add)
        .addTo(_subscriptions);
  }

  static const _pageSize = 10;

  final _subscriptions = CompositeSubscription();

  final _onNewListingStateController = BehaviorSubject<CattleListPaginationState>.seeded(
    CattleListPaginationState(),
  );

  Stream<CattleListPaginationState> get onNewListingState => _onNewListingStateController.stream;

  final _onPageRequest = StreamController<int>();

  Sink<int> get onPageRequestSink => _onPageRequest.sink;

  // search query
  final _onSearchInputChangedSubject = BehaviorSubject<String?>.seeded(null);

  Sink<String?> get onSearchInputChangedSink => _onSearchInputChangedSubject.sink;

  String? get _searchInputValue => _onSearchInputChangedSubject.value;

  //filters
  final _onFilterChangedSubject = BehaviorSubject<FilterLivestockState?>.seeded(null);

  Sink<FilterLivestockState?> get onFilterChangedSink => _onFilterChangedSubject.sink;

  FilterLivestockState? get _filterValue => _onFilterChangedSubject.value;

  Stream<CattleListPaginationState> _resetSearch() async* {
    yield CattleListPaginationState();
    yield* _fetchAggregateList(1);
  }

  Stream<CattleListPaginationState> _fetchAggregateList(int pageKey) async* {
    final lastListingState = _onNewListingStateController.value;
    try {
      Map<String, dynamic> queryParams = {
        'farm_id': 12,
        'page': pageKey,
      };
      if (_searchInputValue != null && _searchInputValue!.isNotEmpty) queryParams['search'] = _searchInputValue;
      if (_filterValue?.selectedType != null) queryParams['livestock_type'] = _filterValue?.selectedType;
      if (_filterValue?.selectedBreed != null) queryParams['breed_type'] = _filterValue?.selectedBreed;
      if (_filterValue?.minWeight != null) queryParams['min_weight'] = _filterValue?.minWeight;
      if (_filterValue?.maxWeight != null) queryParams['max_weight'] = _filterValue?.maxWeight;
      if (_filterValue?.minAge != null) queryParams['min_age'] = _filterValue?.minAge;
      if (_filterValue?.maxAge != null) queryParams['max_age'] = _filterValue?.maxAge;
      if (_filterValue?.isPregnant != null) queryParams['is_pregnant'] = _filterValue?.isPregnant;
      final result = await _getLivestockListUsecase(queryParams);
      if (result is DataFailed) {
        throw result.error ??
            CustomException(
              message: 'Unknown error',
              exceptionType: ExceptionType.UnrecognizedException,
            );
      }
      if (result is DataSuccess) {
        final newItems = result.data ?? [];
        final isLastPage = newItems.length < _pageSize;
        final nextPageKey = isLastPage ? null : pageKey + 1;
        yield CattleListPaginationState(
          error: null,
          nextPageKey: nextPageKey,
          itemList: [
            ...lastListingState.itemList ?? [],
            ...newItems,
          ],
        );
      }
    } on CustomException catch (e) {
      yield CattleListPaginationState(
        error: e,
        nextPageKey: lastListingState.nextPageKey,
        itemList: lastListingState.itemList,
      );
    }
  }

  void dispose() {
    _onSearchInputChangedSubject.close();
    _onNewListingStateController.close();
    _subscriptions.dispose();
    _onPageRequest.close();
  }
}
