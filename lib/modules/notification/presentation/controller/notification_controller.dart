import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/modules/notification/data/remote/notification_remote_data_source.dart';
import 'package:payrun_mobile/network/exception_helper.dart';
import 'package:payrun_mobile/network/network_client.dart';

import '../../../../utils/api_endpoints.dart';
import '../../domain/notification.dart';

class NotificationController extends GetxController with StateMixin {
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

  getNewNotifications() async {
    newNotificationOffset.value = 0;
    change(null, status: RxStatus.loading());

    NotificationResponse? notificationResponse =
        await _remoteDataSource.getNewNotification(
            notificationLimit: notificationLimit,
            newNotificationOffset: newNotificationOffset.value);

    newNotificationLength = notificationResponse?.getNotificationActivities
            ?.metaData?.notificationCounts?.unSeenCount ??
        0;
    newNotification?.value =
        notificationResponse?.getNotificationActivities?.data ?? [];

    newNotificationIdList =
        newNotification?.map((e) => e.notification?.id ?? "").toList();
    if (notificationResponse?.getNotificationActivities?.metaData
                ?.notificationCounts?.unSeenCount !=
            null &&
        notificationResponse!.getNotificationActivities!.metaData!
                .notificationCounts!.unSeenCount! >
            newNotification!.length) {
      isMoreNewNotificationAvailable(true);
      newNotificationOffset.value =
          newNotificationOffset.value + notificationLimit;
    } else {
      newNotificationOffset.value = 0;
      isMoreNewNotificationAvailable(false);
    }

    change(null, status: RxStatus.success());
  }

  void getMoreNewNotification() async {
    isMoreNewNotificationLoading(true);
    NotificationResponse? notificationResponse =
        await _remoteDataSource.getNewNotification(
            notificationLimit: notificationLimit,
            newNotificationOffset: newNotificationOffset.value);

    newNotification
        ?.addAll(notificationResponse?.getNotificationActivities?.data ?? []);
    newNotificationIdList?.addAll(
        newNotification?.map((e) => e.notification?.id ?? "").toList() ?? []);
    if (notificationResponse != null &&
        notificationResponse!.getNotificationActivities!.metaData!
                .notificationCounts!.unSeenCount! >
            newNotification!.length) {
      isMoreNewNotificationAvailable(true);
      newNotificationOffset.value =
          newNotificationOffset.value + notificationLimit;
    } else {
      newNotificationOffset.value = 0;
      isMoreNewNotificationAvailable(false);
    }
    isMoreNewNotificationLoading(false);
  }

  getSeenNotification() async {
    seenNotificationOffset.value = 0;
    change(null, status: RxStatus.loading());
    NotificationResponse? notificationResponse =
        await _remoteDataSource.getSeenNotification(
            notificationLimit: notificationLimit,
            seenNotificationOffset: seenNotificationOffset.value);


    seenNotification = notificationResponse?.getNotificationActivities?.data;
    seenNotificationLength = notificationResponse?.getNotificationActivities
            ?.metaData?.notificationCounts?.seenCount ??
        0;
    if (notificationResponse?.getNotificationActivities?.metaData
                ?.notificationCounts?.seenCount !=
            null &&
        notificationResponse!.getNotificationActivities!.metaData!
                .notificationCounts!.seenCount! >
            seenNotification!.length) {
      isMoreSeenNotificationAvailable(true);
      seenNotificationOffset.value =
          seenNotificationOffset.value + notificationLimit;
    } else {
      seenNotificationOffset.value = 0;
      isMoreSeenNotificationAvailable(false);
    }

    change(null, status: RxStatus.success());
  }

  void getMoreSeenNotification() async {
    isMoreSeenNotificationLoading(true);
    NotificationResponse? notificationResponse =
        await _remoteDataSource.getSeenNotification(
            notificationLimit: notificationLimit,
            seenNotificationOffset: seenNotificationOffset.value);

    seenNotification
        ?.addAll(notificationResponse?.getNotificationActivities?.data ?? []);
    if (notificationResponse != null &&
        notificationResponse.getNotificationActivities!.metaData!
                .notificationCounts!.seenCount! >
            seenNotification!.length) {
      isMoreSeenNotificationAvailable(true);
      seenNotificationOffset.value =
          seenNotificationOffset.value + notificationLimit;
    } else {
      seenNotificationOffset.value = 0;
      isMoreSeenNotificationAvailable(false);
    }
    isMoreSeenNotificationLoading(false);
  }

  markNotificationAsSeen() async {
    change(null, status: RxStatus.loading());
    final bool response = await _remoteDataSource.markNotificationAsSeen(
        newNotificationIdList: newNotificationIdList);
    if (response == true) {
      newNotificationIdList?.clear();
      await getNewNotifications();
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
          print("Method come here");
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

    // getNewNotification();
    getNewNotifications();
    getSeenNotification();
    super.onInit();
  }

  final NotificationRemoteDataSource _remoteDataSource =
      Get.find<NotificationRemoteDataSource>();
}
