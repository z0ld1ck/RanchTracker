import 'package:malshy/core/utils/data_state.dart';
import 'package:malshy/core/utils/usecase.dart';
import 'package:malshy/features/auth/domain/repositories/auth_repository.dart';

class GetFarmIdUsecase implements Usecase<DataState<int>, void> {
  final AuthRepository _authRepository;
  GetFarmIdUsecase(this._authRepository);

  @override
  Future<DataState<int>> call({void params}) async {
    return await _authRepository.getFarmId();
  }
}
