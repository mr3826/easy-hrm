import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../../modules/auth/models/signin_res.dart';
import 'auth_token_service.dart';
import '../../../utils/api_endpoints.dart';

class TokenRefreshService {
  final AuthTokenService _authTokenService = Get.find<AuthTokenService>();
  final Dio _dio = Dio();

  /// Attempt to refresh the access token
  Future<String?> refreshAccessToken() async {
    try {
      final accessToken = await _authTokenService.getAccessToken();
      final refreshToken = await _authTokenService.getRefreshToken();
      if (refreshToken == null) {
        return null;
      }

      final response = await _dio.post(
        Api.PUBLIC_URL + Api.REFRESH_TOKEN,
        data: {"refreshToken": refreshToken, "accessToken": accessToken},
      );

      final data = SignInResponse.fromJson(response.data).data;
      final newAccessToken = data?.accessToken ?? "";
      await _authTokenService.storeAccessToken(newAccessToken);
      await _authTokenService.storeRefreshToken(data?.refreshToken ?? "");
      return newAccessToken;
    } catch (e) {
      print('Error refreshing token: $e');
      return null;
    }
  }
}
