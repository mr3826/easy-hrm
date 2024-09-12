import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/modules/dashboard/data/remote/dashboard_remote_data_source.dart';
import 'package:payrun_mobile/modules/dashboard/domain/timeline_summary_dashboard.dart';
import 'package:payrun_mobile/modules/dashboard/domain/upcomming_leave_dashboard.dart';
import '../../../../utils/app_string.dart';
import '../../domain/profile_summary_for_dashboard.dart';

class DashboardController extends GetxController with StateMixin {
  @override
  void onInit() async {
    super.onInit();
    await getProfileInfoForDashboard();
    await getMonthlyTimelineInfoForDashboard();
    await getUpComingInfoForDashboard();
  }

  final DashboardRemoteDataSource _dashboardRemoteDataSource =
      Get.find<DashboardRemoteDataSource>();

  ProfileSummaryForDashboard? profileSummaryForDashboard;
  TimelineSummaryDashboard? timelineSummaryDashboard;
  UpcommingLeaveDashboard? upcommingLeaveDashboard;

  getProfileInfoForDashboard() async {
    change(null, status: RxStatus.loading());
    profileSummaryForDashboard =
        await _dashboardRemoteDataSource.getProfileInfoForDashboard();
    GetStorage().write(
        AppString.ORGANIZATION_USER_ID,
        profileSummaryForDashboard?.getProfileSummaryForDashboard?.orgUserId ??
            "");
    change(null, status: RxStatus.success());
  }

  getMonthlyTimelineInfoForDashboard() async {
    change(null, status: RxStatus.loading());
    timelineSummaryDashboard =
        await _dashboardRemoteDataSource.getMonthlyTimelineInfoForDashboard();
    change(null, status: RxStatus.success());
  }

  getUpComingInfoForDashboard() async {
    change(null, status: RxStatus.loading());
    upcommingLeaveDashboard =
        await _dashboardRemoteDataSource.getUpComingInfoForDashboard();
    change(null, status: RxStatus.success());
  }
}
