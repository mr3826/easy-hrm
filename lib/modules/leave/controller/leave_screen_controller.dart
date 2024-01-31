import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/success_message.dart';
import 'package:payrun_mobile/common/widget/timePicker/date_time_picker_controller.dart';
import 'package:payrun_mobile/modules/leave/model/leave_summary_dashboard.dart';
import 'package:payrun_mobile/network/exception_helper.dart';
import 'package:payrun_mobile/network/network_client.dart';
import 'package:payrun_mobile/utils/api_endpoints.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import '../../home/view/screen/main_screen.dart';
import '../model/leave_details_by_date.dart';

class LeaveScreenController extends GetxController with StateMixin {
  LeaveSummaryForDashboard? leaveSummaryForDashboard;
  LeaveDetailsByDate? leaveDetailsByDate;
  final isLoading = false.obs;
  final cancelLeaveLoader = false.obs;

  getLeaveSummaryForDashboard() async {
    change(null, status: RxStatus.loading());
    final response = await NetworkClient()
        .getGraphQuery(queryString: getLeaveSummaryForDashboardQuery);

    if (response.hasException) {
      ExceptionHelper.errorHandler(exception: response.exception!);
    } else {
      leaveSummaryForDashboard =
          LeaveSummaryForDashboard.fromJson(response.data!);
    }
    change(null, status: RxStatus.success());
  }

  getLeaveDetailsByDate() async {
    isLoading(true);
    final response = await NetworkClient()
        .getGraphQuery(queryString: getLeaveDetailsByDateQuery, variables: {
      "queryData": {
        "startDate":
            "${Get.find<DateTimePickerController>().inDate.value}T00:00:00",
        "endDate":
            "${Get.find<DateTimePickerController>().inDate.value}T23:59:00"
      }
    });

    if (response.hasException) {
      ExceptionHelper.errorHandler(exception: response.exception!);
    } else {
      leaveDetailsByDate = LeaveDetailsByDate.fromJson(response.data!);
    }

    isLoading(false);
  }

  cancelLeave({required String leaveId}) async {
    cancelLeaveLoader(true);
    final response = await NetworkClient()
        .getGraphQuery(queryString: cancelLeaveQuery, variables: {
      "inputData": {"leave_id": leaveId, "status": "cancelled"}
    });

    if (response.hasException) {
      ExceptionHelper.errorHandler(exception: response.exception!);
    } else {
      showSuccessMessage(message: AppString.leaveCanceledSuccessMessage.tr);
      Get.off(() => const MainScreen(
            routeIndex: 1,
          ));
    }

    cancelLeaveLoader(false);
  }

  removeLeave({required String leaveId}) async {
    cancelLeaveLoader(true);
    final response = await NetworkClient()
        .getGraphQuery(queryString: removeLeaveQuery, variables: {
      "inputData": {"leave_id": leaveId}
    });

    if (response.hasException) {
      ExceptionHelper.errorHandler(exception: response.exception!);
    } else {
      showSuccessMessage(message: AppString.leaveRemovedSuccessMessage.tr);
      Get.off(() => MainScreen(
            routeIndex: 1,
          ));
      await getLeaveSummaryForDashboard();
      await getLeaveDetailsByDate();
    }

    cancelLeaveLoader(false);
  }

  @override
  void onInit() async {
    Get.put(DateTimePickerController());
    await getLeaveSummaryForDashboard();
    await getLeaveDetailsByDate();
    super.onInit();
  }
}
