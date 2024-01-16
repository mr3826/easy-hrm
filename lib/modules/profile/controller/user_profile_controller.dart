import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/common/domain/success_model.dart';
import 'package:payrun_mobile/common/widget/error_message.dart';
import 'package:payrun_mobile/common/widget/success_message.dart';
import 'package:payrun_mobile/modules/auth/domain/organization_info.dart';
import 'package:payrun_mobile/modules/home/view/screen/main_screen.dart';
import 'package:payrun_mobile/modules/profile/model/employee_work_history.dart';
import 'package:payrun_mobile/modules/profile/model/user_log_history.dart';
import 'package:payrun_mobile/network/network_client.dart';
import 'package:payrun_mobile/routes/app_pages.dart';
import 'package:payrun_mobile/utils/api_endpoints.dart';

import '../../../common/domain/error_model.dart';
import '../../../common/domain/last_input_model.dart';
import '../../../utils/app_string.dart';
import '../../../utils/utils.dart';
import '../../auth/domain/signin_res.dart';
import '../model/organization_info.dart';
import '../model/user_profile.dart';

class UserProfileController extends GetxController with StateMixin {
  @override
  void onInit() {
    getUserProfile();
    getEmploymentInfo();
    getUserLogHistory();
    getOrganizationInfo();
    super.onInit();
  }

  UserDetails? userDetails;
  EmployeeWorkHistory? employeeWorkHistory;
  UserLogHistory? userLogHistory;
  OrganizationInfoDetails? organizationInfo;
  final isLoading = false.obs;
  final isOrganizationChangeLoading = false.obs;
  final isVerificationApiLoading = false.obs;

  void getUserProfile() async {
    change(null, status: RxStatus.loading());
    final response =
        await NetworkClient().getGraphQuery(queryString: getUserProfileQuery);
    if (response.hasException) {
      log(response.exception.toString());
    } else {
      userDetails = UserDetails.fromJson(response.data!);

      log("getUserProfile:::${UserDetails.fromJson(response.data!).getOrganizationUserDetails?.organization?.orgName}");
    }
    change(null, status: RxStatus.success());
  }

  void getEmploymentInfo() async {
    change(null, status: RxStatus.loading());
    final response = await NetworkClient().getGraphQuery(
        queryString: getEmploymentInfoQuery,
        variables: {
          "orgUserId": GetStorage().read(AppString.ORGANIZATION_USER_ID) ?? ""
        });

    if (response.hasException) {
      log(response.exception.toString());
    } else {
      employeeWorkHistory = EmployeeWorkHistory.fromJson(response.data!);

      log("getEmploymentInfo:::${EmployeeWorkHistory.fromJson(response.data!)}");
    }

    change(null, status: RxStatus.success());
  }

  void getUserLogHistory() async {
    change(null, status: RxStatus.loading());
    final response =
        await NetworkClient().getGraphQuery(queryString: userLogHistoryQuery);
    if (response.hasException) {
      log(response.exception.toString());
    } else {
      userLogHistory = UserLogHistory.fromJson(response.data!);
      log("getUserLogHistory:: ${UserLogHistory.fromJson(response.data!)}");
    }
    change(null, status: RxStatus.success());
  }

  Future<bool> getPasswordVerification({required String password}) async {
    bool validation = false;
    isLoading(true);
    try {
      final response = await NetworkClient()
          .postRequest(Api.VERIFY_PASSWORD, {"password": password});

      if (response.status.hasError) {
        logErrorMessage(logName: "getPasswordVerification", response: response);
        showErrorMessage(
            message: ErrorModel.fromJson(response.body).message ??
                "Some Error occur!");
      } else {
        logSuccessMessage(
            logName: "getPasswordVerification", response: response);
        ChangeMailResponse value = ChangeMailResponse.fromJson(response.body);
        validation = value.valid!;
      }
    } catch (e) {
      log(e.toString());
    }
    isLoading(false);
    return validation;
  }

