import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_card_style.dart';
import 'package:payrun_mobile/common/widget/custom_network_image.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import '../../../../../../common/widget/custom_appbar.dart';
import '../../../../../../common/widget/custom_buttom_sheet.dart';
import '../../../../../../common/widget/custom_drawer.dart';
import '../../../../../../common/widget/custom_svg_image.dart';
import '../../../../../../modules/profile/controller/user_profile_controller.dart';
import '../../../../../../utils/app_string.dart';
import '../../../../../../utils/app_style.dart';
import '../../../../../../utils/dimensions.dart';
import '../../../../../../utils/images.dart';
import '../../../../../../utils/utils.dart';
import '../../../../../modules/auth/view/screens/otp_screen.dart';
import '../../../../employee/view/widget/serach_employee_list/search_employee_list.dart';
import '../../controller/hr_leave_controller.dart';
import '../../controller/leave_controller.dart';
import '../widget/assign_leave/assign_leave.dart';
import '../widget/calendar/vertical_calendar/calendar_view.dart';
import '../widget/calendar/month_navigate_widget.dart';
import '../widget/leave_record/date_navigate_widget.dart';
import '../widget/leave_record/leave_record_list.dart';
import '../widget/leave_tabbar_body/leave_tabbar_widget.dart';

class LeaveHrScreen extends StatelessWidget {
  const LeaveHrScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      floatingActionButton: _assignLeave(context),
      body: Padding(
        padding: marginLayout.copyWith(left: 8, right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Tab-bar layout
            const BuildTabBar(),
            customSpacerHeight(height: 12),

            ///build search employee list
            Obx(() => _buildSearchBar(context, onSearch: () {
                  _showEmployeeSelectionSheet();
                })),

            ///Tab-bar view according to index
            Obx(
              () => Get.find<LeaveController>().tabLength.value == 0
                  ? _buildCalendar()
                  : _leaveRecordeList(),
            ),
          ],
        ),
      ),
    );
  }

  // App bar method renamed and optimized for readability
  _buildAppBar() {
    return customAppbar(
      leadingIcon: Text(
        AppString.text_leave.tr,
        style: AppStyle.normal_text_black.copyWith(
          fontSize: Dimensions.fontSizeMid,
        ),
      ),
      leadingWidth: MediaQuery.of(Get.context!).size.width / 4.5,
      centerTitle: false,
      actions: [
        customSvgImage(
          imageUrl: Images.notificationIconNavOutLine,
          height: 26,
          width: 26,
        ),
        const SizedBox(width: 12),
      ],
    );
  }

  _leaveRecordeList() {
    return const Expanded(
      child: Column(
        children: [DateNavigatorWidget(), LeaveRecordList()],
      ),
    );
  }

  _buildCalendar() {
    if (Get.find<HrLeaveController>().isHrLeaveCalendarLoading.isTrue) {
      return const Center(
          child: CupertinoActivityIndicator(
        color: AppColor.primaryColor,
        radius: 17,
      ));
    }
    return const Expanded(
      child: Column(
        children: [
          MonthNavigateWidget(),
          Expanded(child: CalendarView()),
        ],
      ),
    );
  }

  // Search bar method renamed and optimized
  Widget _buildSearchBar(BuildContext context, {required Function onSearch}) {
    HrLeaveController controller = Get.put(HrLeaveController());
    LeaveController leaveController = Get.put(LeaveController());
    return GestureDetector(
      onTap: () => onSearch(),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8),
        child: SizedBox(
          height: 52,
          width: MediaQuery.of(context).size.width,
          child: Card(
            elevation: 0,
            color: AppColor.cardColor,
            shape: roundedRectangleBorder.copyWith(
              side: BorderSide(
                color: AppColor.hintColor.withOpacity(0.3),
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(Dimensions.fontSizeMid + 2),
            ),
            child: Row(
              children: [
                customSpacerWidth(width: 12),
                const Icon(CupertinoIcons.search,
                    color: AppColor.hintColor, size: 25),
                customSpacerWidth(width: 8),
                if (controller.selectedEmployeeImgKey.isNotEmpty) ...[
                  CustomNetworkImage(
                    imgUrlKey: controller.selectedEmployeeImgKey.value,
                    errorText: "Er",
                    height: 12,
                    borderColor: Colors.transparent,
                    errorTextStyle: AppStyle.normal_text_black
                        .copyWith(fontSize: 14, color: AppColor.secondaryColor),
                  ),
                  customSpacerWidth(width: 6),
                ],
                Expanded(
                  child: Text(
                    controller.selectedEmployeeInfo.value,
                    maxLines: 1,
                    style: AppStyle.normal_text_black.copyWith(
                        fontSize: Dimensions.fontSizeMid - 3,
                        color: controller.selectedEmployeeInfo.value ==
                                AppString.textSearchEmployee
                            ? AppColor.hintColor
                            : AppColor.normalTextColor,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
                if (controller.selectedEmployeeInfo.value !=
                    AppString.textSearchEmployee)
                  InkWell(
                    onTap: () {
                      controller.selectedEmployeeInfo.value =
                          AppString.textSearchEmployee.tr;
                      controller.selectedEmployeeImgKey.value = "";
                      if (leaveController.tabLength.value == 0) {
                        controller.getHrLeaveCalender();
                      } else {
                        controller.getLeaveRecord();
                      }
                    },
                    child: const Icon(CupertinoIcons.clear,
                        color: AppColor.hintColor, size: 23),
                  ),
                customSpacerWidth(width: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _assignLeave(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Get.find<LeaveController>().leaveTypeSelectedIndex.value = (-1);
        final hrLeaveController = Get.find<HrLeaveController>();
        final userProfileController = Get.find<UserProfileController>();

        final userDetails = userProfileController
            .userDetails?.getOrganizationUserDetails?.profile;
        leaveNoteController.clear();

        // Fetch available leave types
        hrLeaveController.getAvailableLeaveType();

        // Show custom bottom sheet
        _customAntButtonSheet(
          height: MediaQuery.of(context).size.height /
              1.2, // Using a fraction for clarity
          context: context,
          onClose: () {
            _clear();
          },
          child: const AssignLeave(),
        );

        // Set selected employee info
        hrLeaveController.selectedEmployeeInfo.value =
            "${userDetails?.firstName ?? ""} ${userDetails?.lastName ?? ""} (You)";

        // Set selected employee image key
        hrLeaveController.selectedEmployeeImgKey.value =
            userDetails?.image ?? "";
      },
      backgroundColor: AppColor.primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
      child: const Icon(Icons.add, size: 28),
    );
  }

  void _clear() {
    Get.find<LeaveController>().leaveTypeSelectedIndex.value =
        (-1); //clear selection index
    Get.find<HrLeaveController>().selectedEmployeeInfo.value =
        AppString.textSearchEmployee.tr;
    Get.find<HrLeaveController>().storageForUpload.filePath.value = "";
    Get.find<HrLeaveController>().isFileUploadedSuccessfully(false);
  }
}

void _showEmployeeSelectionSheet() {
  HrLeaveController controller = Get.put(HrLeaveController());
  LeaveController leaveController = Get.put(LeaveController());
  customButtonSheet(
    context: Get.context!,
    child: SearchEmployeeList(
      onValueSelected: (value) {
        if (leaveController.tabLength.value == 0) {
          controller.getHrLeaveCalender(assignedId: value);
        } else {
          controller.getLeaveRecord(assignedLeaveId: value);
        }

        Get.back(canPop: false);
      },
      userInfo: (name) {
        controller.selectedEmployeeInfo.value = name.name ?? "";
        controller.selectedEmployeeImgKey.value = name.imgUrl ?? "";
      },
      onClickRouteAction: () {},
    ),
    height: 0.8,
  );
}

_customAntButtonSheet({
  required BuildContext context,
  required Widget child,
  double? height,
  VoidCallback? onClose,
}) {
  final computedHeight = height ?? _modelHeightAccordingScreenSize(context);
  // Display the custom bottom sheet
  showCustomAtmBtnSheet(
    height: computedHeight,
    onClose: onClose,
    context: context,
    child: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Material(
          color: AppColor.noColor,
          child: Container(
            height:
                computedHeight, // Ensure the height matches the bottom sheet's height
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(Dimensions.radiusMid),
                topLeft: Radius.circular(Dimensions.radiusMid),
              ),
              color: AppColor.cardColor,
            ),
            child: child,
          ),
        );
      },
    ),
  );
}

double _modelHeightAccordingScreenSize(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  if (width <= 360.0) {
    return 480.0;
  } else {
    return 500.0;
  }
}
