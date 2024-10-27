import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/admin_app/leave_hr/presentation/view/widget/employee_search.dart';
import 'package:payrun_mobile/common/widget/custom_card_style.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import '../../../../../../common/widget/custom_appbar.dart';
import '../../../../../../common/widget/custom_buttom_sheet.dart';
import '../../../../../../common/widget/custom_svg_image.dart';
import '../../../../../../modules/auth/presentation/view/otp_screen.dart';
import '../../../../../../utils/app_string.dart';
import '../../../../../../utils/app_style.dart';
import '../../../../../../utils/dimensions.dart';
import '../../../../../../utils/images.dart';
import '../../controller/leave_controller.dart';
import '../widget/calandar_widget.dart';
import '../widget/range_calendar.dart';

class LeaveHrScreen extends StatelessWidget {
  const LeaveHrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: marginLayout.copyWith(left: 4, right: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            _buildTabBar(context),
            customSpacerHeight(height: 4), _buildSearchBar(context, onSearch: () {showEmployeeSelectionSheet();
            }),

            DateNavigatorWidget(onDateChanged: (String value) {  },),


           // RangeCalendarExample()



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
                onTap: () => controller.tabLength.value = index,
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
                  AppString.textSearch.tr,
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
