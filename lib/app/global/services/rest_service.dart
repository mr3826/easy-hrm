import 'package:dio/dio.dart';

class RestService {
  final Dio _dio;

  RestService(this._dio);

  Future<Response?> get(String path) async {
    try {
      return await _dio.get(path);
    } on DioError catch (e) {
      _handleError(e);
      return null;
    }
  }

  Future<Response?> post(String path, dynamic data) async {
    try {
      return await _dio.post(path, data: data);
    } on DioError catch (e) {
      _handleError(e);
      return null;
    }
  }

  void _handleError(DioError e) {
    final errorMessage = e.response?.data['message'] ?? e.message;
    print('API call failed: ${e.response?.statusCode}, $errorMessage');
  }
}
