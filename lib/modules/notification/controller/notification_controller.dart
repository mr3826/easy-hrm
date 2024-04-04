import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/modules/notification/model/notification.dart';
import 'package:payrun_mobile/network/exception_helper.dart';
import 'package:payrun_mobile/network/network_client.dart';

import '../../../utils/api_endpoints.dart';

class NotificationController extends GetxController with StateMixin {
  NotificationResponse? notificationResponse;

  RxList<Data>? newNotification = <Data>[].obs;
  List<Data>? seenNotification = <Data>[];

  int newNotificationLength = 0;
  int seenNotificationLength = 0;

  List<String?>? newNotificationIdList = [];

  final isNewNotificationHasData = false.obs;
  final isSeenNotificationHasData = false.obs;
  int notificationLimit = 20;
  RxInt newNotificationOffset = 0.obs;
  RxInt seenNotificationOffset = 0.obs;
  final notificationTabBarIndex = 0.obs;

  final isMoreNewNotificationLoading = false.obs;
  final isMoreNewNotificationAvailable = false.obs;
  final isMoreSeenNotificationLoading = false.obs;
  final isMoreSeenNotificationAvailable = false.obs;

  late ScrollController newNotificationScrollController;
  late ScrollController seenNotificationScrollController;

  getNewNotification() async {
    print(
        "newNotificationLimit: $notificationLimit newNotificationOffset:: $newNotificationOffset");
    change(null, status: RxStatus.loading());
    final response = await NetworkClient()
        .getGraphQuery(queryString: getUnSeenNotificationQuery, variables: {
      "queryData": {"is_seen": false, "is_mobile_notification": true},
      "optionData": {
        "limit": notificationLimit,
        "offset": newNotificationOffset.value
      }
    });

    if (response.hasException) {
      ExceptionHelper.errorHandler(exception: response.exception!);
    } else {
      notificationResponse = NotificationResponse.fromJson(response.data!);
      newNotificationLength = notificationResponse
              ?.getNotificationActivities?.metaData?.totalRows ??
          0;
      newNotification?.value =
          notificationResponse?.getNotificationActivities?.data ?? [];
      print("no: lenth:: ${newNotification!.length}");
      newNotificationIdList =
          newNotification?.map((e) => e.notification?.id ?? "").toList();
      if (notificationResponse != null &&
          notificationResponse!
                  .getNotificationActivities!.metaData!.totalRows! >
              newNotification!.length) {
        isMoreNewNotificationAvailable(true);
        newNotificationOffset.value =
            newNotificationOffset.value + notificationLimit;
      } else {
        newNotificationOffset.value = 0;
        isMoreNewNotificationAvailable(false);
      }
    }

    change(null, status: RxStatus.success());
  }

  void getMoreNewNotification() async {
    isMoreNewNotificationLoading(true);
    print(
        "newNotificationLimit: $notificationLimit newNotificationOffset:: $newNotificationOffset");
    final response = await NetworkClient()
        .getGraphQuery(queryString: getUnSeenNotificationQuery, variables: {
      "queryData": {"is_seen": false, "is_mobile_notification": true},
      "optionData": {
        "limit": notificationLimit,
        "offset": newNotificationOffset.value
      }
    });

    if (response.hasException) {
      ExceptionHelper.errorHandler(exception: response.exception!);
    } else {
      notificationResponse = NotificationResponse.fromJson(response.data!);
      newNotification
          ?.addAll(notificationResponse?.getNotificationActivities?.data ?? []);
      print("no: lenth:: ${newNotification!.length}");
      newNotificationIdList?.addAll(
          newNotification?.map((e) => e.notification?.id ?? "").toList() ?? []);
      if (notificationResponse != null &&
          notificationResponse!
                  .getNotificationActivities!.metaData!.totalRows! >
              newNotification!.length) {
        isMoreNewNotificationAvailable(true);
        newNotificationOffset.value =
            newNotificationOffset.value + notificationLimit;
      } else {
        newNotificationOffset.value = 0;
        isMoreNewNotificationAvailable(false);
      }
    }
    isMoreNewNotificationLoading(false);
  }

