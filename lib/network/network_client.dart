import 'package:graphql_flutter/graphql_flutter.dart' as gql;
import 'package:payrun_mobile/utils/api_endpoints.dart';
import 'package:get/get.dart';

String _getRequestUrl(String apiEndPoint) => Api.PUBLIC_URL + apiEndPoint;

class NetworkClient extends GetConnect {
  Future<Response> getRequest(String apiEndPoint) async {
    return await get(_getRequestUrl(apiEndPoint), headers: {
      "Content-Type": "application/json",
    }).timeout(const Duration(seconds: 15));
  }

  Future<Response> postRequest(String apiEndPoint, dynamic body) async {
    Response response = await post(_getRequestUrl(apiEndPoint), body, headers: {
      "Content-Type": "application/json",
    }).timeout(const Duration(seconds: 15));
    return response;
  }

  gql.GraphQLClient qlClient = gql.GraphQLClient(
      link: gql.HttpLink(Api.PRIVATE_URL, defaultHeaders: {
        "Authorization":
            "eyJraWQiOiJGcUFYWk54ZkZ6R2liTjVOQWs5RzBkS3E3VGVoZlI4cnBWYjlqeEk3RURNPSIsImFsZyI6IlJTMjU2In0.eyJzdWIiOiIzN2Q0MzU5ZS04ODkzLTQyOGEtYjQ0Ni1lMDQ1MzE5Mzk1ODgiLCJjb2duaXRvOmdyb3VwcyI6WyJiNDFlZmM0My1jYjFkLTQxYzItYWU2My05MGVhNzE4ZTk5ZmE6b3JnX293bmVyIiwiMTUwMWU2MDAtYTU0Ny00NmRkLTg2M2MtYzdiYjkwMTc0MDVhOm9yZ19vd25lciJdLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiaXNzIjoiaHR0cHM6XC9cL2NvZ25pdG8taWRwLmV1LXdlc3QtMS5hbWF6b25hd3MuY29tXC9ldS13ZXN0LTFfbDJKVDNNckFCIiwiY29nbml0bzp1c2VybmFtZSI6IjM3ZDQzNTllLTg4OTMtNDI4YS1iNDQ2LWUwNDUzMTkzOTU4OCIsImN1c3RvbTp1c2VySWQiOiJjNjZjNzhjYS1hZTIzLTRiOTgtODBhNi1mYzQyY2FlMGU1YTUiLCJvcmlnaW5fanRpIjoiZWRmZjBmNjktOWFmYi00OTYwLThmODctYmQ2MjgzYzgwMDM2IiwiYXVkIjoiNGxpNjZsYTYxOTlmYWdvMTVwOHQzNmJtaW8iLCJldmVudF9pZCI6Ijg3ZTEwMDJmLWVjM2EtNDQ0NC1iMzc0LWZhYmNhNGRkNzU4YiIsInRva2VuX3VzZSI6ImlkIiwib3JnX2lkIjoiMTUwMWU2MDAtYTU0Ny00NmRkLTg2M2MtYzdiYjkwMTc0MDVhIiwiYXV0aF90aW1lIjoxNzAwMzc0MDgzLCJleHAiOjE3MDA0NjA0ODIsImlhdCI6MTcwMDM3NDA4MywianRpIjoiMjc2OGU5NDMtNDVhYy00YjY3LWJjNDUtYmY1ZjFhNjAxNTdiIiwiZW1haWwiOiJzaGFobmV3YXpAZ2Fpbi5tZWRpYSJ9.LZRplSMZc3DOjTmZLcxoODMtTVvoam3Md9OUWJFf970A3YwS90Dx0SYsoBmNb_mL8ANqMBLDcSHabGMtez6NjCZ1W_mJ7xkEGaWMsXqRYGN7W6K1plKSXdcS38oYEunn6dFwVhtNU1vfg9FXptCurIKpXk-5Jj3HG-nbr1bVLTAIyr3kS7UglORC4s2omeRgpl9_3g-iDoHXBKdKR-bhJ8WXHP0k-TELsBOetzI0Lwhg8JcFbhMp87aNRSagiEpK8HV5pt1iO0rx2B_b0AKljk8ZBr1gIvwDWzTdtKjNsj3TJxtaBM0qFz6CpJJZFbBseqMh7Dvg-NbSxcXlmwjv2A"
      }),
      cache: gql.GraphQLCache());

  Future<gql.QueryResult> getGraphQuery(String queryString) async {
    return await qlClient
        .query(gql.QueryOptions(document: gql.gql(queryString)));
  }

  Future<gql.QueryResult> mutationGraphData(
      String mutationQuery, Map<String, dynamic> variables) async {
    final gql.MutationOptions options = gql.MutationOptions(
      document: gql.gql(mutationQuery),
      variables: variables,
    );

    return await qlClient.mutate(options);
  }
}
