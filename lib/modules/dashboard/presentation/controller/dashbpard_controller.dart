import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/modules/dashboard/data/remote/dashboard_remote_data_source.dart';
import 'package:payrun_mobile/modules/dashboard/domain/timeline_summary_dashboard.dart';
import 'package:payrun_mobile/modules/dashboard/domain/upcomming_leave_dashboard.dart';
import '../../../../utils/app_string.dart';
import '../../domain/profile_summary_for_dashboard.dart';

/// [DashboardController] handles the fetching of dashboard-related data
/// such as profile information, monthly timeline, and upcoming leaves.
///
/// This controller makes API requests through the [DashboardRemoteDataSource]
/// to get necessary data and stores it in the local state.
/// It uses the GetX `StateMixin` to manage the loading and success states
/// for the UI.
class DashboardController extends GetxController with StateMixin {
  /// Remote data source that communicates with the backend API.
  final DashboardRemoteDataSource _dashboardRemoteDataSource =
  Get.find<DashboardRemoteDataSource>();

  /// Holds the profile summary for the dashboard, fetched from the API.
  ProfileSummaryForDashboard? profileSummaryForDashboard;

  /// Holds the monthly timeline summary, fetched from the API.
  TimelineSummaryDashboard? timelineSummaryDashboard;

  /// Holds the upcoming leave information, fetched from the API.
  UpcommingLeaveDashboard? upcommingLeaveDashboard;

  /// Called when the controller is initialized.
  ///
  /// It sequentially fetches profile info, timeline info, and upcoming leave info.
  @override
  void onInit() async {
    super.onInit();
    await getProfileInfoForDashboard();
    await getMonthlyTimelineInfoForDashboard();
    await getUpComingInfoForDashboard();
  }

  /// Fetches the profile information for the dashboard.
  ///
  /// Updates the state to [RxStatus.loading] before the request and
  /// [RxStatus.success] after successfully fetching the data. The user ID
  /// is stored in GetStorage for future access.
  Future<void> getProfileInfoForDashboard() async {
    change(null, status: RxStatus.loading());
    profileSummaryForDashboard =
    await _dashboardRemoteDataSource.getProfileInfoForDashboard();

    // Store the organization user ID in GetStorage.
    GetStorage().write(
        AppString.ORGANIZATION_USER_ID,
        profileSummaryForDashboard?.getProfileSummaryForDashboard?.orgUserId ??
            "");
    change(null, status: RxStatus.success());
  }

  /// Fetches the monthly timeline information for the dashboard.
  ///
  /// Updates the state to [RxStatus.loading] before the request and
  /// [RxStatus.success] after successfully fetching the data.
  Future<void> getMonthlyTimelineInfoForDashboard() async {
    change(null, status: RxStatus.loading());
    timelineSummaryDashboard =
    await _dashboardRemoteDataSource.getMonthlyTimelineInfoForDashboard();
    change(null, status: RxStatus.success());
  }

  /// Fetches the upcoming leave information for the dashboard.
  ///
  /// Updates the state to [RxStatus.loading] before the request and
  /// [RxStatus.success] after successfully fetching the data.
  Future<void> getUpComingInfoForDashboard() async {
    change(null, status: RxStatus.loading());
    upcommingLeaveDashboard =
    await _dashboardRemoteDataSource.getUpComingInfoForDashboard();
    change(null, status: RxStatus.success());
  }
}
