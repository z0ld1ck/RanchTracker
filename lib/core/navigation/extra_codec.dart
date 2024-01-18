import 'dart:convert';

import 'package:malshy/features/auth/presentation/bloc/registration/registration_bloc.dart';
import 'package:malshy/features/livestock/data/models/addition_type_model.dart';
import 'package:malshy/features/livestock/data/models/livestock_model.dart';
import 'package:malshy/features/livestock/data/models/type_model.dart';
import 'package:malshy/features/livestock/presentation/bloc/filter_livestock/filter_livestock_bloc.dart';

class ExtraCodec extends Codec<Object?, Object?> {
  /// Create a codec.
  const ExtraCodec();

  @override
  Converter<Object?, Object?> get decoder => const _ExtraDecoder();

  @override
  Converter<Object?, Object?> get encoder => const _ExtraEncoder();
}

class _ExtraDecoder extends Converter<Object?, Object?> {
  const _ExtraDecoder();

  @override
  Object? convert(Object? input) {
    if (input == null) {
      return null;
    }
    final List<Object?> inputAsList = input as List<Object?>;
    if (inputAsList[0] == 'RegistrationBloc') {
      return inputAsList[1];
    }
    if (inputAsList[0] == 'FilterLivestockBloc') {
      return inputAsList[1];
    }
    if (inputAsList[0] == 'TypeModel') {
      return inputAsList[1];
    }
    if (inputAsList[0] == 'AdditionTypeModel') {
      return inputAsList[1];
    }
    if (inputAsList[0] == 'LivestockModel') {
      return inputAsList[1];
    }
    if (inputAsList[0] == 'Map<String, List<Object>>') {
      return inputAsList[1];
    }
    if (inputAsList[0] == 'Map<String, Object>') {
      return inputAsList[1];
    }
    throw FormatException('Unable to parse input: $input');
  }
}

class _ExtraEncoder extends Converter<Object?, Object?> {
  const _ExtraEncoder();

  @override
  Object? convert(Object? input) {
    if (input == null) {
      return null;
    }
    switch (input) {
      case RegistrationBloc _:
        return <Object?>['RegistrationBloc', input];
      case FilterLivestockBloc _:
        return <Object?>['FilterLivestockBloc', input];
      case TypeModel _:
        return <Object?>['TypeModel', input];
      case AdditionTypeModel _:
        return <Object?>['AdditionTypeModel', input];
      case Map<String, List<Object>> _:
        return <Object?>['Map<String, List<Object>>', input];
      case LivestockModel _:
        return <Object?>['LivestockModel', input];
      case Map<String, Object> _:
        return <Object?>['Map<String, Object>', input];
      default:
        throw FormatException('Cannot encode type ${input.runtimeType}');
    }
  }
}
