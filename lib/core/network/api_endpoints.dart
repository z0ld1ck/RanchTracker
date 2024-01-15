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
  static const baseUrl = 'http://91.147.94.186:';
}

enum AuthEndpoint {
  REGISTER('9010/user/api/v1/registration/'),
  LOGIN('9010/user/api/v1/auth/login'),
  REFRESH_TOKEN('9010/user/api/v1/auth/refresh');

  const AuthEndpoint(this.path);

  final String path;
}

enum LivestockEndpoint {
  GET_LIVESTOCK_LIST('9015/farm/api/v1/livestock'),
  TYPES_BREEDS('9015/farm/api/v1/livestock/types-breeds'),
  ADD_LIVESTOCK('9015/farm/api/v1/livestock'),
  GET_ADDITION_TYPE('9015/farm/api/v1/livestock/addition-types');

  const LivestockEndpoint(this.path);

  final String path;
}

enum DashboardEndpoint {
  LIVESTOCK_BY_TYPE('9020/dashboard/api/v1/livestock/type'),
  LIVESTOCK_BY_STATUS('9020/dashboard/api/v1/livestock/status'),
  LIVESTOCK_BY_ACTION('9020/dashboard/api/v1/livestock/actions');

  const DashboardEndpoint(this.path);

  final String path;
}
