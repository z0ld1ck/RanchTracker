import 'package:get_it/get_it.dart';
import 'package:malshy/core/network/api_endpoints.dart';
import 'package:malshy/core/network/custom_exceptions.dart';
import 'package:malshy/core/network/network_client.dart';
import 'package:malshy/core/utils/data_state.dart';
import 'package:malshy/features/auth/data/models/user_model.dart';
import 'package:malshy/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final NetworkClient _networkClient = GetIt.I.get<NetworkClient>();

  @override
  Future<DataState<UserModel>> logIn({required String phone, required String password}) async {
    try {
      final userModel = await _networkClient.postData<UserModel>(
        endpoint: AuthEndpoint.LOGIN.path,
        body: {
          'phone': phone,
          'password': password,
        },
        parser: (data) {
          return UserModel.fromJson(data['user']);
        },
        requiresAuthToken: false,
      );

      if (userModel != null) {
        return DataSuccess(userModel);
      }

      return DataFailed(
        CustomException(
          exceptionType: ExceptionType.FormatException,
          message: 'Response data is empty/null',
        ),
      );
    } on CustomException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<int>> getFarmId() async {
    try {
      final userModel = await _networkClient.getListData<int?>(
        endpoint: AuthEndpoint.GET_FARMS.path,
        parser: (List<dynamic> data) {
          final farm = data.firstOrNull;
          if (farm is Map<String, dynamic>) {
            return [farm['id']];
          } else {
            return [];
          }
        },
      );

      if (userModel.firstOrNull != null) {
        return DataSuccess(userModel.firstOrNull ?? -1);
      }

      return DataFailed(
        CustomException(
          exceptionType: ExceptionType.FormatException,
          message: 'Response data is empty/null',
        ),
      );
    } on CustomException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<UserModel>> register({
    required String firstName,
    required String lastName,
    required String thirdName,
    required String phone,
    required String password,
  }) async {
    try {
      final userModel = await _networkClient.postData<UserModel>(
        endpoint: AuthEndpoint.REGISTER.path,
        body: {
          "first_name": firstName,
          "last_name": lastName,
          "third_name": thirdName,
          "phone": phone,
          "password": password,
        },
        parser: (data) {
          return UserModel.fromJson(data);
        },
        requiresAuthToken: false,
      );

      if (userModel != null) {
        return DataSuccess(userModel);
      }

      return DataFailed(
        CustomException(
          exceptionType: ExceptionType.FormatException,
          message: 'Response data is empty/null',
        ),
      );
    } on CustomException catch (e) {
      return DataFailed(e);
    }
  }
}
