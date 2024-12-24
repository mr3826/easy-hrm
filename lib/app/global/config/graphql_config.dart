import 'package:graphql_flutter/graphql_flutter.dart';
import '../services/auth_token_service.dart';

class GraphQLConfig {
  static GraphQLClient client(AuthTokenService authService) {
    // GraphQL Client configuration with authentication token
    return GraphQLClient(
      link: Link.from([
        AuthLink(
          getToken: () async => await authService.getAccessToken(),
        ),
        HttpLink('https://api.example.com/graphql'),
      ]),
      cache: GraphQLCache(),
    );
  }
}
