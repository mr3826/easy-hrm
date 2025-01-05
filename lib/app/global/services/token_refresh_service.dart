import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'auth_token_service.dart';
import '../../../utils/api_endpoints.dart';

class TokenRefreshService {
  final AuthTokenService _authTokenService = Get.find<AuthTokenService>();
  final Dio _dio = Dio();

  /// Attempt to refresh the access token
  Future<String?> refreshAccessToken() async {
    try {
      final refreshToken = await _authTokenService.getRefreshToken();
      if (refreshToken == null) {
        return null;
      }

      final response = await _dio.post(
        Api.REFRESH_TOKEN,
        data: {'refresh_token': refreshToken},
      );

      final newAccessToken = response.data['access_token'];
      await _authTokenService.storeAccessToken(newAccessToken);
      return newAccessToken;
    } catch (e) {
      print('Error refreshing token: $e');
      return null;
    }
  }
}
