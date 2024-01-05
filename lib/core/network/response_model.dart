class ResponseModel<T> {
  final ResponseHeadersModel headers;
  final T body;

  const ResponseModel({
    required this.headers,
    required this.body,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      headers: ResponseHeadersModel.fromJson(
        json['headers'] as Map<String, dynamic>,
      ),
      body: json['body'] as T,
    );
  }
}

class ResponseHeadersModel {
  final bool error;
  final String message;
  final String? code;

  const ResponseHeadersModel({
    required this.error,
    required this.message,
    this.code,
  });

  factory ResponseHeadersModel.fromJson(Map<String, dynamic> json) {
    return ResponseHeadersModel(
      error: json['error'] as int == 1,
      message: json['message'] as String,
      code: json['code'] as String?,
    );
  }
}
