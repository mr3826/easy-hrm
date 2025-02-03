import 'dart:async';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../common/controller/leave_helper/leave_data_source.dart';
import '../../../../common/widget/error_message.dart';
import '../../../../common/widget/success_message.dart';
import '../../../../modules/leave/data/remote/leave_remote_data_source.dart';
import '../../../../modules/leave/domain/leave_record_response.dart';
import '../../../../modules/leave/domain/leave_type.dart';
import '../../leave_hr/data/leave_remote_data_source.dart';
import '../../leave_hr/presentation/model/leave_details_by_id.dart';
import '../models/leave_summary.dart';
import '../models/user_profile.dart';
import '../../../../utils/app_string.dart';
import '../repositories/profile_data_source.dart';
import 'global_profile_controller.dart';

class HrProfileController extends GetxController with StateMixin {
  final ProfileDataSource _profileDataSource;

  HrProfileController(this._profileDataSource);
  final HrLeaveRemoteDataSource _hrLeaveRemoteDataSource = Get.find();

  final LeaveRemoteDataSource _remoteDataSource =
      Get.find<LeaveRemoteDataSource>();
  final LeaveDataSource _leaveDataSource = Get.find<LeaveDataSource>();

  @override
  void onInit() {
    getUserProfile();
    super.onInit();
  }
  LeaveDetailsById? leaveDetailsById;
  RxBool isLeaveDetailsByLoading=false.obs;
  int initialTabIndex = 0;
  final isViewLeaveRecordLoading = false.obs;
  final isViewLeaveSummaryLoading = false.obs;
  final isLeaveTypeLoading = false.obs;
  final isLoadingProfile = false.obs;
  String leaveStatusId = "";
  RxInt profileTabIndex = 0.obs;
  RxString calculateAllowanceBy = "".obs;
  String leaveTypeId = "";
  RxString availableLeave = "".obs;

  RxInt offset = 0.obs;
  int limit = 30;

  UserDetails? userDetails;
  List<GetLeaveRecordsForApp>? leaveRecordList;
  LeaveTypeDropdown? leaveTypeDropdown;



  Future<void> getLeaveDetailsById({required String leaveId}) async {
    isLeaveDetailsByLoading(true);
    leaveDetailsById =
    await _hrLeaveRemoteDataSource.getLeaveDetailsById(leaveId);
    isLeaveDetailsByLoading(false);
  }

  Future<void> getUserProfile({String? ordId}) async {
    isLoadingProfile(true);
    userDetails = (await _profileDataSource.getProfileInfo(
            ordId ?? GetStorage().read(AppString.ORGANIZATION_USER_ID))) ??
        UserDetails();
    _addUserInfo();
    isLoadingProfile(false);
  }

  void _addUserInfo() {
    Get.find<ProfileGlobalController>().employeeName.value =
        "${userDetails?.getOrganizationUserDetails?.profile?.firstName ?? ""} ${userDetails?.getOrganizationUserDetails?.profile?.lastName ?? ""}";
    Get.find<ProfileGlobalController>().employeeImeKey.value =
        userDetails?.getOrganizationUserDetails?.profile?.image ?? "";
  }

  Future<List<GetLeaveRecordsForApp>> getLeaveRecordsData() async {
    isViewLeaveRecordLoading(true);
    List<GetLeaveRecordsForApp> leaveRecordList = await _remoteDataSource
            .getLeaveRecordList(limit: limit, offset: offset.value) ??
        [];
    isViewLeaveRecordLoading(false);
    return leaveRecordList;
  }

  Future<LeaveSummary> getLeaveSummary() async {
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
    getLeaveSummary();
  }
}
