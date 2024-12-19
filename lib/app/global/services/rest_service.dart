import 'package:dio/dio.dart';

class RestService {
  final Dio _dio;

  RestService(this._dio);

  Future<Response> get(String path) async {
    try {
      return await _dio.get(path);
    } catch (e) {
      rethrow; // You can handle error more gracefully here
    }
  }

  Future<Response> post(String path, dynamic data) async {
    try {
      return await _dio.post(path, data: data);
    } catch (e) {
      rethrow; // You can handle error more gracefully here
    }
  }
}
