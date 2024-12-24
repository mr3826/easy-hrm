import 'package:get/get.dart';
import 'package:payrun_mobile/app/global/controller/exit_app_controller.dart';
import 'package:payrun_mobile/app/global/services/local_storage_service.dart';

import '../config/dio_config.dart';
import '../services/api_service.dart';
import '../services/auth_token_service.dart';
import '../services/graphQL_service.dart';
import '../services/rest_service.dart';

class GlobalBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExitAppController());
    Get.lazyPut(
      () => LocalStoreService(),
    );
    Get.put<AuthTokenService>(AuthTokenService());

    final dio = DioConfig.createDio(Get.find<AuthTokenService>());
    Get.put(RestService(dio));
    Get.put(GraphQLService(Get.find<AuthTokenService>()));

    Get.put<ApiService>(ApiService(
        restService: Get.find<RestService>(),
        graphQLService: Get.find<GraphQLService>()));
  }
}
