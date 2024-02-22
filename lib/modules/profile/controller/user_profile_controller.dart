import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:payrun_mobile/common/domain/token_model.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/error_message.dart';
import 'package:payrun_mobile/common/widget/success_message.dart';
import 'package:payrun_mobile/modules/profile/model/employee_work_history.dart';
import 'package:payrun_mobile/modules/profile/model/user_log_history.dart';
import 'package:payrun_mobile/network/network_client.dart';
import 'package:payrun_mobile/routes/app_pages.dart';
import 'package:payrun_mobile/utils/api_endpoints.dart';
import '../../../common/domain/error_model.dart';
import '../../../common/domain/last_input_model.dart';
import '../../../common/widget/custom_text_field.dart';
import '../../../network/exception_helper.dart';
import '../../../utils/app_color.dart';
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

  RxBool isValue = true.obs;

  changeVal() {
    return isValue.value = !isValue.value;
  }

  UserDetails? userDetails;
  EmployeeWorkHistory? employeeWorkHistory;
  UserLogHistory? userLogHistory;
  OrganizationInfoDetails? organizationInfo;
  final isLoading = false.obs;
  final isOrganizationChangeLoading = false.obs;
  final isNewOrganizationChangeLoading = false.obs;
  final isVerificationApiLoading = false.obs;

  final passwordInputController = TextEditingController();

  getUserProfile() async {
    change(null, status: RxStatus.loading());
    final response =
        await NetworkClient().getGraphQuery(queryString: getUserProfileQuery);
    if (response.hasException) {
      ExceptionHelper.errorHandler(exception: response.exception!);
    } else {
      userDetails = UserDetails.fromJson(response.data!);
      log("getUserProfile:::${UserDetails.fromJson(response.data!).getOrganizationUserDetails?.organization?.orgName}");
    }
    change(null, status: RxStatus.success());
  }

  getEmploymentInfo() async {
    change(null, status: RxStatus.loading());
    final response = await NetworkClient().getGraphQuery(
      queryString: getEmploymentInfoQuery,
    );

    if (response.hasException) {
      ExceptionHelper.errorHandler(exception: response.exception!);
    } else {
      employeeWorkHistory = EmployeeWorkHistory.fromJson(response.data!);

      log("getEmploymentInfo:::${EmployeeWorkHistory.fromJson(response.data!).getOrganizationUserHistory?.deptHistories?.length}");
    }

    change(null, status: RxStatus.success());
  }

  getUserLogHistory() async {
    change(null, status: RxStatus.loading());
    final response =
        await NetworkClient().getGraphQuery(queryString: userLogHistoryQuery);
    if (response.hasException) {
      ExceptionHelper.errorHandler(exception: response.exception!);
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
      print("Change email ::: ${response.body}");

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
      final response =
          await NetworkClient().postRequest(Api.VERIFY_CHANGE_MAIL_OTP, {
        "confirmationCode": verificationCode,
        "accessToken": GetStorage().read(AppString.ACCESS_TOKEN)
      });

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
      ExceptionHelper.errorHandler(exception: response.exception!);
    } else {
      organizationInfo = OrganizationInfoDetails.fromJson(response.data!);
    }
    change(null, status: RxStatus.success());
  }

  switchOrganization({required String orgId, required String email}) async {
    print("orgIdZ:$orgId");
    if (GetStorage().read(orgId) != null) {
      isOrganizationChangeLoading(true);
      Map<String, dynamic> jsonMap = json.decode(GetStorage().read(orgId));
      TokenModel tokenModel = TokenModel.fromJson(jsonMap);
      print(tokenModel.idToken == GetStorage().read(AppString.ID_TOKEN));
      if (_checkTokenExpiration(accessToken: tokenModel.accessToken ?? "")
              .isNegative ||
          _checkTokenExpiration(accessToken: tokenModel.accessToken ?? "") <
              1) {
        _getNewToken(refreshToken: tokenModel.refreshToken ?? "", orgId: orgId)
            .then((value) {
          if (value == true) {
            Future.delayed(const Duration(milliseconds: 400),
                () => Get.offAllNamed(Routes.MAIN_SCREEN));
          } else {
            showErrorMessage(message: AppString.error_text);
          }
        });
      } else {
        GetStorage().write(AppString.ORGANIZATION_ID, orgId);
        GetStorage().write(AppString.ID_TOKEN, tokenModel.idToken);
        GetStorage().write(AppString.ACCESS_TOKEN, tokenModel.accessToken);
        GetStorage().write(AppString.REFRESH_TOKEN, tokenModel.refreshToken);
        Future.delayed(const Duration(milliseconds: 400),
            () => Get.offAllNamed(Routes.MAIN_SCREEN));
      }
      isOrganizationChangeLoading(false);
    } else {
      Get.dialog(
          barrierDismissible: true,
          Dialog(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Obx(
                () => Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppString.text_password.tr),
                    customSpacerHeight(height: 10),
                    // Container(
                    //   padding: const EdgeInsets.symmetric(
                    //       horizontal: 16, vertical: 10),
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(12),
                    //     border: Border.all(color: AppColor.hintColor),
                    //   ),
                    //   child: TextField(
                    //     obscureText: true,
                    //     controller: passwordInputController,
                    //     decoration: InputDecoration.collapsed(
                    //         hintText: AppString.text_password.tr),
                    //   ),
                    // ),
                    CustomPassInputField(
                      hint: AppString.text_password.tr,
                      controller: passwordInputController,
                      prefixIcon: Icons.lock_open_outlined,
                      obsValue: isValue.value,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppString
                              .the_password_field_is_required.tr;
                        } else if (value.length < 6) {
                          return AppString.incorrect_user_or_password.tr;
                        } else {
                          return null;
                        }
                      },
                      weight: IconButton(
                        onPressed: () => changeVal(),
                        icon: isValue.isTrue
                            ? const Icon(
                                Icons.visibility_off_outlined,
                                color: AppColor.hintColor,
                              )
                            : const Icon(
                                Icons.remove_red_eye_outlined,
                                color: AppColor.hintColor,
                              ),
                      ),
                    ),
                    customSpacerHeight(height: 10),
                    isNewOrganizationChangeLoading.isTrue
                        ? const Center(
                            child: CupertinoActivityIndicator(
                              color: Colors.blueAccent,
                              radius: 14,
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                  onTap: () => Get.back(canPop: false),
                                  child: Text(AppString.text_cancel.tr)),
                              customSpacerWidth(width: 36),
                              InkWell(
                                  onTap: () async {
                                    isNewOrganizationChangeLoading(true);
                                    try {
                                      if (passwordInputController
                                          .text.isNotEmpty) {
                                        Response response =
                                            await NetworkClient().postRequest(
                                                Api.LOGIN, {
                                          "email": email,
                                          "password":
                                              passwordInputController.text,
                                          "orgId": orgId
                                        });

                                        if (response.hasError) {
                                          logErrorMessage(
                                              logName: "login",
                                              response: response);

                                          showErrorMessage(
                                              message: ErrorModel.fromJson(
                                                          response.body)
                                                      .message ??
                                                  "");
                                        } else {
                                          passwordInputController.clear();
                                          Map<String, dynamic> jsonModel =
                                              TokenModel(
                                            accessToken:
                                                SignInResponse.fromJson(
                                                            response.body)
                                                        .data
                                                        ?.accessToken ??
                                                    "",
                                            idToken: SignInResponse.fromJson(
                                                        response.body)
                                                    .data
                                                    ?.idToken ??
                                                "",
                                            refreshToken:
                                                SignInResponse.fromJson(
                                                            response.body)
                                                        .data
                                                        ?.refreshToken ??
                                                    "",
                                          ).toJson();
                                          String jsonObject =
                                              jsonEncode(jsonModel);
                                          GetStorage().write(orgId, jsonObject);

                                          GetStorage().write(
                                              AppString.ORGANIZATION_ID, orgId);

                                          GetStorage().write(
                                              AppString.ID_TOKEN,
                                              SignInResponse.fromJson(
                                                          response.body)
                                                      .data
                                                      ?.idToken ??
                                                  "");
                                          GetStorage().write(
                                              AppString.ACCESS_TOKEN,
                                              SignInResponse.fromJson(
                                                          response.body)
                                                      .data
                                                      ?.accessToken ??
                                                  "");
                                          GetStorage().write(
                                              AppString.REFRESH_TOKEN,
                                              SignInResponse.fromJson(
                                                          response.body)
                                                      .data
                                                      ?.refreshToken ??
                                                  "");
                                          Future.delayed(
                                              const Duration(milliseconds: 400),
                                              () => Get.offAllNamed(
                                                  Routes.MAIN_SCREEN));
                                        }
                                      }
                                    } catch (e) {
                                      log(e.toString());
                                    }
                                    isNewOrganizationChangeLoading(false);
                                  },
                                  child: Text(AppString.text_ok.tr)),
                              customSpacerWidth(width: 16),
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ));
    }
  }

  void _saveData(String email, String pass, String organizationName) {
    LastInput myInput = LastInput(email: email);
    Map<String, dynamic> jsonModel = myInput.toJson();
    String jsonObject = jsonEncode(jsonModel);
    GetStorage().write(AppString.LAST_INPUT, jsonObject);
  }

  int _checkTokenExpiration({required String accessToken}) {
    DateTime now = DateTime.now();

    // Specify the target date and time
    DateTime targetDate = JwtDecoder.getExpirationDate(accessToken);

    // Calculate the difference
    Duration difference = targetDate.difference(now);

    return difference.inHours;
  }

  Future<bool> _getNewToken(
      {required String orgId, required String refreshToken}) async {
    try {
      Response response = await NetworkClient().postRequest(
          Api.REFRESH_TOKEN, {"orgId": orgId, "refreshToken": refreshToken});

      if (response.hasError) {
        logErrorMessage(logName: "refresh token", response: response);
        return false;
      } else {
        Map<String, dynamic> jsonModel = TokenModel(
          accessToken:
              SignInResponse.fromJson(response.body).data?.accessToken ?? "",
          idToken: SignInResponse.fromJson(response.body).data?.idToken ?? "",
          refreshToken:
              SignInResponse.fromJson(response.body).data?.refreshToken ?? "",
        ).toJson();
        String jsonObject = jsonEncode(jsonModel);
        GetStorage().write(orgId, jsonObject);

        GetStorage().write(AppString.ORGANIZATION_ID, orgId);

        GetStorage().write(AppString.ID_TOKEN,
            SignInResponse.fromJson(response.body).data?.idToken ?? "");
        GetStorage().write(AppString.ACCESS_TOKEN,
            SignInResponse.fromJson(response.body).data?.accessToken ?? "");
        GetStorage().write(AppString.REFRESH_TOKEN,
            SignInResponse.fromJson(response.body).data?.refreshToken ?? "");

        return true;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}

class ChangeMailResponse {
  bool? valid;

  ChangeMailResponse({this.valid});

  ChangeMailResponse.fromJson(Map<String, dynamic> json) {
    valid = json['valid'];
  }
}
