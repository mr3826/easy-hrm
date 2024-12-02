import 'package:get/get.dart';
import 'package:payrun_mobile/app/admin_app/leave_hr/presentation/view/widget/calendar/vertical_calendar/calendar_task_card_widget.dart';
import 'package:payrun_mobile/enum.dart';
import '../../../../../common/widget/success_message.dart';
import '../../../../../utils/app_string.dart';
import '../../data/leave_remote_data_source.dart';
import '../model/hr_leave_calender.dart';

class HrLeaveController extends GetxController {
  final HrLeaveRemoteDataSource _leaveRemoteDataSource = Get.find();
  HrLeaveCalender? hrLeaveCalender = HrLeaveCalender();
  RxBool isHrLeaveCalendarLoading = false.obs;
  RxBool updateLeaveLoader = false.obs;

  /// Fetches employee leave data and updates the [hrLeaveCalender] object.
  Future<void> getEmployees({String ? startDate,String? endDate}) async {
    isHrLeaveCalendarLoading(true);
    hrLeaveCalender = await _leaveRemoteDataSource.getLeaveCalender(startDate: startDate,endDate: endDate);
    isHrLeaveCalendarLoading(false);
  }

  /// Constructs and returns a map of tasks grouped by date.
  /// Each task corresponds to a leave request.
  Map<String, List<Task>> getMockedTaskData() {
    final leaveRequests =
        hrLeaveCalender?.getLeavesCalendar?.leaveRequests ?? [];
    final taskData = <String, List<Task>>{};

    for (var leave in leaveRequests) {
      final date = leave.formattedDate ?? "Unknown Date";
      taskData.putIfAbsent(date, () => []).add(_createTask(leave));
    }

    return taskData;
  }

  /// Creates a [Task] object from a [LeaveRequests] object.
  Task _createTask(LeaveRequests leave) {
    return Task(
      name: _getFirstUserName(leave),
      role: _getUserRole(leave),
      leaveType: "Leave Type", // Replace with actual leave type if needed.
      status: _getStatus(leave), // Customize based on leave request status.
      approvedCount: leave.totalApproved ?? 0,
      pendingCount: leave.totalPending ?? 0,
      rejectedCount: leave.totalRejected ?? 0,
      takenCount: leave.totalTaken ?? 0,
      cancelledCount: leave.totalCancelled ?? 0,
      imageUrls: _getUserImages(leave),
      isGroup: (leave.organizationUsers?.length ?? 0) > 1,
      leaveId: _getLeaveId(leave)
    );
  }



  String _getLeaveId(LeaveRequests leave) {

    var data= leave.organizationUsers?.firstWhere((v) => v.leaveId != null).leaveId ?? "";

    print("Leave_id_remote ::: ${data}");

    return data;
  }


  String _getStatus(LeaveRequests leave) {
    if (leave.totalPending == 1) {
      return LeaveStatus.pending.name;
    } else if (leave.totalApproved == 1) {
      return LeaveStatus.approved.name;
    } else if (leave.totalRejected == 1) {
      return LeaveStatus.rejected.name;
    } else if (leave.totalTaken == 1) {
      return LeaveStatus.taken.name;
    } else if (leave.totalCancelled == 1) {
      return LeaveStatus.cancelled.name;
    } else {
      return LeaveStatus.pending.name;
    }
  }

  /// Returns the first user's full name in the leave request.
  String _getFirstUserName(LeaveRequests leave) {
    final profile = leave.organizationUsers?.first.profile;
    return "${profile?.firstName ?? 'Unknown'} ${profile?.lastName ?? ''}"
        .trim();
  }

  /// Returns the role name of the first user in the leave request.
  String _getUserRole(LeaveRequests leave) {
    return leave.organizationUsers?.first.roles?.first.name ?? "Unknown Role";
  }

  /// Returns a list of image URLs or user names if images are unavailable.
  List<String> _getUserImages(LeaveRequests leave) {
    return leave.organizationUsers?.map((user) {
          final imageUrl = user.profile?.image;
          if (imageUrl == null || imageUrl.isEmpty) {
            return "${user.profile?.firstName ?? 'Unknown'} ${user.profile?.lastName ?? ''}"
                .trim();
          }
          return imageUrl;
        }).toList() ??
        [];
  }





  /// update a leave and updates the relevant data if successful.
  Future<void> updateLeave({required String leaveId,String ?status}) async {

    print("leaveId ::: $leaveId");
    updateLeaveLoader(true);
    final bool response =
    await _leaveRemoteDataSource.updateLeave(leaveId: leaveId,status: status);

    if (response) {
      showSuccessMessage(message: AppString.leaveCanceledSuccessMessage.tr);
      getEmployees();
      Get.back(canPop: false);
    }
    updateLeaveLoader(false);
  }





















  @override
  void onInit() {
    getEmployees();
    super.onInit();
  }
}
