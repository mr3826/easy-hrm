import 'package:get_storage/get_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as gql;
import 'package:payrun_mobile/utils/api_endpoints.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/utils/app_string.dart';

String _getRequestUrl(String apiEndPoint) => Api.PUBLIC_URL + apiEndPoint;

class NetworkClient extends GetConnect {
  Future<Response> getRequest(String apiEndPoint) async {
    return await get(_getRequestUrl(apiEndPoint), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": GetStorage().read(AppString.ACCESS_TOKEN) != null
          ? "Bearer ${GetStorage().read(AppString.ACCESS_TOKEN)}"
          : ""
    }).timeout(const Duration(seconds: 15));
  }


  Future<Response> postRequest(String apiEndPoint, dynamic body) async {
    Response response = await post(_getRequestUrl(apiEndPoint), body, headers: {
      "Content-Type": "application/json",
    }).timeout(const Duration(seconds: 15));
    return response;
  }

  Future<gql.QueryResult> getGraphQuery(String queryString) async {
    gql.GraphQLClient qlClient = gql.GraphQLClient(
        link: gql.HttpLink(Api.PRIVATE_URL, defaultHeaders: {
          "Authorization": GetStorage().read(AppString.ACCESS_TOKEN)
        }),
        cache: gql.GraphQLCache());
    return await qlClient
        .query(gql.QueryOptions(document: gql.gql(queryString)));
  }

  Future<gql.QueryResult> mutationGraphData(
      String mutationQuery, Map<String, dynamic> variables) async {
    gql.GraphQLClient qlClient = gql.GraphQLClient(
        link: gql.HttpLink(Api.PRIVATE_URL, defaultHeaders: {
          "Authorization": GetStorage().read(AppString.ACCESS_TOKEN)
        }),
        cache: gql.GraphQLCache());
    final gql.MutationOptions options = gql.MutationOptions(
      document: gql.gql(mutationQuery),
      variables: variables,
    );

    return await qlClient.mutate(options);
  }
}