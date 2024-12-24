import 'package:get/get.dart';
import 'package:payrun_mobile/app/global/controller/exit_app_controller.dart';

import '../config/dio_config.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';
import '../services/graphQL_service.dart';
import '../services/rest_service.dart';
import '../services/webSocket_service.dart';

class GlobalBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExitAppController());
    Get.put<AuthService>(AuthService());

    final dio = DioConfig.createDio(Get.find<AuthService>());
    Get.put(RestService(dio));
    Get.put(GraphQLService(Get.find<AuthService>()));
    Get.put(WebSocketService(Get.find<AuthService>()));

    Get.put<ApiService>(ApiService(
        restService: Get.find<RestService>(),
        graphQLService: Get.find<GraphQLService>(),
        webSocketService: Get.find<WebSocketService>()));
  }
}
