// import 'dart:async';
// import 'package:get/get.dart';
// import '../../../../common/controller/leave_helper/leave_data_source.dart';
// import '../../../../common/controller/profile_helper/profile_data_source.dart';
// import '../../../../common/widget/error_message.dart';
// import '../../../../common/widget/success_message.dart';
// import '../../../leave/data/remote/leave_remote_data_source.dart';
// import '../../../leave/domain/leave_record_response.dart';
// import '../../../leave/domain/leave_type.dart';
// import '../../model/leave_summary.dart';
// import '../../model/user_profile.dart';
//
// class HrProfileController extends GetxController with StateMixin {
//   @override
//   void onInit() {
//     getUserProfile();
//     super.onInit();
//   }
//
//   UserDetails? userDetails;
//   final ProfileDataSource _profileDataSource = Get.find<ProfileDataSource>();
//   final LeaveRemoteDataSource _remoteDataSource =
//       Get.find<LeaveRemoteDataSource>();
//   final LeaveDataSource _leaveDataSource = Get.find<LeaveDataSource>();
//   int initialTabIndex = 0;
//
//   final isViewLeaveRecordLoading = false.obs;
//   final isViewLeaveSummaryLoading = false.obs;
//   final isLeaveTypeLoading = false.obs;
//   final isLoadingProfile = false.obs;
//   String leaveStatusId = "";
//   RxInt profileTabIndex = 0.obs;
//   RxString calculateAllowanceBy = "".obs;
//   String leaveTypeId = "";
//   RxString availableLeave = "".obs;
//
//   RxInt offset = 0.obs;
//   int limit = 30;
//   List<GetLeaveRecordsForApp>? leaveRecordList;
//   LeaveTypeDropdown? leaveTypeDropdown;
//   LeaveSummary? leaveSummary;
//
//   Future<void> getUserProfile() async {
//     isLoadingProfile(true);
//     userDetails = (await _profileDataSource.getUserProfile()) ?? UserDetails();
//     print(
//         "userDetails : ${userDetails?.getOrganizationUserDetails?.department?.name}");
//     isLoadingProfile(false);
//   }
//
//   getLeaveRecordsData() async {
//     isViewLeaveRecordLoading(true);
//     leaveRecordList = await _remoteDataSource.getLeaveRecordList(
//         limit: limit, offset: offset.value);
//
//     isViewLeaveRecordLoading(false);
//   }
//
//   getLeaveSummary() async {
//     isViewLeaveSummaryLoading(true);
//     leaveSummary = await _leaveDataSource.getLeaveSummary();
//     isViewLeaveSummaryLoading(false);
//   }
//
//   getLeaveTypeDropdown() async {
//     isLeaveTypeLoading(true);
//     leaveTypeDropdown = await _remoteDataSource.getLeaveTypeDropdown();
//     isLeaveTypeLoading(false);
//   }
//
//   Future<void> updateORGLeaveAvailability({int? numberOfDays, int? numberOfApplication, int? maximumConsecutiveDays, String? calculateAllowanceBy}) async {
//     // Prepare input data based on the allowance calculation type
//     Map<String, dynamic> inputData = {
//       "inputData": {
//         "leave_status_id": leaveStatusId,
//         if (calculateAllowanceBy == "no_of_application") ...{
//           "available_number_of_applications": numberOfApplication,
//           "maximum_consecutive_days": maximumConsecutiveDays,
//         } else ...{
//           "available_number_of_days": numberOfDays,
//         },
//       }
//     };
//
//     isLeaveTypeLoading(true);
//     try {
//       // Call the data source with the prepared input data
//       bool response = await _leaveDataSource.updateORGLeaveAvailability(inputData);
//       // Handle response
//       if (response) {
//         showSuccessMessage(message: "Leave allowance has been added successfully!");
//         Get.back(canPop: false); // Close another screen
//         Get.back(canPop: false); // Close another screen
//         getLeaveSummary(); // Refresh leave summary
//       } else {
//         showErrorMessage(
//             message: "Failed to update leave allowance. Please try again.");
//       }
//     } catch (e) {
//       showErrorMessage(message: "An error occurred: ${e.toString()}");
//     } finally {
//       isLeaveTypeLoading(false);
//     }
//   }
// }
