import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as gql;
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
    gql.QueryResult queryResult = await NetworkClient().getGraphQuery(getSelectionQuery);
//     // ...
//
//     final MutationOptions options = MutationOptions(
//       document: gql.gql(addStar),
//       variables: <String, dynamic>{
//         'starrableId': "",
//       },
//     );
//     // ...
//
//     final QueryResult result = await qlClient.mutate(options);
//
// // ...

    print(queryResult.data?["getFromSections"].toString());
    print(GetFromSections.fromJson(queryResult.data?["getFromSections"]).data);
  }
}

class GetFromSections {
  List<Data>? data;

  GetFromSections({this.data});

  GetFromSections.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? name;

  Data({this.name});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
