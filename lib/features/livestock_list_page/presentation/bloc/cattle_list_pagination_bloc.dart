import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:malshy/core/network/custom_exceptions.dart';
import 'package:malshy/core/utils/data_state.dart';
import 'package:malshy/features/livestock_list_page/data/models/get_livestock_model.dart';
import 'package:malshy/features/livestock_list_page/domain/usecases/get_livestock_list_usecase.dart';
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

    // _onFilterChangedSubject.stream
    //     .flatMap((_) => _resetSearch())
    //     .listen(_onNewListingStateController.add)
    //     .addTo(_subscriptions);
  }

  static const _pageSize = 20;

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
  // final _onFilterChangedSubject = BehaviorSubject<FilterAggregatesStateSuccess?>.seeded(null);

  // Sink<FilterAggregatesStateSuccess?> get onFilterChangedSink => _onFilterChangedSubject.sink;

  // FilterAggregatesStateSuccess? get _filterValue => _onFilterChangedSubject.value;

  Stream<CattleListPaginationState> _resetSearch() async* {
    yield CattleListPaginationState();
    yield* _fetchAggregateList(1);
  }

  Stream<CattleListPaginationState> _fetchAggregateList(int pageKey) async* {
    final lastListingState = _onNewListingStateController.value;
    try {
      final result = await _getLivestockListUsecase({
        'farm_id': 12,
        'page': pageKey,
        'search': _searchInputValue,
      });
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
