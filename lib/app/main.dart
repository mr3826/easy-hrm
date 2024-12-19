import 'package:get/get.dart';
import 'package:payrun_mobile/app/global/services/api_service.dart';
import 'package:payrun_mobile/app/global/services/auth_service.dart';
import 'package:payrun_mobile/app/global/services/rest_service.dart';
import 'package:payrun_mobile/app/global/services/webSocket_service.dart';

import 'global/config/dio_config.dart';
import 'global/services/graphQL_service.dart';

void main() async {
  AuthService authService = AuthService();

  final dio = DioConfig.createDio(authService);

  RestService restService = RestService(dio);
  GraphQLService graphQLService = GraphQLService(authService);
  WebSocketService webSocketService = WebSocketService(authService);

  Get.put<ApiService>(ApiService(
      restService: restService,
      graphQLService: graphQLService,
      webSocketService: webSocketService));
}
