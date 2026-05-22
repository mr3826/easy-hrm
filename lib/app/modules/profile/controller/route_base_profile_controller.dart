import 'dart:async';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/modules/profile/repositories/profile_data_source.dart';
import '../../../../common/controller/leave_helper/leave_data_source.dart';
import '../../../../common/widget/error_message.dart';
import '../../../../common/widget/success_message.dart';
import '../../../../modules/leave/data/remote/leave_remote_data_source.dart';
import '../../../../modules/leave/domain/leave_record_response.dart';
import '../../../../modules/leave/domain/leave_type.dart';
import '../models/leave_summary.dart';
import '../models/user_log_history.dart';
import '../models/user_profile.dart';

class ProfileRouteBaseController extends GetxController with StateMixin {
  final ProfileDataSource _profileDataSource;
  final LeaveRemoteDataSource _remoteDataSource;
  final LeaveDataSource _leaveDataSource;

  ProfileRouteBaseController(
      this._profileDataSource, this._remoteDataSource, this._leaveDataSource);

  final isLoadingProfile = false.obs;
  final isViewLeaveSummaryLoading = false.obs;
  final isViewLeaveRecordLoading = false.obs;
  final isLeaveTypeLoading = false.obs;
  LeaveSummary? leaveSummary;
  LeaveTypeDropdown? leaveTypeDropdown;
  String leaveStatusId = "";

  UserDetails? userDetails;
  UserLogHistory? userLogHistory;

  Future<void> getUserProfile({required String ordUserId}) async {
    change(null, status: RxStatus.loading());
    userDetails =
        await _profileDataSource.getProfileInfo(ordUserId) ?? UserDetails();
    change(null, status: RxStatus.success());
  }

  Future<void> getUserLogHistory({required String ordUserId}) async {
    change(null, status: RxStatus.loading());
    userLogHistory = (await _profileDataSource.getUserLogHistory(ordUserId)) ??
        UserLogHistory();
    change(null, status: RxStatus.success());
  }

  Future<List<GetLeaveRecordsForApp>> getLeaveRecordsData(
      {required String orgUserId}) async {
    isViewLeaveRecordLoading(true);
    List<GetLeaveRecordsForApp> leaveRecordList = await _remoteDataSource
            .getLeaveRecordList(orgUserId: orgUserId, limit: 20, offset: 0) ??
        [];
    isViewLeaveRecordLoading(false);
    return leaveRecordList;
  }

  Future<LeaveSummary> getLeaveSummary({required String orgUserId}) async {
    isViewLeaveSummaryLoading(true);
    LeaveSummary leaveSummary =
        await _leaveDataSource.getLeaveSummary() ?? LeaveSummary();
    isViewLeaveSummaryLoading(false);
    return leaveSummary;
  }

  getLeaveTypeDropdown() async {
    isLeaveTypeLoading(true);
    leaveTypeDropdown = await _remoteDataSource.getLeaveTypeDropdown();
    isLeaveTypeLoading(false);
  }

  Future<void> updateORGLeaveAvailability(
      {int? numberOfDays,
      int? numberOfApplication,
      int? maximumConsecutiveDays,
      String? calculateAllowanceBy}) async {
    isLeaveTypeLoading(true);

    Map<String, dynamic> inputData = {
      "inputData": {
        "leave_status_id": leaveStatusId,
        if (calculateAllowanceBy == "no_of_application") ...{
          "available_number_of_applications": numberOfApplication,
          "maximum_consecutive_days": maximumConsecutiveDays,
        } else ...{
          "available_number_of_days": numberOfDays,
        },
      }
    };

    try {
      bool response =
          await _leaveDataSource.updateORGLeaveAvailability(inputData);
      if (response) {
        _updateDate();
      } else {
        showErrorMessage(
            message: "Failed to update leave allowance. Please try again.");
      }
    } catch (e) {
      showErrorMessage(message: "An error occurred: ${e.toString()}");
    } finally {
      isLeaveTypeLoading(false);
    }
  }

  void _updateDate() {
    showSuccessMessage(message: "Leave allowance has been added successfully!");
    Get.back(canPop: false);
    Get.back(canPop: false);
    // getLeaveSummary();
  }
}
