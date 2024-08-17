import '../../../../network/exception_helper.dart';
import '../../../../network/network_client.dart';
import '../../../../utils/api_endpoints.dart';
import '../../domain/notification.dart';

class NotificationRemoteDataSource {
  final NetworkClient networkClient;

  NotificationRemoteDataSource(this.networkClient);

  Future<NotificationResponse?> getNewNotification(
      {required int notificationLimit,required int newNotificationOffset}) async {
    final response = await networkClient
        .graphRequest(queryString: getUnSeenNotificationQuery, variables: {
      "queryData": {"is_seen": false, "is_mobile_notification": true},
      "optionData": {"limit": notificationLimit, "offset": newNotificationOffset}
    });

    if (response.hasException) {
      ExceptionHelper.errorHandler(exception: response.exception!);
    } else {
      return NotificationResponse.fromJson(response.data!);
    }
  }

  Future<NotificationResponse?> getSeenNotification(
      {required int notificationLimit,required int seenNotificationOffset}) async {
    final response = await networkClient
        .graphRequest(queryString: getUnSeenNotificationQuery, variables: {
      "queryData": {"is_seen": true, "is_mobile_notification": true},
      "optionData": {"limit": notificationLimit, "offset": seenNotificationOffset}
    });

    if (response.hasException) {
      ExceptionHelper.errorHandler(exception: response.exception!);
    } else {
      return NotificationResponse.fromJson(response.data!);
    }
  }

  Future<bool> markNotificationAsSeen(
      {required List<String?>? newNotificationIdList}) async {
    final response = await networkClient
        .graphRequest(queryString: markAsSeenNotificationQuery, variables: {
      "inputData": {"notificationIds": newNotificationIdList}
    });

    if (response.hasException) {
      ExceptionHelper.errorHandler(exception: response.exception!);
      return false;
    }
    return true;
  }
}
