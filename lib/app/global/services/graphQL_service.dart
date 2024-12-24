import 'package:graphql_flutter/graphql_flutter.dart';
import '../services/auth_token_service.dart';
import '../config/graphql_config.dart';

class GraphQLService {
  final GraphQLClient _client;

  GraphQLService(AuthTokenService authService)
      : _client = GraphQLConfig.client(authService);

  Future<QueryResult> query(String query,
      {Map<String, dynamic>? variables}) async {
    return await _client.query(
      QueryOptions(
        document: gql(query),
        variables: variables ?? {},
      ),
    );
  }

  Future<QueryResult> mutate(String mutation,
      {Map<String, dynamic>? variables}) async {
    return await _client.mutate(
      MutationOptions(
        document: gql(mutation),
        variables: variables ?? {},
      ),
    );
  }
}
