import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/common/domain/error_model.dart';
import 'package:payrun_mobile/common/domain/last_input_model.dart';
import 'package:payrun_mobile/common/widget/error_message.dart';
import 'package:payrun_mobile/modules/auth/domain/signin_res.dart';
import 'package:payrun_mobile/network/network_client.dart';
import 'package:payrun_mobile/routes/app_pages.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import '../../../../common/domain/token_model.dart';
import '../../../../network/exception_helper.dart';
import '../../../../utils/api_endpoints.dart';
import '../../../../utils/utils.dart';
import '../../../starting/controller/splash_controller.dart';
import '../../domain/org_subscription_Info_model.dart';

class SignInController extends GetxController with StateMixin {
  RxString organizationAvailabilityMessage = "".obs;
  final isLoading = false.obs;
  final isSubscriptionExpired = false.obs;
  final isSignInLoading = false.obs;
  final isSubscriptionTimeTrackingIsAllow = true.obs;

  RxBool isValue = true.obs;
  OrgSubscriptionInfoModel orgSubscriptionInfoModel =
      OrgSubscriptionInfoModel();

  changeVal() {
    return isValue.value = !isValue.value;
  }

  @override
  void onInit() {
    setLastInputData();
    super.onInit();
  }

  void setLastInputData() {
    if (GetStorage().read(AppString.LAST_INPUT) != null) {
      Map<String, dynamic> jsonMap =
          json.decode(GetStorage().read(AppString.LAST_INPUT));
      LastInput lastInput = LastInput.fromJson(jsonMap);
      emailController.text = lastInput.email ?? "";
    }
  }

  Future<void> login({required String email, required String password}) async {
    isSignInLoading(true);
    try {
      Response response = await NetworkClient()
          .postRequest(Api.LOGIN, {"email": email, "password": password});
      if (response.hasError) {
        logErrorMessage(logName: "login", response: response);

        showErrorMessage(
            message: ErrorModel.fromJson(response.body).message ?? "");
      } else {
        logSuccessMessage(logName: "login", response: response);

        /// save token info or organization switch
        Map<String, dynamic> jsonModel = TokenModel(
          accessToken:
              SignInResponse.fromJson(response.body).data?.accessToken ?? "",
          idToken: SignInResponse.fromJson(response.body).data?.idToken ?? "",
          refreshToken:
              SignInResponse.fromJson(response.body).data?.refreshToken ?? "",
        ).toJson();
        String jsonObject = jsonEncode(jsonModel);

        GetStorage().write(
            SignInResponse.fromJson(response.body).ordId ?? "", jsonObject);

        /// save token info for Api response
        GetStorage().write(AppString.ID_TOKEN,
            SignInResponse.fromJson(response.body).data?.idToken ?? "");
        GetStorage().write(AppString.ACCESS_TOKEN,
            SignInResponse.fromJson(response.body).data?.accessToken ?? "");
        GetStorage().write(AppString.REFRESH_TOKEN,
            SignInResponse.fromJson(response.body).data?.refreshToken ?? "");
        GetStorage().write(AppString.LOGGED_IN, true);
        GetStorage().write(AppString.ORGANIZATION_ID,
            SignInResponse.fromJson(response.body).ordId ?? "");
        _saveData();
        getOrgSubscriptionInfo();
        Get.offNamed(Routes.MAIN_SCREEN);

      }
    } catch (e) {
      log(e.toString());
    }
    isSignInLoading(false);
  }

  getOrgSubscriptionInfo() async {
    try {
      final response = await NetworkClient()
          .graphRequest(queryString: getOrgSubscriptionInfoQuery);
      if (response.hasException) {
        ExceptionHelper.errorHandler(exception: response.exception!,methodName: "getOrgSubscriptionInfo");
      } else {
        orgSubscriptionInfoModel =
            OrgSubscriptionInfoModel.fromJson(response.data!);
        checkIfSubscription();
      }
    } catch (ex) {
      log("getOrgSubscriptionInfo  ::::: $ex");
    }
  }

  void _saveData() {
    LastInput myInput = LastInput(email: emailController.text);
    Map<String, dynamic> jsonModel = myInput.toJson();
    String jsonObject = jsonEncode(jsonModel);
    GetStorage().write(AppString.LAST_INPUT, jsonObject);
  }
}
