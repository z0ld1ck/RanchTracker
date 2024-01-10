import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../error/data_state.dart';

abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}

