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
      "Authorization": GetStorage().read(AppString.ID_TOKEN) ?? ""
    }).timeout(const Duration(seconds: 15));
    return response;
  }

  Future<gql.QueryResult> getGraphQuery(
      {required String queryString, Map<String, dynamic>? variables}) async {
    if (checkTokenExpiration() < 1) {
      _getNewToken();
    }
    gql.GraphQLClient qlClient = gql.GraphQLClient(
        link: gql.HttpLink(Api.PRIVATE_URL, defaultHeaders: {
          "Authorization": GetStorage().read(AppString.ID_TOKEN)
        }),
        cache: gql.GraphQLCache());
    return await qlClient.query(gql.QueryOptions(
        document: gql.gql(queryString), variables: variables ?? {}));
  }

  Future<gql.QueryResult> mutationGraphData(
      String mutationQuery, Map<String, dynamic> variables) async {
    if (checkTokenExpiration() < 1) {
      _getNewToken();
    }
    gql.GraphQLClient qlClient = gql.GraphQLClient(
        link: gql.HttpLink(Api.PRIVATE_URL, defaultHeaders: {
          "Authorization": GetStorage().read(AppString.ID_TOKEN)
        }),
        cache: gql.GraphQLCache());
    final gql.MutationOptions options = gql.MutationOptions(
      document: gql.gql(mutationQuery),
      variables: variables,
    );
    return await qlClient.mutate(options);
  }

  void _getNewToken() async {
    try {
      Response response = await postRequest(Api.REFRESH_TOKEN, {
        "orgId": GetStorage().read(AppString.ORGANIZATION_ID),
        "refreshToken": GetStorage().read(AppString.REFRESH_TOKEN)
      });

      if (response.hasError) {
        logErrorMessage(logName: "refresh token", response: response);

        showErrorMessage(
            message: ErrorModel.fromJson(response.body).message ?? "");
        Get.offAllNamed(Routes.SIGN_IN_SCREEN);
      } else {
        logSuccessMessage(logName: "refresh token", response: response);
        GetStorage().write(AppString.ID_TOKEN,
            SignInResponse.fromJson(response.body).data?.idToken ?? "");
        GetStorage().write(AppString.ACCESS_TOKEN,
            SignInResponse.fromJson(response.body).data?.accessToken ?? "");
        GetStorage().write(AppString.REFRESH_TOKEN,
            SignInResponse.fromJson(response.body).data?.refreshToken ?? "");
      }
    } catch (e) {
      log(e.toString());
    }
  }
}

int checkTokenExpiration() {
  DateTime now = DateTime.now();

  // Specify the target date and time
  DateTime targetDate =
      JwtDecoder.getExpirationDate(GetStorage().read(AppString.ACCESS_TOKEN));

  // Calculate the difference
  Duration difference = targetDate.difference(now);

  return difference.inHours;
}
