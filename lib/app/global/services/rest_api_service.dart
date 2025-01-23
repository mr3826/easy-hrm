import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'auth_token_service.dart';
import 'token_refresh_service.dart';
import '../../../utils/api_endpoints.dart';

class RestApiService {
  final dio.Dio _dio = dio.Dio();
  final AuthTokenService _authTokenService = Get.find<AuthTokenService>();
  final TokenRefreshService _tokenRefreshService = Get.find<TokenRefreshService>();

  RestApiService() {
    _dio.options.baseUrl = Api.PUBLIC_URL;
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.headers['User-Agent'] = 'getx-client';

    // Add the custom interceptor
    _dio.interceptors.add(dio.InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Attach the token to request headers
        final token = await _authTokenService.getAccessToken();
        if (token != null) {
          options.headers['Authorization'] = token;
        }
        print('Request: ${options.method} ${options.path}');
        print('Request Headers: ${options.headers}');
        return handler.next(options); // Continue the request
      },
      onResponse: (response, handler) {
        print('Response: ${response.statusCode} ${response.requestOptions.path}');
        print('Response Data: ${response.data}');
        return handler.next(response); // Continue the response
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          // Token refresh mechanism
          final String? newToken = await _tokenRefreshService.refreshAccessToken();
          if (newToken != null) {
            // Retry the request with the new token
            error.requestOptions.headers['Authorization'] = newToken;
            final retryResponse = await _dio.request(
              error.requestOptions.path,
              options: dio.Options(
                method: error.requestOptions.method,
                headers: error.requestOptions.headers,
              ),
              data: error.requestOptions.data,
              queryParameters: error.requestOptions.queryParameters,
            );
            return handler.resolve(retryResponse);
          } else {
            print('Failed to refresh token');
            return handler.reject(error); // Reject if token refresh fails
          }
        }
        print("Error: ${error.response?.data['message'].toString()}");
        return handler.next(error); // Continue error handling
      },
    ));
  }

  Future<dio.Response?> get(String endpoint) async {
    try {
      return await _dio.get(endpoint);
    } catch (e) {
      // Handling other errors not related to token expiration can be done here
      print("Error: $e");
      return null;
    }
  }

  Future<dio.Response?> post(String endpoint, dynamic data) async {
    try {
      return await _dio.post(endpoint, data: data);
    } catch (e) {
      // Handling other errors not related to token expiration can be done here
      print("Error: $e");
      return null;
    }
  }
}
