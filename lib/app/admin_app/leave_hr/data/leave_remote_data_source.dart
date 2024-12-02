import 'dart:developer';
import '../../../../network/exception_helper.dart';
import '../../../../network/network_client.dart';
import '../../../../utils/api_endpoints.dart';
import '../presentation/model/hr_leave_calender.dart';


class HrLeaveRemoteDataSource {
  final NetworkClient networkClient;

  HrLeaveRemoteDataSource(this.networkClient);

  Future<HrLeaveCalender?> getLeaveCalender([String? startDate, String?endDate]) async {
    try {
      final response = await networkClient
          .graphRequest(queryString: getHrLeaveCalendarList, variables: {
        "queryData": {
          "startDate": "2024-12-01T00:00:00.000Z",
          "endDate": "2024-12-31T23:59:59.999Z"
        },
      });

      print("getLeaveCalender ::: ${response.data}");
      if (response.hasException) {
        log("getLeaveCalender ${response.exception.toString()}",error: 1);

        ExceptionHelper.errorHandler(exception: response.exception!, methodName: "getLeaveCalender");
        return null;
      }

      return HrLeaveCalender.fromJson(response.data!);
    } catch (e) {
      log('Error in getEmployees: $e');
      return null;
    }
  }
}
