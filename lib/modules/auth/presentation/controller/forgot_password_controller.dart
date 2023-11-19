import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as gql;
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:payrun_mobile/common/domain/error_model.dart';
import 'package:payrun_mobile/common/domain/success_model.dart';
import 'package:payrun_mobile/common/widget/error_message.dart';
import 'package:payrun_mobile/common/widget/success_message.dart';
import 'package:payrun_mobile/network/network_client.dart';
import 'package:payrun_mobile/utils/api_endpoints.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/utils.dart';

class ForgotPasswordController extends GetxController {
  final isLoading = false.obs;

  Future<void> forgotPassword() async {
    isLoading(true);
    try {
      Response response =
          await NetworkClient().postRequest(Api.FORGOT_PASSWORD, {
        "email": emailController.text,
        "orgId": GetStorage().read(AppString.ORGANIZATION_ID)
      });

      if (response.status.hasError) {
        logErrorMessage(logName: "forgotPassword", response: response);
        showErrorMessage(
            message: ErrorModel.fromJson(response.body).message ??
                AppString.error_text);
      } else {
        logSuccessMessage(logName: "forgotPassword");
      }
    } catch (exp) {
      showErrorMessage(message: AppString.error_text);
      log(exp.toString());
    }
    isLoading(false);
  }

  Future<void> resendOtp() async {
    isLoading(true);
    try {
      Response response = await NetworkClient().postRequest(Api.RESEND_OTP, {
        "email": emailController.text,
        "orgId": GetStorage().read(AppString.ORGANIZATION_ID)
      });

      if (response.status.hasError) {
        logErrorMessage(logName: "resendOtp", response: response);
        showErrorMessage(
            message: ErrorModel.fromJson(response.body).message ??
                AppString.error_text);
      } else {
        logSuccessMessage(logName: "resendOtp");
      }
    } catch (exp) {
      log(exp.toString());
    }
    isLoading(false);
  }

  Future<void> resetPassword({required String confirmationCode}) async {
    isLoading(true);
    try {
      Response response =
          await NetworkClient().postRequest(Api.RESET_PASSWORD, {
        "email": emailController.text,
        "confirmationCode": confirmationCode,
        "password": confirmPasswordController.text,
        "orgId": GetStorage().read(AppString.ORGANIZATION_ID)
      });
      log(response.body.toString());
      if (response.status.hasError) {
        logErrorMessage(logName: "resetPassword", response: response);
        showErrorMessage(
            message: ErrorModel.fromJson(response.body).message ??
                AppString.error_text);
      } else {
        logSuccessMessage(logName: "resetPassword");
        showSuccessMessage(
            message: SuccessModel.fromJson(response.body).message);
      }
    } catch (exp) {
      log(exp.toString());
    }
    isLoading(false);
  }

  void fetchData() async {
    gql.GraphQLClient qlClient = gql.GraphQLClient(
        link: gql.HttpLink("https://api.local.payrun.app/graphql",
            defaultHeaders: {
              "Authorization":
                  "eyJraWQiOiJGcUFYWk54ZkZ6R2liTjVOQWs5RzBkS3E3VGVoZlI4cnBWYjlqeEk3RURNPSIsImFsZyI6IlJTMjU2In0.eyJzdWIiOiI2YWY2NGFiZS0yNjRkLTRkOGMtYTg0NC01MmM3OWY3OGYyOTQiLCJjb2duaXRvOmdyb3VwcyI6WyJhODViNzNiYy1hZTRjLTRmNjAtODllNC05YTJjMWIzYWVmMjY6b3JnX293bmVyIl0sImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJpc3MiOiJodHRwczpcL1wvY29nbml0by1pZHAuZXUtd2VzdC0xLmFtYXpvbmF3cy5jb21cL2V1LXdlc3QtMV9sMkpUM01yQUIiLCJjb2duaXRvOnVzZXJuYW1lIjoiNmFmNjRhYmUtMjY0ZC00ZDhjLWE4NDQtNTJjNzlmNzhmMjk0IiwiY3VzdG9tOnVzZXJJZCI6IjhhMWQ1MDM2LWQ3MGMtNDAxMi05NTU4LTY2MTIyNzgyYzVjNSIsIm9yaWdpbl9qdGkiOiI3ODMzYThiZS1jNzUyLTQwZTctODU0OS02NTA4YWQwMzJlYTkiLCJhdWQiOiI4Mm91cXZ1dHBwcGlrOGo4OHYzOTk0NDAyIiwiZXZlbnRfaWQiOiI0YTc0ZmY3NC0yZjQ1LTRjYWQtYjdmNi1iMmJjZjZkYmJhMWEiLCJ0b2tlbl91c2UiOiJpZCIsIm9yZ19pZCI6ImE4NWI3M2JjLWFlNGMtNGY2MC04OWU0LTlhMmMxYjNhZWYyNiIsImF1dGhfdGltZSI6MTcwMDA0MjcxOSwiZXhwIjoxNzAwMTI5MTE3LCJpYXQiOjE3MDAwNDI3MTksImp0aSI6IjU1ZjIzOGE4LTVlMDItNGM3My1hMDBlLTQ3MDA3ZDNiODQ4NCIsImVtYWlsIjoiZXZhbkBnYWluLm1lZGlhIn0.nL-Peo9y7hYPIg6jC2_fXOIBjDRnRXck0PSZ3r9MvZ_OOZ07q2qUuGeNP9VR4cR7nvXAW0fj6h7MwdDhebg9hRqYjoQ9qDbkaX69bEyxCG7wpMf7QYaXYHxgRMwTsEIKt3OstWt7JgRRQFMW90aCAuywVpaHr3OtV_aSqNHQwy8Dr9YNKuMJTay1C-6WYMUSbF6F5SdO1wwBuDSnLHqTrQ7CiNsW24m-MmtP_cmuKkycsAsgADCtErWqP8Wo04eVjaqzKBQjs-ZN-LLz-zzqZy4okRrwYv7O8Fo-gKRL4S-jKLPmVpbK4VmrwSdA_wgkiNN50yBBGJGCWlrvbLCA7w"
            }),
        cache: gql.GraphQLCache());

    // gql.QueryResult queryResult =
//         await qlClient.query(gql.QueryOptions(document: gql.gql("""
// query GetFromSections {
//   getFromSections {
//     data {
//       id
//     }
//   }
// }
//         """)));
    const String addStar = r'''
  mutation AddStar($starrableId: ID!) {
    action: addStar(input: {starrableId: $starrableId}) {
      starrable {
        viewerHasStarred
      }
    }
  }
''';
    // ...

    final MutationOptions options = MutationOptions(
      document: gql.gql(addStar),
      variables: <String, dynamic>{
        'starrableId': "",
      },
    );
    // ...

    final QueryResult result = await qlClient.mutate(options);

// ...


    print(queryResult.data!["getFromSections"]["data"][0].toString());
  }
}
