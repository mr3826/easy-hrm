import 'dart:developer';
import 'package:get_storage/get_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as gql;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:payrun_mobile/routes/app_pages.dart';
import 'package:payrun_mobile/utils/api_endpoints.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import '../common/domain/error_model.dart';
import '../common/widget/error_message.dart';
import '../modules/auth/domain/signin_res.dart';
import '../utils/utils.dart';

/// Utility function to construct the complete API request URL.
String _getRequestUrl(String apiEndPoint) => Api.PUBLIC_URL + apiEndPoint;

/// A network client class to handle HTTP and GraphQL requests using GetX and GraphQL Flutter.
class NetworkClient extends GetConnect {
  /// Sends a POST request to the specified [apiEndPoint] with the provided [body].
  /// Adds common headers such as content type and authorization token.
  /// Returns a [Response] object containing the server's response.
  Future<Response> postRequest(String apiEndPoint, dynamic body) async {
    try {
      return await post(_getRequestUrl(apiEndPoint), body, headers: {
        "Content-Type": "application/json",
        "User-Agent": "getx-client",
        "Authorization": GetStorage().read(AppString.ID_TOKEN) ?? ""
      }).timeout(const Duration(seconds: 15));
    } catch (e) {
      log('Error in postRequest: $e');
      rethrow;
    }
  }

  /// Executes a GraphQL query using the provided [queryString] and optional [variables].
  /// Automatically refreshes the token if it is expired.
  /// Returns a [gql.QueryResult] containing the response data.
  Future<gql.QueryResult> graphRequest(
      {required String queryString, Map<String, dynamic>? variables}) async {
    if (checkTokenExpiration() < 1) {
      await _getNewToken();
    }

    final httpLink = gql.HttpLink(Api.PRIVATE_URL, defaultHeaders: {
      "Authorization": GetStorage().read(AppString.ID_TOKEN)
    });

    // Create the Link with request/response logging
    final gql.Link link = gql.Link.from([
      gql.Link.function((request, [forward]) {
        log('Document: ${request.operation.document}');
        return forward!(request).map((response) {
          log('Errors: ${response.errors}');
          // log('Response data: ${response.data}');

          return response;
        });
      }),
      httpLink,
    ]);

    final gql.GraphQLClient qlClient =
        gql.GraphQLClient(link: link, cache: gql.GraphQLCache());

    return await qlClient.query(gql.QueryOptions(
        document: gql.gql(queryString), variables: variables ?? {}));
  }

  /// Refreshes the user's token by making a request to the refresh token endpoint.
  /// If the refresh fails, redirects the user to the sign-in screen.
  Future<void> _getNewToken() async {
    try {
      final response = await postRequest(Api.REFRESH_TOKEN, {
        "orgId": GetStorage().read(AppString.ORGANIZATION_ID),
        "refreshToken": GetStorage().read(AppString.REFRESH_TOKEN)
      });

      if (response.hasError) {
        logErrorMessage(logName: "refresh token", response: response);
        showErrorMessage(
            message: ErrorModel.fromJson(response.body).message ?? "");
        Get.offAllNamed(Routes.SIGN_IN_SCREEN);
      } else {
        final data = SignInResponse.fromJson(response.body).data;
        logSuccessMessage(logName: "refresh token", response: response);

        GetStorage()
          ..write(AppString.ID_TOKEN, data?.idToken ?? "")
          ..write(AppString.ACCESS_TOKEN, data?.accessToken ?? "")
          ..write(AppString.REFRESH_TOKEN, data?.refreshToken ?? "");
      }
    } catch (e) {
      log('Error in _getNewToken: $e');
    }
  }
}

/// Checks the expiration of the access token.
/// Returns the number of hours until the token expires.
int checkTokenExpiration() {
  final now = DateTime.now();
  final expirationDate =
      JwtDecoder.getExpirationDate(GetStorage().read(AppString.ACCESS_TOKEN));

  final difference = expirationDate.difference(now);
  return difference.inHours;
}
