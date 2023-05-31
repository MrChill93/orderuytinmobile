class ApiResponse {
  // _data will hold any response converted into
  // its own object. For example user.
  late Object _data;
  // _apiError will hold the error object
  late String _apiError = " Errors";

  Object get Data => _data;
  set Data(Object data) => _data = data;

  String get ApiError => _apiError;
  set ApiError(String error) => _apiError = error;
}

class ApiError {
  late String _error;

  ApiError({required String error}) {
    _error = error;
  }

  String get error => _error;
  set error(String error) => _error = error;

  ApiError.fromJson(Map<String, dynamic> json) {
    _error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = _error;
    return data;
  }
}
