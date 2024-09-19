import 'package:get/get.dart';
import 'package:payrun_mobile/common/domain/user_info.dart';
import 'package:payrun_mobile/network/network_client.dart';

import '../../utils/api_endpoints.dart';

class UserInfoController {
  Future<UserInfo?> getUserInfo() async {
    final response = await Get.find<NetworkClient>().getRequest(Api.USER_INFO);
    if (response.statusCode != 200) return null;
    return UserInfo.fromJson(response.data);
  }
}
