import 'package:malshy/core/utils/data_state.dart';
import 'package:malshy/features/auth/data/models/user_model.dart';

abstract class AuthRepository {
  Future<DataState<UserModel>> logIn({required String phone, required String password});

  Future<DataState<UserModel>> register({
    required String firstName,
    required String lastName,
    required String thirdName,
    required String phone,
    required String password,
  });

  Future<DataState> refreshToken();
}
