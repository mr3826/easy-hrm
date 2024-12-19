import 'package:dio/dio.dart';
import '../services/auth_service.dart';

class DioConfig {
  static Dio createDio(AuthService authService) {
    final dio = Dio();
    dio.options.baseUrl = 'https://api.example.com';
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers['User-Agent'] = 'getx-client';

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await authService.getAccessToken();
        if (token != null) {
          options.headers['Authorization'] = token;
        }
        return handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          final newToken = await authService.refreshAccessToken();
          if (newToken != null) {
            error.requestOptions.headers['Authorization'] = newToken;
            final retryResponse = await dio.request(
              error.requestOptions.path,
              options: Options(
                method: error.requestOptions.method,
                headers: error.requestOptions.headers,
              ),
              data: error.requestOptions.data,
              queryParameters: error.requestOptions.queryParameters,
            );
            return handler.resolve(retryResponse);
          }
        }
        return handler.next(error);
      },
    ));

    return dio;
  }
}
