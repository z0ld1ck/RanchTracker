import 'package:malshy/core/utils/data_state.dart';
import 'package:malshy/core/utils/usecase.dart';
import 'package:malshy/features/auth/data/models/user_model.dart';
import 'package:malshy/features/auth/domain/repositories/auth_repository.dart';

class LoginUsecase implements Usecase<DataState<UserModel>, Map<String, dynamic>> {
  final AuthRepository _authRepository;
  LoginUsecase(this._authRepository);

  @override
  Future<DataState<UserModel>> call({Map<String, dynamic>? params}) async {
    return await _authRepository.logIn(phone: params!['phone'], password: params['password']);
  }
}
