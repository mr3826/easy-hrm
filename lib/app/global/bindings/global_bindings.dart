import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/app/global/services/api_service.dart';
import 'package:payrun_mobile/app/global/services/local_store_service.dart';
import 'package:payrun_mobile/app/global/services/rest_api_service.dart';
import 'package:payrun_mobile/app/global/controller/exit_app_controller.dart';
import 'package:payrun_mobile/app/modules/profile/controller/global_profile_controller.dart';
import '../controller/user_info_controller.dart';
import '../services/auth_token_service.dart';
import '../services/graphql_api_service.dart';
import '../services/token_refresh_service.dart';

class GlobalBindings extends Bindings {
  @override
  void dependencies() async {
    await GetStorage.init();

    Get.lazyPut(() => ExitAppController());
    // Inject AuthTokenService using Get.put
    Get.lazyPut<LocalStoreService>(() => LocalStoreService(), fenix: true);
    // Inject AuthTokenService using Get.put
    Get.lazyPut<AuthTokenService>(() => AuthTokenService(), fenix: true);
    // Inject TokenRefreshService using Get.put
    Get.lazyPut<TokenRefreshService>(() => TokenRefreshService(), fenix: true);
    // Inject ApiService using Get.put
    Get.put(
        ApiService(
            restApiService: Get.put<RestApiService>(RestApiService()),
            graphQLApiService: Get.put<GraphQLApiService>(GraphQLApiService())),
        permanent: true);

    Get.put(UserInfoController(), permanent: true);
  }
}
