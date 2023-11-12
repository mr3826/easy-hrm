import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/modules/auth/domain/organization_info.dart';
import 'package:payrun_mobile/network/network_client.dart';
import 'package:payrun_mobile/utils/app_string.dart';

import '../../../../utils/api_endpoints.dart';
import '../../../../utils/utils.dart';

class SignInController extends GetxController {
  String organizationName = orgNameController.text;
  RxString organizationAvailabilityMessage = "".obs;
  final isLoading = false.obs;

  void getOrganizationDomain() async {
    isLoading(true);
    try {
      Response response = await NetworkClient()
          .getRequest("${Api.COMPANY_DOMAIN}?sub_domain=$organizationName");
      log("getOrganizationDomain::: ${response.body}");
      if (response.hasError) {
        var errorData = json.decode(response.body);
        organizationAvailabilityMessage.value = errorData['message'];
      } else {
        OrganizationInfo organizationInfo = OrganizationInfo.fromJson(
            response.body);
        GetStorage().write(
            AppString.ORGANIZATION_ID, organizationInfo.data!.id);
      }
    } catch (e) {
      log(e.toString());
    }
    isLoading(false);
  }

  void login({required String email, required String password}) async {
    try {
      Response response = await NetworkClient().postRequest(Api.LOGIN, {
      "email": email,
      "password": password,
      "orgId": GetStorage().read(AppString.ORGANIZATION_ID)
      });

      if (response.hasError) {} else {}
    } catch (e) {
      log(e.toString());
    }
  }
}
