import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/modules/dashboard/model/timeline_summary_dashboard.dart';
import 'package:payrun_mobile/modules/dashboard/model/upcomming_leave_dashboard.dart';

import 'package:payrun_mobile/network/network_client.dart';

import '../../../network/exception_helper.dart';
import '../../../utils/api_endpoints.dart';
import '../../../utils/app_string.dart';
import '../model/profile_summary_for_dashboard.dart';

class DashboardController extends GetxController with StateMixin {
  @override
  void onInit() {
    getProfileInfoForDashboard();
    getMonthlyTimelineInfoForDashboard();
    getUpComingInfoForDashboard();
    super.onInit();
  }

  ProfileSummaryForDashboard? profileSummaryForDashboard;
  TimelineSummaryDashboard? timelineSummaryDashboard;
  UpcommingLeaveDashboard? upcommingLeaveDashboard;

  getProfileInfoForDashboard() async {
    change(null, status: RxStatus.loading());
    checkTokenExpiration();
    final response = await NetworkClient()
        .getGraphQuery(queryString: profileInfoForDashboardQuery);

    if (response.hasException) {
      ExceptionHelper.errorHandler(exception: response.exception!);
    } else {
      profileSummaryForDashboard =
          ProfileSummaryForDashboard.fromJson(response.data!);
      GetStorage().write(
          AppString.ORGANIZATION_USER_ID,
          profileSummaryForDashboard
                  ?.getProfileSummaryForDashboard?.orgUserId ??
              "");
    }

    change(null, status: RxStatus.success());
  }

  getMonthlyTimelineInfoForDashboard() async {
    change(null, status: RxStatus.loading());
    final response = await NetworkClient()
        .getGraphQuery(queryString: timelineSummaryInfoDashboardQuery);

    if (response.hasException) {
      ExceptionHelper.errorHandler(exception: response.exception!);
    } else {
      timelineSummaryDashboard =
          TimelineSummaryDashboard.fromJson(response.data!);
    }

    change(null, status: RxStatus.success());
  }

  getUpComingInfoForDashboard() async {
    change(null, status: RxStatus.loading());
    final response = await NetworkClient()
        .getGraphQuery(queryString: upcommingLeaveForDashboardQuery);

    if (response.hasException) {
      ExceptionHelper.errorHandler(exception: response.exception!);

    } else {
      upcommingLeaveDashboard =
          UpcommingLeaveDashboard.fromJson(response.data!);
    }

    change(null, status: RxStatus.success());
  }
}
