// ignore_for_file: constant_identifier_names
// DO NOT USE 'dartfmt' on this file for formatting

import 'package:flutter/material.dart';

/// A utility class for getting paths for API endpoints.
/// This class has no constructor and all methods are `static`.
@immutable
class ApiEndpoint {
  const ApiEndpoint._();

  /// The base url of our REST API, to which all the requests will be sent.
  /// It is supplied at the time of building the apk or running the app:
  /// ```
  /// flutter build apk --debug --dart-define=BASE_URL=www.some_url.com
  /// ```
  /// OR
  /// ```
  /// flutter run --dart-define=BASE_URL=www.some_url.com
  /// ```
  static const baseUrl = 'http://91.147.94.186:9010';
}

enum AuthEndpoint {
  REGISTER('/user/api/v1/registration/'),
  LOGIN('/user/api/v1/auth/login'),
  REFRESH_TOKEN('/user/api/v1/auth/refresh');

  const AuthEndpoint(this.path);

  final String path;
}

enum LivestockEndpoint {
  GET_LIVESTOCK_LIST('/farm/api/v1/livestock'),
  ADD_LIVESTOCK('/farm/api/v1/livestock');

  const LivestockEndpoint(this.path);

  final String path;
}

enum TypeBreedsEndpoint {
  GET_TYPE_AND_BREEDS('/farm/api/v1/livestock/types-breeds');

  const TypeBreedsEndpoint(this.path);

  final String path;
}
enum AdditionTypeEndpoint {
  GET_ADDITION_TYPE('/farm/api/v1/livestock/addition-types');

  const AdditionTypeEndpoint(this.path);

  final String path;
}
