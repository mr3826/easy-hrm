import '../../../../network/exception_helper.dart';
import '../../../../network/network_client.dart';
import '../../../../utils/api_endpoints.dart';
import '../../domain/notification.dart';

abstract class NotificationRemoteDataInterface {
  Future<NotificationResponse?> getNewNotification(
      {required int notificationLimit, required int newNotificationOffset});
}

class NotificationRemoteDataSource implements NotificationRemoteDataInterface {
  final NetworkClient networkClient;

  NotificationRemoteDataSource(this.networkClient);

  @override
  Future<NotificationResponse?> getNewNotification(
      {required int notificationLimit,
      required int newNotificationOffset}) async {
    final response = await networkClient
        .getGraphQuery(queryString: getUnSeenNotificationQuery, variables: {
      "queryData": {"is_seen": false, "is_mobile_notification": true},
      "optionData": {
        "limit": notificationLimit,
        "offset": newNotificationOffset
      }
    });

    if (response.hasException) {
      ExceptionHelper.errorHandler(exception: response.exception!);
    } else {
      return NotificationResponse.fromJson(response.data!);
    }
  }
}
