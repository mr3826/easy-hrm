import 'package:get/get.dart';
import 'package:payrun_mobile/modules/notification/model/notification.dart';
import 'package:payrun_mobile/network/exception_helper.dart';
import 'package:payrun_mobile/network/network_client.dart';

import '../../../utils/api_endpoints.dart';

class NotificationController extends GetxController with StateMixin {
  NotificationResponse? notificationResponse;

  List<Data>? newNotification = <Data>[];
  List<Data>? seenNotification = <Data>[];

  List<String?>? newNotificationIdList = [];

  getNewNotification() async {
    change(null, status: RxStatus.loading());
    final response = await NetworkClient()
        .getGraphQuery(queryString: getUnSeenNotificationQuery, variables: {
      "queryData": {"is_seen": false},
      "optionData": {"limit": 50, "offset": 0}
    });

    if (response.hasException) {
      ExceptionHelper.errorHandler(exception: response.exception!);
    } else {
      notificationResponse = NotificationResponse.fromJson(response.data!);
      newNotification = notificationResponse?.getNotificationActivities?.data;
      newNotificationIdList =
          newNotification?.map((e) => e.notification?.id ?? "").toList();
      print("newNotificationIdList:: $newNotificationIdList");
    }

    change(null, status: RxStatus.success());
  }

  getSeenNotification() async {
    change(null, status: RxStatus.loading());
    final response = await NetworkClient()
        .getGraphQuery(queryString: getUnSeenNotificationQuery, variables: {
      "queryData": {"is_seen": true},
      "optionData": {"limit": 50, "offset": 0}
    });

    if (response.hasException) {
      ExceptionHelper.errorHandler(exception: response.exception!);
    } else {
      notificationResponse = NotificationResponse.fromJson(response.data!);
      seenNotification = notificationResponse?.getNotificationActivities?.data;
    }

    change(null, status: RxStatus.success());
  }

  @override
  void onInit() {
    getNewNotification();
    getSeenNotification();
    super.onInit();
  }
}
