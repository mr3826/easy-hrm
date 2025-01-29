import 'package:get/get.dart';
import 'package:payrun_mobile/app/global/services/api_service.dart';
import 'package:payrun_mobile/app/global/services/local_store_service.dart';
import 'package:payrun_mobile/app/global/services/rest_api_service.dart';
import 'package:payrun_mobile/app/global/controller/exit_app_controller.dart';
import '../../modules/settings/bindings/setting_bindings.dart';
import '../controller/user_info_controller.dart';
import '../services/auth_token_service.dart';
import '../services/graphql_api_service.dart';
import '../services/token_refresh_service.dart';



class GlobalBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(() => ExitAppController());
    // Inject AuthTokenService using Get.put
    Get.put<LocalStoreService>(LocalStoreService());
    // Inject AuthTokenService using Get.put
    Get.put<AuthTokenService>(AuthTokenService());
    // Inject TokenRefreshService using Get.put
    Get.put<TokenRefreshService>(TokenRefreshService());
    // Inject ApiService using Get.put
    Get.put<ApiService>(ApiService(
        restApiService: Get.put<RestApiService>(RestApiService()),
        graphQLApiService: Get.put<GraphQLApiService>(GraphQLApiService())));
    Get.lazyPut(() => UserInfoController(), fenix: true);


  }
}

