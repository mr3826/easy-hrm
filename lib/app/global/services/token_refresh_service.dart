import 'dart:async';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/global/services/api_service.dart';
import '../../../utils/api_endpoints.dart';
import '../../../utils/app_string.dart';
import 'auth_token_service.dart';
import 'local_storage_service.dart';  // Import AuthService to store the new token

class TokenRefreshService {
  final ApiService _apiService = Get.find<ApiService>();
  final LocalStoreService _localStoreService = Get.find<LocalStoreService>();
  final AuthTokenService _authService = Get.find<AuthTokenService>();

  Completer<String?>? _refreshCompleter;

  /// Refresh the access token and store it securely.
  Future<String?> refreshAccessToken() async {
    if (_refreshCompleter != null) return _refreshCompleter!.future;

    _refreshCompleter = Completer();

    try {
      final refreshToken = await _localStoreService.read(AppString.REFRESH_TOKEN);
      if (refreshToken == null) {
        _refreshCompleter!.completeError('No refresh token found');
        return null;
      }

      final response = await _apiService.makePostApiCall(
          Api.REFRESH_TOKEN, {'refresh_token': refreshToken}
      );

      final newToken = response?.data['access_token'];

      if (newToken != null) {
        await _authService.storeAccessToken(newToken);  // Store the new token
        _refreshCompleter!.complete(newToken);
        return newToken;
      }

      _refreshCompleter!.completeError('Failed to refresh token');
      return null;
    } catch (e) {
      _refreshCompleter!.completeError(e);
      await _authService.deleteAccessToken(); // Clear tokens on failure
      return null;
    } finally {
      _refreshCompleter = null;
    }
  }
}
