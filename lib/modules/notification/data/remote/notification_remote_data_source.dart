import '../../../../network/exception_helper.dart';
import '../../../../network/network_client.dart';
import '../../../../utils/api_endpoints.dart';
import '../../domain/notification.dart';

class NotificationRemoteDataSource {
  final NetworkClient networkClient;

  NotificationRemoteDataSource(this.networkClient);

  Future<NotificationResponse?> getNewNotification(
      {required int newNotificationOffset}) async {
    print("Method come here");
    final response = await networkClient
        .getGraphQuery(queryString: getUnSeenNotificationQuery, variables: {
      "queryData": {"is_seen": false, "is_mobile_notification": true},
      "optionData": {"limit": 15, "offset": newNotificationOffset}
    });

    print("Method res: ${response.data!}");

    if (response.hasException) {
      ExceptionHelper.errorHandler(exception: response.exception!);
    } else {
      return NotificationResponse.fromJson(response.data!);
    }
  }

  Future<NotificationResponse?> getSeenNotification(
      {required int seenNotificationOffset}) async {
    final response = await networkClient
        .getGraphQuery(queryString: getUnSeenNotificationQuery, variables: {
      "queryData": {"is_seen": true, "is_mobile_notification": true},
      "optionData": {"limit": 15, "offset": seenNotificationOffset}
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
        .getGraphQuery(queryString: markAsSeenNotificationQuery, variables: {
      "inputData": {"notificationIds": newNotificationIdList}
    });

    if (response.hasException) {
      ExceptionHelper.errorHandler(exception: response.exception!);
      return false;
    }
    return true;
  }
}
