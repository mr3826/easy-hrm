import 'package:graphql_flutter/graphql_flutter.dart';
import '../services/auth_service.dart';
import '../config/graphql_config.dart';

class WebSocketService {
  final WebSocketLink _webSocketLink;

  WebSocketService(AuthService authService)
      : _webSocketLink = GraphQLConfig.webSocketLink(authService);

  Stream<dynamic> subscribe(String subscription,
      {Map<String, dynamic>? variables}) {
    final request = Request(
      operation: Operation(document: gql(subscription)),
      variables: variables ?? {},
    );

    return _webSocketLink.request(request).map((response) => response.data);
  }
}
