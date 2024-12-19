import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/global/services/api_service.dart';

class AuthService {
  final FlutterSecureStorage _secureStorage = Get.find<FlutterSecureStorage>();
  String? _cachedToken;
  Completer<String?>? _refreshCompleter;

  Future<void> storeAccessToken(String token) async {
    _cachedToken = token;
    await _secureStorage.write(key: 'ACCESS_TOKEN', value: token);
  }

  Future<String?> getAccessToken() async {
    if (_cachedToken != null) return _cachedToken;
    _cachedToken = await _secureStorage.read(key: 'ACCESS_TOKEN');
    return _cachedToken;
  }

  Future<void> deleteAccessToken() async {
    _cachedToken = null;
    await _secureStorage.delete(key: 'ACCESS_TOKEN');
  }

  Future<String?> refreshAccessToken() async {
    if (_refreshCompleter != null) {
      return _refreshCompleter!.future; // Wait for ongoing refresh
    }

    _refreshCompleter = Completer();

    try {
      final response = await Get.find<ApiService>().makePostApiCall(
          '/auth/refresh', {'refresh_token': 'your_refresh_token'});
      final newToken = response?.data['access_token'];
      await storeAccessToken(newToken);
      _refreshCompleter!.complete(newToken);
      return newToken;
    } catch (e) {
      _refreshCompleter!.completeError(e);
      await deleteAccessToken(); // Clear tokens on failure
      return null;
    } finally {
      _refreshCompleter = null;
    }
  }
}
