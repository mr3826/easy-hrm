import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart' as di;
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

/// Controller responsible for managing the sign-in process
/// including handling login, subscription status, and last input data.
class SignInController extends GetxController with StateMixin {
  // Observable variables to track the state
  RxString organizationAvailabilityMessage = "".obs;
  final isLoading = false.obs;
  final isSubscriptionExpired = false.obs;
  final isSignInLoading = false.obs;
  final isSubscriptionTimeTrackingIsAllow = true.obs;
  RxBool isValue = true.obs;

  // Model to store organization subscription information
  OrgSubscriptionInfoModel orgSubscriptionInfoModel =
      OrgSubscriptionInfoModel();

  /// Instance of NetworkClient to handle API requests
  final NetworkClient _networkClient = Get.find<NetworkClient>();

  /// Toggles the value of [isValue]
  void changeVal() {
    isValue.value = !isValue.value;
  }

  @override
  void onInit() {
    setLastInputData(); // Load last input data when initializing
    super.onInit();
  }

  /// Loads and sets the last input data (email) from storage.
  void setLastInputData() {
    final lastInputJson = GetStorage().read(AppString.LAST_INPUT);
    if (lastInputJson != null) {
      Map<String, dynamic> jsonMap = json.decode(lastInputJson);
      LastInput lastInput = LastInput.fromJson(jsonMap);
      emailController.text = lastInput.email ?? "";
    }
  }

  /// Handles the login process with provided [email] and [password].
  /// Saves token info on success and navigates to the main screen.
  Future<void> login({required String email, required String password}) async {
    isSignInLoading(true); // Start loading
    try {
      // API call to perform login
      di.Response response = await _networkClient.postRequestWithDio(Api.LOGIN, {"email": email, "password": password});
      handleUnknownError(response);
      if (response.statusCode!=200) {
        _handleError(logName: "login", errorMessage: '${response.data['message']}');
      } else {
        _handleLoginSuccess(response);
      }
    } catch (e) {
      log(e.toString());
    }
    isSignInLoading(false); // End loading
  }

  /// Fetches the organization subscription information
  /// and checks the subscription status.
  Future<void> getOrgSubscriptionInfo() async {
    try {
      final response = await _networkClient.graphRequest(
          queryString: getOrgSubscriptionInfoQuery);
      if (response.hasException) {
        ExceptionHelper.errorHandler(
            exception: response.exception!,
            methodName: "getOrgSubscriptionInfo");
      } else {
        orgSubscriptionInfoModel =
            OrgSubscriptionInfoModel.fromJson(response.data!);
        checkIfSubscription();
      }
    } catch (ex) {
      log("getOrgSubscriptionInfo: $ex");
    }
  }

  /// Saves the last input data (email) to local storage.
  void _saveData() {
    LastInput lastInput = LastInput(email: emailController.text);
    String jsonObject = jsonEncode(lastInput.toJson());
    GetStorage().write(AppString.LAST_INPUT, jsonObject);
  }

  // Private helper functions

  /// Handles login success by saving tokens and navigating to the main screen.
  void _handleLoginSuccess(di.Response response) {
    // Save token information
    TokenModel tokenModel = TokenModel(
      accessToken:
          SignInResponse.fromJson(response.data).data?.accessToken ?? "",
      refreshToken:
          SignInResponse.fromJson(response.data).data?.refreshToken ?? "",
    );
    String tokenJson = jsonEncode(tokenModel.toJson());

    // Store tokens in local storage
    GetStorage()
        .write(SignInResponse.fromJson(response.data).ordId ?? "", tokenJson);
    GetStorage().write(AppString.ACCESS_TOKEN, tokenModel.accessToken);
    GetStorage().write(AppString.REFRESH_TOKEN, tokenModel.refreshToken);
    GetStorage().write(AppString.LOGGED_IN, true);
    GetStorage().write(AppString.ORGANIZATION_ID,
        SignInResponse.fromJson(response.data).ordId ?? "");

    // Save last input data and get subscription info
    _saveData();
    getOrgSubscriptionInfo();
  }

  /// Handles errors by showing appropriate error messages and logging.
  void _handleError({required String logName, required String errorMessage}) {
    showErrorMessage(message: errorMessage);
  }
}

