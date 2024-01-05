import 'key_value_storage_base.dart';

/// A service class for providing methods to store and retrieve key-value data
/// from common or secure storage.
class KeyValueStorageService {
  static const _accessTokenKey = 'accessToken';
  static const _refreshTokenKey = 'refreshToken';
  static const _authPasswordKey = 'authPasswordKey';
  // static const _userModelKey = 'userModel';

  final _keyValueStorage = KeyValueStorageBase();

  Future<String?> getAccessToken() async {
    return await _keyValueStorage.getEncrypted(_accessTokenKey);
  }

  Future<String?> getRefreshToken() async {
    return await _keyValueStorage.getEncrypted(_refreshTokenKey);
  }

  Future<String?> getAuthPassword() async {
    return await _keyValueStorage.getEncrypted(_authPasswordKey);
  }

  // UserModel? getUserModel() {
  //   final json = _keyValueStorage.getCommon(_userModelKey);
  //   if (json != null) {
  //     return UserModel.fromJson(jsonDecode(json));
  //   } else {
  //     return null;
  //   }
  // }

  void setAccessToken(String token) {
    _keyValueStorage.setEncrypted(_accessTokenKey, token);
  }

  void setRefreshToken(String token) {
    _keyValueStorage.setEncrypted(_refreshTokenKey, token);
  }

  void setAuthPassword(String password) {
    _keyValueStorage.setEncrypted(_authPasswordKey, password);
  }

  // void setUserModel(UserModel userModel) {
  //   _keyValueStorage.setCommon(_userModelKey, jsonEncode(userModel.toJson()));
  // }

  void resetKeys() {
    _keyValueStorage
      ..clearCommon()
      ..clearEncrypted();
  }
}
