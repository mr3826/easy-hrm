import 'graphql_api_service.dart';
import 'rest_api_service.dart';
import 'package:dio/dio.dart' as dio;
import 'package:graphql_flutter/graphql_flutter.dart' as gql;

class ApiService {
  final RestApiService _restApiService;
  final GraphQLApiService _graphQLApiService;

  ApiService({
    required RestApiService restApiService,
    required GraphQLApiService graphQLApiService,
  })  : _restApiService = restApiService,
        _graphQLApiService = graphQLApiService;

  // REST API methods
  Future<dio.Response?> get(String endpoint) async {
    return await _restApiService.get(endpoint);
  }

  Future<dio.Response?> post(String endpoint, dynamic data) async {
    return await _restApiService.post(endpoint, data);
  }

  // GraphQL methods
  Future<gql.QueryResult> gqlCall({required String queryString, Map<String, dynamic>? variables}) async {
    return await _graphQLApiService.query(queryString:queryString,variables: variables);
  }

}