  Future<bool> changeMail({required String newEmail}) async {
    bool validation = false;
    isLoading(true);
    try {
      final response = await NetworkClient().postRequest(Api.CHANGE_MAIL, {
        "newEmail": newEmail,
        "employeeId": GetStorage().read(AppString.ORGANIZATION_USER_ID) ?? ""
      });

      if (response.status.hasError) {
        logErrorMessage(logName: "changeMail", response: response);
        showErrorMessage(
            message: ErrorModel.fromJson(response.body).message ??
                "Some Error occur!");
      } else {
        logSuccessMessage(logName: "changeMail", response: response);
        // SuccessModel value = SuccessModel.fromJson(response.body);
        validation = true;
      }
    } catch (e) {
      log(e.toString());
    }
    isLoading(false);
    return validation;
  }

  submitVerificationCode({required String verificationCode}) async {
    isVerificationApiLoading(true);
    try {
      final response = await NetworkClient().postRequest(
          Api.VERIFY_CHANGE_MAIL_OTP, {"confirmationCode": verificationCode});

      if (response.status.hasError) {
        logErrorMessage(logName: "submitVerificationCode", response: response);
        showErrorMessage(
            message: ErrorModel.fromJson(response.body).message ??
                "Some Error occur!");
      } else {
        logSuccessMessage(
            logName: "submitVerificationCode", response: response);
        changeEmailController.clear();
        Get.offAllNamed(Routes.MAIN_SCREEN);
      }
    } catch (e) {
      log(e.toString());
    }
    isVerificationApiLoading(false);
  }

  resendOtp({required String emailAddress}) async {
    try {
      final response = await NetworkClient().postRequest(Api.RESEND_OTP, {
        "email": emailAddress,
        "orgId": GetStorage().read(AppString.ORGANIZATION_ID)
      });

      if (response.status.hasError) {
        logErrorMessage(logName: "resendOtp", response: response);
        showErrorMessage(
            message: ErrorModel.fromJson(response.body).message ??
                "Some Error occur!");
      } else {
        logSuccessMessage(logName: "resendOtp", response: response);
        showSuccessMessage(message: AppString.resend_otp_text.tr);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  getOrganizationInfo() async {
    change(null, status: RxStatus.loading());
    final response =
        await NetworkClient().getGraphQuery(queryString: organizationInfoQuery);

    if (response.hasException) {
      log(response.exception.toString());
    } else {
      organizationInfo = OrganizationInfoDetails.fromJson(response.data!);
    }
    change(null, status: RxStatus.success());
  }

  Future<void> login(
      {required String email,
      required String password,
      required String orgId,
      required String organizationName}) async {
    isOrganizationChangeLoading(true);
    try {
      Response response = await NetworkClient().postRequest(
          Api.LOGIN, {"email": email, "password": password, "orgId": orgId});
      if (response.hasError) {
        logErrorMessage(logName: "login", response: response);

        showErrorMessage(
            message: ErrorModel.fromJson(response.body).message ?? "");
      } else {
        logSuccessMessage(logName: "login", response: response);
        GetStorage().write(AppString.ID_TOKEN,
            SignInResponse.fromJson(response.body).data?.idToken ?? "");
        GetStorage().write(AppString.ACCESS_TOKEN,
            SignInResponse.fromJson(response.body).data?.accessToken ?? "");
        GetStorage().write(AppString.REFRESH_TOKEN,
            SignInResponse.fromJson(response.body).data?.refreshToken ?? "");
        GetStorage().write(AppString.LOGGED_IN, true);
        _saveData(
          email,
          password,
          organizationName
        );
        Get.offAll(() => MainScreen(
              routeIndex: 2,
            ));
      }
    } catch (e) {
      log(e.toString());
    }
    isOrganizationChangeLoading(false);
  }

  void _saveData(String email, String pass, String organizationName) {
    LastInput myInput =
        LastInput(email: email, password: pass, orgName: organizationName);
    Map<String, dynamic> jsonModel = myInput.toJson();
    String jsonObject = jsonEncode(jsonModel);
    GetStorage().write(AppString.LAST_INPUT, jsonObject);
  }
}

class ChangeMailResponse {
  bool? valid;

  ChangeMailResponse({this.valid});

  ChangeMailResponse.fromJson(Map<String, dynamic> json) {
    valid = json['valid'];
  }
}
