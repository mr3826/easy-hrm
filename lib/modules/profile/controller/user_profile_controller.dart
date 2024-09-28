import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:payrun_mobile/common/controller/user_info_controller.dart';
import 'package:payrun_mobile/common/domain/token_model.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/error_message.dart';
import 'package:payrun_mobile/common/widget/success_message.dart';
import 'package:payrun_mobile/modules/leave/presentation/controller/leave_record_controller.dart';
import 'package:payrun_mobile/modules/leave/presentation/controller/leave_screen_controller.dart';
import 'package:payrun_mobile/modules/profile/controller/profile_image_selected_controller.dart';
import 'package:payrun_mobile/modules/profile/model/employee_work_history.dart';
import 'package:payrun_mobile/modules/profile/model/user_log_history.dart';
import 'package:payrun_mobile/modules/timeline/controller/timeline_controller.dart';
import 'package:payrun_mobile/modules/timeline/controller/timelog_summary_controller.dart';
import 'package:payrun_mobile/network/network_client.dart';
import 'package:payrun_mobile/routes/app_pages.dart';
import 'package:payrun_mobile/utils/api_endpoints.dart';
import '../../../common/controller/date_time_controller.dart';
import '../../../common/domain/error_model.dart';
import '../../../common/domain/user_info.dart';
import '../../../common/widget/custom_password_text_field.dart';
import '../../../network/exception_helper.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_string.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/images.dart';
import '../../../utils/utils.dart';
import '../../auth/domain/signin_res.dart';
import '../../dashboard/presentation/controller/dashbpard_controller.dart';
import '../../notification/presentation/controller/notification_controller.dart';
import '../../timeline/controller/timer_controller.dart';
import '../model/organization_info.dart';
import '../model/user_profile.dart';
import 'package:dio/dio.dart' as di;

class UserProfileController extends GetxController with StateMixin {
  @override
  void onInit() {
    getUserProfile();
    getEmploymentInfo();
    getUserLogHistory();
    getOrganizationInfo();
    startTimer();
    super.onInit();
  }

  RxInt seconds = 59.obs;
  RxBool timerActive = false.obs;
  RxBool isOTPProvided = false.obs;
  String otpCode = "";

  final NetworkClient _networkClient = Get.find<NetworkClient>();

