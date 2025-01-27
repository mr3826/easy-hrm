import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:payrun_mobile/app/global/services/api_service.dart';
import '../../../../modules/timeline/model/timeline_summary_by_date.dart';
import '../../../../utils/api_endpoints.dart';

abstract class TimelineRepository {
  Future<TimelineSummaryByDate?> getTimelineSummaryByDate({required String startDate, required String endDate});
}

class TimelineRepoImpl implements TimelineRepository {
  TimelineApiServices timelineApiServices;
  TimelineRepoImpl(this.timelineApiServices);
  @override
  getTimelineSummaryByDate(
      {required String startDate, required String endDate}) async {
    QueryResult<Object?> response =
        await timelineApiServices.getTimelineSummary(startDate, endDate);

    if (response.data != null) {
      return TimelineSummaryByDate.fromJson(response.data!);
    }
    return null;
  }
}


class TimelineApiServices {
  ApiService apiService;
  TimelineApiServices(this.apiService);

  Future<QueryResult<Object?>> getTimelineSummary(
      String startDate, String endDate,
      [String? orgUserId]) async {
    Map<String, Map<String, dynamic>> variables = {
      "queryData": {
        "start_date": startDate,
        "end_date": endDate,
      }
    };

    if (orgUserId != null) {
      variables["queryData"]?["org_user_ids"] = orgUserId;
    }
    return await apiService.gqlCall(queryString: getTimelineSummaryByDateQuery, variables: variables);
  }
}


