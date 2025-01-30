import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:payrun_mobile/common/widget/error_message.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import '../../../utils/api_endpoints.dart';
import 'auth_token_service.dart';
import 'token_refresh_service.dart';

class GraphQLApiService {
  final AuthTokenService _authTokenService = Get.find<AuthTokenService>();
  final TokenRefreshService _tokenRefreshService =
      Get.find<TokenRefreshService>();

  /// Creates a new GraphQLClient instance with the provided token
  GraphQLClient _createGraphQLClient(String? token) {
    return GraphQLClient(
      link: Link.from([
        AuthLink(getToken: () async => token),
        HttpLink(Api.PRIVATE_URL),
      ]),
      cache: GraphQLCache(),
    );
  }

  /// Retries a GraphQL request if the token is invalid or expired
  Future<QueryResult> _retryOnAuthFailure(
      Future<QueryResult> Function(GraphQLClient) requestFunction) async {
    String? token = await _authTokenService.getAccessToken();
    final client = _createGraphQLClient(token);

    QueryResult result = await requestFunction(client);
    // Check for token-related errors in the GraphQL response
    if (_isUnauthorizedError(result)) {
      final newToken = await _tokenRefreshService.refreshAccessToken();
      if (newToken != null) {
        final newClient = _createGraphQLClient(newToken);
        // Retry the original request with the new token
        return await requestFunction(newClient);
      }
    }
    return result;
  }

  /// Checks if the result contains an unauthorized error
  bool _isUnauthorizedError(QueryResult result) {
    if (!result.hasException) return false;

    final graphqlErrors = result.exception?.graphqlErrors ?? [];
    final linkException = result.exception?.linkException;

    // Check GraphQL errors for unauthorized messages
    if (graphqlErrors.any((error) => error.message.contains('Unauthorized'))) {
      return true;
    }

    // Check for link exceptions of type ServerException
    if (linkException is ServerException) {
      final rawResponse = linkException.parsedResponse;

      // Check parsedResponse.errors (if available) for invalid token
      if (rawResponse?.errors != null) {
        for (final error in rawResponse!.errors!) {
          if (error.message.contains('Invalid Token')) {
            return true;
          }
        }
      }

      // Fall back to checking the raw response body for error messages
      final rawResponseBody = rawResponse?.response.toString();
      if (rawResponseBody != null &&
          rawResponseBody.contains('Invalid Token')) {
        return true;
      }
    }

    return false;
  }

  /// Executes a GraphQL query
  Future<QueryResult> query(
      {required String queryString, Map<String, dynamic>? variables}) async {
    QueryResult<Object?> result = await _retryOnAuthFailure(
      (client) => client.query(
        QueryOptions(
            document: gql(queryString),
            variables: variables ?? {},
            fetchPolicy: FetchPolicy.cacheAndNetwork),
      ),
    );
    if (result.exception?.graphqlErrors != null) {
      print("result.hasException:: ${result.exception?.graphqlErrors[0].message}");

      showErrorMessage(message: result.exception?.graphqlErrors[0].message.toString()??"Something want wrong");
    }
    return result;
  }
}