  void startTimer() {
    timerActive.value = true;
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (seconds.value == 0) {
        timer.cancel();
        timerActive.value = false;
      } else {
        seconds.value--;
      }
    });
  }

  RxBool isValue = true.obs;

  changeVal() {
    return isValue.value = !isValue.value;
  }

  var firstName = "".obs;
  var lastName = "".obs;
  var address = "".obs;
  var phone = "".obs;
  var emergencyNumber = "".obs;
  var description = "".obs;

  bool get isEnableEditButton {
    return firstName.isNotEmpty ||
        lastName.isNotEmpty ||
        address.isNotEmpty ||
        phone.isNotEmpty ||
        emergencyNumber.isNotEmpty ||
        description.isNotEmpty ||
        Get.find<PikedProfileImgController>()
            .storageForUpload
            .filePath
            .value
            .isNotEmpty;
  }

  UserDetails? userDetails;
  EmployeeWorkHistory? employeeWorkHistory;
  UserLogHistory? userLogHistory;
  OrganizationInfoDetails? organizationInfo;
  final isLoading = false.obs;
  final isLoadingChangeEmail = false.obs;
  final isOrganizationChangeLoading = false.obs;
  final isNewOrganizationChangeLoading = false.obs;
  final isVerificationApiLoading = false.obs;
  RxBool isSelected = false.obs;
  final resendOtpLoading = false.obs;

  var isOtpString = ''.obs;

  bool get isButtonEnabledForOTP {
    return isOtpString.isNotEmpty;
  }

  final passwordInputController = TextEditingController();

  getUserProfile() async {
    change(null, status: RxStatus.loading());
    final response = await _networkClient.graphRequest(
        queryString: getUserProfileQuery,
        variables: {
          "orgUserId": GetStorage().read(AppString.ORGANIZATION_USER_ID)
        });
    if (response.hasException) {
      ExceptionHelper.errorHandler(
          exception: response.exception!, methodName: "getUserProfile");
    } else {
      userDetails = UserDetails.fromJson(response.data!);
    }
    change(null, status: RxStatus.success());
  }

  getEmploymentInfo() async {
    change(null, status: RxStatus.loading());
    final response = await _networkClient.graphRequest(
      queryString: getEmploymentInfoQuery,
    );

    if (response.hasException) {
      ExceptionHelper.errorHandler(
          exception: response.exception!, methodName: "getEmploymentInfo");
    } else {
      employeeWorkHistory = EmployeeWorkHistory.fromJson(response.data!);
    }

    change(null, status: RxStatus.success());
  }

  getUserLogHistory() async {
    change(null, status: RxStatus.loading());
    final response =
        await _networkClient.graphRequest(queryString: userLogHistoryQuery);
    if (response.hasException) {
      ExceptionHelper.errorHandler(
          exception: response.exception!, methodName: "getUserLogHistory");
    } else {
      userLogHistory = UserLogHistory.fromJson(response.data!);
    }
    change(null, status: RxStatus.success());
  }

  Future<bool> getPasswordVerification({required String password}) async {
    bool validation = false;
    isLoading(true);
    try {
      final response = await _networkClient
          .postRequest(Api.VERIFY_PASSWORD, {"password": password});
      if (response.statusCode == 200) {
        ChangeMailResponse value = ChangeMailResponse.fromJson(response.data);
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

    isLoadingChangeEmail(true);
    try {
      final response = await _networkClient.postRequest(Api.CHANGE_MAIL, {
        "newEmail": newEmail,
        "employeeId": GetStorage().read(AppString.ORGANIZATION_USER_ID) ?? ""
      });
      if (response.statusCode == 200) {
        validation = true;
      }
    } catch (e) {
      log(e.toString());
    }
    isLoadingChangeEmail(false);
    return validation;
  }

  submitVerificationCode({required String verificationCode}) async {
    isVerificationApiLoading(true);
    try {
      final response =
          await _networkClient.postRequest(Api.VERIFY_CHANGE_MAIL_OTP, {
        "confirmationCode": verificationCode,
        "accessToken": GetStorage().read(AppString.ACCESS_TOKEN)
      });
      if (response.statusCode == 200) {
        _handleResponseSuccess();
      }
    } catch (e) {
      log(e.toString());
    }
    isVerificationApiLoading(false);
  }

  resendOtp({required String emailAddress}) async {
    resendOtpLoading(true);
    try {
      final response = await _networkClient.postRequest(
          Api.RESEND_OTP_CHANGE_EMAIL, {
        "email": emailAddress,
        "orgId": GetStorage().read(AppString.ORGANIZATION_ID)
      });
      if (response.statusCode == 200) {
        seconds.value = 59;
        startTimer();
        showSuccessMessage(message: AppString.resend_otp_text.tr);
      }
    } catch (e) {
      log(e.toString());
    }
    resendOtpLoading(false);
  }

  getOrganizationInfo() async {
    change(null, status: RxStatus.loading());
    final response =
        await _networkClient.graphRequest(queryString: organizationInfoQuery);
    if (response.hasException) {
      ExceptionHelper.errorHandler(
          exception: response.exception!, methodName: "getOrganizationInfo");
    } else {
      organizationInfo = OrganizationInfoDetails.fromJson(response.data!);
    }
    change(null, status: RxStatus.success());
  }

  switchOrganization({required String orgId, required String email}) async {


    print("GetStorage().read(orgId)  :: ${GetStorage().read(orgId) }");

    if (GetStorage().read(orgId) != null) {
      isOrganizationChangeLoading(true);
      Map<String, dynamic> jsonMap = json.decode(GetStorage().read(orgId));
      TokenModel tokenModel = TokenModel.fromJson(jsonMap);
      if (_checkTokenExpiration(accessToken: tokenModel.accessToken ?? "")
              .isNegative ||
          _checkTokenExpiration(accessToken: tokenModel.accessToken ?? "") <
              1) {
        _getNewToken(
                refreshToken: tokenModel.refreshToken ?? "",
                orgId: orgId,
                accessToken: tokenModel.accessToken ?? "")
            .then((value) {
          if (value == true) {
            Get.find<UserInfoController>().getOrgSubscriptionInfo();
            if (Get.find<UserInfoController>().isSubscriptionExpired.isFalse) {
              switchOrganisationDataChange();
            }
          } else {
            showErrorMessage(message: AppString.error_text);
          }
        });
      } else {
        await GetStorage()
            .write(AppString.ACCESS_TOKEN, tokenModel.accessToken);
        await GetStorage()
            .write(AppString.REFRESH_TOKEN, tokenModel.refreshToken);

        final userInfoResponse =
            await Get.find<UserInfoController>().getUserInfo();

        _handleUserInfo(userInfoResponse);

        Get.find<UserInfoController>().getOrgSubscriptionInfo();
        if (Get.find<UserInfoController>().isSubscriptionExpired.isFalse) {
          switchOrganisationDataChange();
        }
      }
      Get.back(canPop: false);
      Get.back(canPop: false);
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
                    _orgPassword(),
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
                                        di.Response response =
                                            await Get.find<NetworkClient>()
                                                .postRequest(Api.LOGIN, {
                                          "email": email,
                                          "password":
                                              passwordInputController.text,
                                          "orgId": orgId
                                        });

                                        if (response.statusCode == 200) {
                                          passwordInputController.clear();

                                          _handleTokenInfo(response);

                                          final userInfoResponse = await Get
                                                  .find<UserInfoController>()
                                              .getUserInfo();

                                          _handleLoginSuccess(
                                              response, userInfoResponse);

                                          Get.find<UserInfoController>()
                                              .getOrgSubscriptionInfo();
                                          if (Get.find<UserInfoController>()
                                              .isSubscriptionExpired
                                              .isFalse) {
                                            switchOrganisationDataChange();
                                          }
                                        }
                                      }
                                    } catch (e) {
                                      log(e.toString());
                                    } finally {
                                      Get.back(canPop: false);
                                      Get.back(canPop: false);
                                      Get.back(canPop: false);
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

  int _checkTokenExpiration({required String accessToken}) {
    DateTime now = DateTime.now();

    // Specify the target date and time
    DateTime targetDate = JwtDecoder.getExpirationDate(accessToken);

    // Calculate the difference
    Duration difference = targetDate.difference(now);

    return difference.inHours;
  }

  Future<bool> _getNewToken(
      {required String accessToken,
      required String refreshToken,
      required String orgId}) async {
    try {
      var response = await Get.find<NetworkClient>().postRequest(
          Api.REFRESH_TOKEN,
          {"accessToken": accessToken, "refreshToken": refreshToken});

      if (response.statusCode != 200) {
        return false;
      } else {
        _handleTokenInfo(response);

        final userInfoResponse =
            await Get.find<UserInfoController>().getUserInfo();

        _handleLoginSuccess(response, userInfoResponse);

        return true;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  _orgPassword() {
    return CustomPasswordInputField(
      controller: passwordInputController,
      hitText: AppString.text_password.tr,
      prefixIcon: Image.asset(Images.LOCK_ICON),
      validator: (value) {
        if (value!.isEmpty) {
          return AppString.the_password_field_is_required.tr;
        } else if (value.length < 6) {
          return AppString.incorrect_user_or_password.tr;
        } else {
          return null;
        }
      },
      hintStyle: TextStyle(
          color: AppColor.normalTextColor.withOpacity(0.4),
          fontFamily: "Poppins",
          fontSize: Dimensions.fontSizeDefault + 1),
    );
  }

  void _handleTokenInfo(di.Response response) {
    GetStorage().write(AppString.ACCESS_TOKEN,
        SignInResponse.fromJson(response.data).data?.accessToken);
    GetStorage().write(AppString.REFRESH_TOKEN,
        SignInResponse.fromJson(response.data).data?.refreshToken);
  }

  void _handleLoginSuccess(di.Response response, UserInfo? userInfo) {
    // Save token information
    TokenModel tokenModel = TokenModel(
      accessToken:
          SignInResponse.fromJson(response.data).data?.accessToken ?? "",
      refreshToken:
          SignInResponse.fromJson(response.data).data?.refreshToken ?? "",
    );
    String tokenJson = jsonEncode(tokenModel.toJson());

    // Store tokens in local storage
    GetStorage().write(userInfo?.user?.organizationId ?? "", tokenJson);

    GetStorage()
        .write(AppString.ORGANIZATION_ID, userInfo?.user?.organizationId ?? "");
    // Store the organization user ID in GetStorage.
    GetStorage()
        .write(AppString.ORGANIZATION_USER_ID, userInfo?.user?.orgUserId ?? "");
  }

  void _handleUserInfo(UserInfo? userInfo) {
    GetStorage()
        .write(AppString.ORGANIZATION_ID, userInfo?.user?.organizationId ?? "");
    // Store the organization user ID in GetStorage.
    GetStorage()
        .write(AppString.ORGANIZATION_USER_ID, userInfo?.user?.orgUserId ?? "");
  }

  void _handleResponseSuccess() {
    changeEmailController.clear();
    Get.back(canPop: false);
    Get.back(canPop: false);
    GetStorage().remove(AppString.ACCESS_TOKEN);
    GetStorage().remove(AppString.LOGGED_IN);
    Get.offAllNamed(Routes.SIGN_IN_SCREEN);
  }
}

class ChangeMailResponse {
  bool? valid;

  ChangeMailResponse({this.valid});

  ChangeMailResponse.fromJson(Map<String, dynamic> json) {
    valid = json['valid'];
  }
}

switchOrganisationDataChange() async {
  await Get.find<TimeCounterController>().timerStatus();

  Get.find<UserProfileController>()
    ..getUserProfile()
    ..getEmploymentInfo()
    ..getUserLogHistory()
    ..getOrganizationInfo();

  Get.find<TimelineController>()
    ..getTimelineSummaryByMonth(
        startDate:
            "${DateTime(DateTime.now().year, DateTime.now().month, 1, 0, 0, 0)}",
        endDate:
            "${DateTime(DateTime.now().year, DateTime.now().month + 1, 0, 23, 59, 59)}")
    ..getCalendarTimelineDataByDate(
        startDate:
            "${DateTime(DateTime.parse(Get.find<DateTimeController>().requestedDate.value).year, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).month, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).day, 0, 0, 0)}",
        endDate:
            "${DateTime(DateTime.parse(Get.find<DateTimeController>().requestedDate.value).year, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).month, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).day, 23, 59, 59)}")
    ..getTimelineSummaryByDate(
        startDate:
            "${DateTime(DateTime.parse(Get.find<DateTimeController>().requestedDate.value).year, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).month, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).day, 0, 0, 0)}",
        endDate:
            "${DateTime(DateTime.parse(Get.find<DateTimeController>().requestedDate.value).year, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).month, DateTime.parse(Get.find<DateTimeController>().requestedDate.value).day, 23, 59, 59)}");

  Get.find<TimelineSummaryController>()
    ..getTimelineByMonth()
    ..getTimelogDetailsByMonth();
  Get.find<NotificationController>()
    ..getNewNotifications()
    ..getSeenNotification();
  Get.find<LeaveRecordsController>().getLeaveRecordsData();
  Get.find<LeaveScreenController>()
    ..getLeaveSummaryForDashboard()
    ..getLeaveDetailsByDate();
  Get.find<DashboardController>()
    ..getProfileInfoForDashboard()
    ..getMonthlyTimelineInfoForDashboard()
    ..getUpComingInfoForDashboard();
}
