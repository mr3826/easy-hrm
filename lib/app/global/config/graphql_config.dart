import 'package:graphql_flutter/graphql_flutter.dart';
import '../services/auth_service.dart';

class GraphQLConfig {
  static GraphQLClient client(AuthService authService) {
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

  static WebSocketLink webSocketLink(AuthService authService) {
    // WebSocketLink configuration with authorization token
    return WebSocketLink(
      'wss://api.example.com/graphql',
      config: SocketClientConfig(
        autoReconnect: true,
        inactivityTimeout: const Duration(minutes: 5),
        initialPayload: () async => {
          'Authorization': await authService.getAccessToken(),
        },
      ),
    );
  }
}
