import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../../utils/api_endpoints.dart';
import 'auth_token_service.dart';
import 'token_refresh_service.dart';

class GraphQLApiService {
  final AuthTokenService _authTokenService = Get.find<AuthTokenService>();
  final TokenRefreshService _tokenRefreshService =
      Get.find<TokenRefreshService>();

  GraphQLClient _createGraphQLClient(String? token) {
    return GraphQLClient(
      link: Link.from([
        AuthLink(
          getToken: () async => token,
        ),
        HttpLink(Api.PRIVATE_URL),
      ]),
      cache: GraphQLCache(),
    );
  }

  Future<QueryResult> _retryOnAuthFailure(
      Future<QueryResult> Function(GraphQLClient) requestFunction) async {
    // Step 1: Attempt the original request with the current token
    String? token = await _authTokenService.getAccessToken();
    final client = _createGraphQLClient(token);
    final result = await requestFunction(client);

    // Step 2: If unauthorized, attempt to refresh the token and retry
    if (result.hasException &&
        result.exception!.graphqlErrors
            .any((error) => error.message.contains('Unauthorized'))) {
      final newToken = await _tokenRefreshService.refreshAccessToken();

      if (newToken != null) {
        // Store the new token and retry the request
        await _authTokenService.storeAccessToken(newToken);

        final newClient = _createGraphQLClient(newToken);
        return await requestFunction(newClient);
      }
    }

    return result; // Return the result, whether successful or failed
  }

  Future<QueryResult> query(String query) async {
    return await _retryOnAuthFailure(
      (client) => client.query(
        QueryOptions(
          document: gql(query),
          fetchPolicy: FetchPolicy.noCache,
        ),
      ),
    );
  }

  Future<QueryResult> mutate(String mutation) async {
    return await _retryOnAuthFailure(
      (client) => client.mutate(
        MutationOptions(
          document: gql(mutation),
        ),
      ),
    );
  }
}
