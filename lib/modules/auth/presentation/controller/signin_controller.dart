import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/common/domain/error_model.dart';
import 'package:payrun_mobile/common/domain/last_input_model.dart';
import 'package:payrun_mobile/modules/auth/domain/organization_info.dart';
import 'package:payrun_mobile/network/network_client.dart';
import 'package:payrun_mobile/utils/app_string.dart';

import '../../../../utils/api_endpoints.dart';
import '../../../../utils/utils.dart';

class SignInController extends GetxController with StateMixin {
  RxString organizationAvailabilityMessage = "".obs;
  final isLoading = false.obs;
  final isSignInLoading = false.obs;
  RxBool isValue = true.obs;

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
      passwordController.text = lastInput.password ?? "";
      orgNameController.text = lastInput.orgName ?? "";
    }
  }

  void getOrganizationDomain() async {
    isLoading(true);
    try {
      Response response = await NetworkClient().getRequest(
          "${Api.COMPANY_DOMAIN}?sub_domain=${orgNameController.text}");
      log("getOrganizationDomain::: ${response.body}");
      if (response.status.hasError) {
        ErrorModel errorModel = ErrorModel.fromJson(response.body);
        organizationAvailabilityMessage.value =
            errorModel.message ?? "Some Error occur!";
      } else {
        organizationAvailabilityMessage("");
        OrganizationInfo organizationInfo =
            OrganizationInfo.fromJson(response.body);
        GetStorage()
            .write(AppString.ORGANIZATION_ID, organizationInfo.data!.id);
      }
    } catch (e) {
      log(e.toString());
    }
    isLoading(false);
  }

  void login({required String email, required String password}) async {
    isSignInLoading(true);
    try {
      Response response = await NetworkClient().postRequest(Api.LOGIN, {
        "email": email,
        "password": password,
        "orgId": GetStorage().read(AppString.ORGANIZATION_ID)
      });

      log(response.body.toString());

      if (response.hasError) {

      } else {
        _saveData();
      }
    } catch (e) {
      log(e.toString());
    }
    isSignInLoading(false);
  }

  void _saveData() {
    LastInput myInput = LastInput(
        email: emailController.text,
        password: passwordController.text,
        orgName: orgNameController.text);
    Map<String, dynamic>jsonModel=myInput.toJson();
    String jsonObject = jsonEncode(jsonModel);
    GetStorage().write(AppString.LAST_INPUT, jsonObject);
  }
}
