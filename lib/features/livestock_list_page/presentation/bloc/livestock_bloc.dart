import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'livestock_event.dart';
part 'livestock_state.dart';
part 'livestock_bloc.freezed.dart';

class LivestockBloc extends Bloc<LivestockEvent, LivestockState> {
  LivestockBloc() : super(const LivestockState.initial()) {
    on<LivestockEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
