import 'package:malshy/core/utils/data_state.dart';
import 'package:malshy/core/utils/usecase.dart';
import 'package:malshy/features/auth/data/models/user_model.dart';
import 'package:malshy/features/auth/domain/repositories/auth_repository.dart';

class RegisterUsecase implements Usecase<DataState<UserModel>, Map<String, dynamic>> {
  final AuthRepository _authRepository;
  RegisterUsecase(this._authRepository);

  @override
  Future<DataState<UserModel>> call({Map<String, dynamic>? params}) async {
    return await _authRepository.register(
      firstName: params!['first_name'],
      lastName: params['last_name'],
      thirdName: params['third_name'],
      phone: params['phone'],
      password: params['password'],
    );
  }
}
