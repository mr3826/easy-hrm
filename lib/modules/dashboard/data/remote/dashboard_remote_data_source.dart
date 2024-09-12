import 'dart:developer';

import '../../../../network/exception_helper.dart';
import '../../../../network/network_client.dart';
import '../../../../utils/api_endpoints.dart';
import '../../domain/profile_summary_for_dashboard.dart';
import '../../domain/timeline_summary_dashboard.dart';
import '../../domain/upcomming_leave_dashboard.dart';

class DashboardRemoteDataSource {
  final NetworkClient networkClient;

  DashboardRemoteDataSource(this.networkClient);

  Future<ProfileSummaryForDashboard?> getProfileInfoForDashboard() async {
    try {
      final response = await networkClient.graphRequest(
          queryString: profileInfoForDashboardQuery);

      if (response.hasException) {
        log(response.exception.toString());
        ExceptionHelper.errorHandler(
            exception: response.exception!,
            methodName: "getProfileInfoForDashboard");
        return null;
      }

      return ProfileSummaryForDashboard.fromJson(response.data!);
    } catch (e) {
      log('Error in getProfileInfoForDashboard: $e');
      return null;
    }
  }

  Future<TimelineSummaryDashboard?> getMonthlyTimelineInfoForDashboard() async {
    try {
      final response = await networkClient.graphRequest(
          queryString: timelineSummaryInfoDashboardQuery);

      if (response.hasException) {
        log(response.exception.toString());
        ExceptionHelper.errorHandler(
            exception: response.exception!,
            methodName: "getMonthlyTimelineInfoForDashboard");
        return null;
      }

      return TimelineSummaryDashboard.fromJson(response.data!);
    } catch (e) {
      log('Error in getMonthlyTimelineInfoForDashboard: $e');
      return null;
    }
  }

  Future<UpcommingLeaveDashboard?> getUpComingInfoForDashboard() async {
    try {
      final response = await networkClient.graphRequest(
          queryString: upcommingLeaveForDashboardQuery);

      if (response.hasException) {
        log(response.exception.toString());
        ExceptionHelper.errorHandler(
            exception: response.exception!,
            methodName: "getUpComingInfoForDashboard");
        return null;
      }

      return UpcommingLeaveDashboard.fromJson(response.data!);
    } catch (e) {
      log('Error in getUpComingInfoForDashboard: $e');
      return null;
    }
  }
}
