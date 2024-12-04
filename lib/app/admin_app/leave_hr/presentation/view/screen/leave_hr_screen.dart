import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/admin_app/leave_hr/presentation/view/widget/assign_leave/assign_leave.dart';
import 'package:payrun_mobile/app/admin_app/leave_hr/presentation/view/widget/employee_search.dart';
import 'package:payrun_mobile/common/widget/custom_card_style.dart';
import 'package:payrun_mobile/common/widget/custom_network_image.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import '../../../../../../common/widget/custom_appbar.dart';
import '../../../../../../common/widget/custom_buttom_sheet.dart';
import '../../../../../../common/widget/custom_svg_image.dart';
import '../../../../../../modules/auth/presentation/view/otp_screen.dart';
import '../../../../../../modules/timeline/view/widget/timeline_calendar.dart';
import '../../../../../../utils/app_string.dart';
import '../../../../../../utils/app_style.dart';
import '../../../../../../utils/dimensions.dart';
import '../../../../../../utils/images.dart';
import '../../controller/hr_leave_controller.dart';
import '../../controller/leave_controller.dart';
import '../widget/calendar/vertical_calendar/calendar_view.dart';
import '../widget/calendar/month_navigate_widget.dart';
import '../widget/leave_recorde/date_navigate_widget.dart';
import '../widget/leave_recorde/leave_record_list.dart';

class LeaveHrScreen extends StatelessWidget {
  const LeaveHrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          customAntButtonSheet(
            height: MediaQuery.of(context).size.height/1.2,

              context: context, child:  AssignLeave());
        },
        backgroundColor: AppColor.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
        child: const Icon(
          Icons.add,
          size: 28,
        ),
      ),
      body: Padding(
        padding: marginLayout.copyWith(left: 4, right: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Tab-bar layout
            _buildTabBar(context),
            customSpacerHeight(height: 12),

            ///build search employee list
            Obx(() => Get.find<LeaveController>().isFilterIndividual.isFalse
                ? _buildSearchBar(context, onSearch: () {
                    showEmployeeSelectionSheet();
                  })
                : _buildIndividualPerson()),

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
  PreferredSizeWidget _buildAppBar() {
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

  // Tab bar method renamed and optimized
  Widget _buildTabBar(BuildContext context) {
    final controller = Get.put(LeaveController());

    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: controller.tabList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Obx(() => GestureDetector(
                onTap: () {
                  controller.tabLength.value = index;
                  controller.currentDate.value="This month";
                  Get.find<HrLeaveController>().getLeaveRecord();
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2.1,
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    color: controller.tabLength.value == index
                        ? AppColor.primaryColor
                        : AppColor.hintColor.withOpacity(0.1),
                    child: Center(
                      child: Text(
                        controller.tabList[index],
                        style: AppStyle.normal_text.copyWith(
                          fontSize: Dimensions.fontSizeDefault,
                          color: controller.tabLength.value == index
                              ? AppColor.cardColor
                              : AppColor.normalTextColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }

  _leaveRecordeList() {
    return  const Expanded(
      child: Column(
        children: [DateNavigatorWidget(), LeaveRecordList()],
      ),
    );
  }

  _buildCalendar() {
   if( Get.find<HrLeaveController>().isHrLeaveCalendarLoading.isTrue){
     return  const Center(child: CupertinoActivityIndicator(color:AppColor.primaryColor,radius: 17,));
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
    return GestureDetector(
      onTap: () => onSearch(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 48,
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(CupertinoIcons.search,
                    color: AppColor.hintColor, size: 20),
                customSpacerWidth(width: 6),
                Text(
                  AppString.textSearchEmployee.tr,
                  style: AppStyle.normal_text_black.copyWith(
                    fontSize: Dimensions.fontSizeMid - 3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildIndividualPerson() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomNetworkImage(
            imgUrlKey: "",
            errorText: "Er",
            height: 20,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Jonus Kahnwald",
                  maxLines: 2,
                  style: AppStyle.mid_large_text.copyWith(
                    color: AppColor.secondaryColor,
                    overflow: TextOverflow.ellipsis,
                    fontSize: Dimensions.fontSizeMid - 2,
                  ),
                ),
                Text(
                  "Jonus Kahnwald",
                  maxLines: 2,
                  style: AppStyle.mid_large_text.copyWith(
                    color: AppColor.hintColor,
                    overflow: TextOverflow.ellipsis,
                    fontSize: Dimensions.fontSizeDefault - 1,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Get.find<LeaveController>().isFilterIndividual(false);
            },
            child: const Icon(
              Icons.close,
              color: AppColor.hintColor,
            ),
          ),
        ],
      ),
    );
  }
}

void showEmployeeSelectionSheet() {
  customButtonSheet(
    context: Get.context!,
    child: SearchEmployeeList(
      onValueSelected: (value) {
        print("value :: $value");
      },
    ),
    height: 0.8,
  );
}