  getSeenNotification() async {
    change(null, status: RxStatus.loading());
    final response = await NetworkClient()
        .getGraphQuery(queryString: getUnSeenNotificationQuery, variables: {
      "queryData": {"is_seen": true, "is_mobile_notification": true},
      "optionData": {"limit": notificationLimit, "offset": 0}
    });

    if (response.hasException) {
      ExceptionHelper.errorHandler(exception: response.exception!);
    } else {
      notificationResponse = NotificationResponse.fromJson(response.data!);
      seenNotification = notificationResponse?.getNotificationActivities?.data;
      seenNotificationLength = notificationResponse
              ?.getNotificationActivities?.metaData?.totalRows ??
          0;
      if (notificationResponse != null &&
          notificationResponse!
                  .getNotificationActivities!.metaData!.totalRows! >
              seenNotification!.length) {
        isMoreSeenNotificationAvailable(true);
        seenNotificationOffset.value =
            seenNotificationOffset.value + notificationLimit;
      } else {
        seenNotificationOffset.value = 0;
        isMoreSeenNotificationAvailable(false);
      }
    }

    change(null, status: RxStatus.success());
  }

  void getMoreSeenNotification() async {
    isMoreSeenNotificationLoading(true);
    print(
        "newNotificationLimit: $notificationLimit newNotificationOffset:: $newNotificationOffset");
    final response = await NetworkClient()
        .getGraphQuery(queryString: getUnSeenNotificationQuery, variables: {
      "queryData": {"is_seen": true, "is_mobile_notification": true},
      "optionData": {
        "limit": notificationLimit,
        "offset": newNotificationOffset.value
      }
    });

    if (response.hasException) {
      ExceptionHelper.errorHandler(exception: response.exception!);
    } else {
      notificationResponse = NotificationResponse.fromJson(response.data!);
      seenNotification
          ?.addAll(notificationResponse?.getNotificationActivities?.data ?? []);
      if (notificationResponse != null &&
          notificationResponse!
                  .getNotificationActivities!.metaData!.totalRows! >
              seenNotification!.length) {
        isMoreSeenNotificationAvailable(true);
        seenNotificationOffset.value =
            seenNotificationOffset.value + notificationLimit;
      } else {
        seenNotificationOffset.value = 0;
        isMoreSeenNotificationAvailable(false);
      }
    }
    isMoreSeenNotificationLoading(false);
  }

  markNotificationAsSeen() async {
    change(null, status: RxStatus.loading());
    final response = await NetworkClient()
        .getGraphQuery(queryString: markAsSeenNotificationQuery, variables: {
      "inputData": {"notificationIds": newNotificationIdList}
    });

    if (response.hasException) {
      ExceptionHelper.errorHandler(exception: response.exception!);
    } else {
      newNotificationIdList?.clear();
      await getNewNotification();
      await getSeenNotification();
    }

    change(null, status: RxStatus.success());
  }

  @override
  void onInit() {
    newNotificationScrollController = ScrollController()
      ..addListener(() {
        if (newNotificationScrollController.position.pixels ==
            newNotificationScrollController.position.maxScrollExtent) {
          if (isMoreNewNotificationAvailable.isTrue &&
              isMoreNewNotificationLoading.isFalse) {
            getMoreNewNotification();
          }
        }
      });
    seenNotificationScrollController = ScrollController()
      ..addListener(() {
        if (seenNotificationScrollController.position.pixels ==
            seenNotificationScrollController.position.maxScrollExtent) {
          if (isMoreSeenNotificationAvailable.isTrue &&
              isMoreSeenNotificationLoading.isFalse) {
            getMoreSeenNotification();
          }
        }
      });

    getNewNotification();
    getSeenNotification();
    super.onInit();
  }
}
