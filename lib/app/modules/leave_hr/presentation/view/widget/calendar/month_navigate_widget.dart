import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../../utils/app_string.dart';
import '../../../../../../../utils/app_color.dart';
import '../../../../../../../utils/app_style.dart';
import '../../../../../../../utils/dimensions.dart';
import '../../../../../../../utils/utils.dart';
import '../../../controller/hr_leave_controller.dart';
import '../../../controller/leave_controller.dart';

class MonthNavigateWidget extends StatelessWidget {
  const MonthNavigateWidget({super.key});
  @override
  Widget build(BuildContext context) {
   final LeaveController controller = Get.put(LeaveController());
    return Padding(
      padding: const EdgeInsets.only(top: 12, left: 12, right: 10),
      child: GestureDetector(
        onTap: () => _showSelectedMonthDialog(context),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildArrowButton(Icons.arrow_back_ios, context),
              Obx(
                () => Column(
                  children: [
                    Text(
                      formatDate(
                          date: controller.selectedMonthDate.value.toString(),
                          format: "MMMM"),
                      style: AppStyle.mid_large_text.copyWith(
                        color: AppColor.secondaryColor,
                        fontSize: Dimensions.fontSizeDefault + 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      formatDate(
                          date: controller.selectedYearDate.value.toString(),
                          format: "yyyy"),
                      style: AppStyle.mid_large_text.copyWith(
                        color: AppColor.hintColor,
                        fontSize: Dimensions.fontSizeSmall,
                      ),
                    ),
                  ],
                ),
              ),
              _buildArrowButton(Icons.arrow_forward_ios_sharp, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildArrowButton(IconData icon, BuildContext context) {
    return GestureDetector(
      onTap: () => _showSelectedMonthDialog(context),
      child: Icon(
        icon,
        color: AppColor.normalTextColor,
        size: 18,
      ),
    );
  }

  void _showSelectedMonthDialog(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(child: _selectedMonthDialog()),
    );
  }
}

Widget _selectedMonthDialog() {
  final LeaveController controller = Get.find<LeaveController>();

  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildYearDropdown(controller),
        Divider(color: AppColor.hintColor.withOpacity(0.3)),
        _buildMonthGrid(controller),
        Divider(color: AppColor.hintColor.withOpacity(0.3)),
        const SizedBox(height: 8),
        _buildDialogActions(controller),
      ],
    ),
  );
}

Widget _buildYearDropdown(LeaveController controller) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Obx(() => DropdownButtonHideUnderline(
          child: DropdownButton2(
            value: controller.years[controller.selectedYearIndex.value],
            items: controller.years.map((int year) {
              return DropdownMenuItem<int>(
                value: year,
                child: Text(
                  year.toString(),
                  style: AppStyle.mid_large_text.copyWith(
                    color: Colors.black,
                    fontSize: Dimensions.fontSizeDefault + 2,
                  ),
                ),
              );
            }).toList(),
            onChanged: (int? newYear) {
              if (newYear != null) {
                controller.selectedYearIndex.value = controller.years.indexOf(newYear);
              }
            },
            dropdownStyleData: DropdownStyleData(
              maxHeight: 500,
              width: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0),
                color: Colors.white,
              ),
              offset: const Offset(-20, 0),
              scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(40),
                thickness: WidgetStateProperty.all(6),
                thumbVisibility: WidgetStateProperty.all(true),
              ),
            ),
          ),
        )),
  );
}

Widget _buildMonthGrid(LeaveController controller) {
  return GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 3.2,
    ),
    itemCount: controller.months.length,
    itemBuilder: (context, index) {
      return Obx(() => GestureDetector(
            onTap: () {
              controller.selectedMonthIndex.value = index;
            },
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: controller.selectedMonthIndex.value == index
                      ? AppColor.primaryColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                child: Text(
                  controller.months[index],
                  style: AppStyle.normal_text.copyWith(
                    color: controller.selectedMonthIndex.value == index
                        ? Colors.white
                        : AppColor.normalTextColor,
                  ),
                ),
              ),
            ),
          ));
    },
  );
}

Widget _buildDialogActions(LeaveController controller) {
  return Padding(
    padding: const EdgeInsets.only(top: 0, bottom: 15, right: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: Text(
            AppString.text_cancel.tr,
            style: AppStyle.normal_text_grey.copyWith(
              color: AppColor.primaryColor,
            ),
          ),
        ),
        const SizedBox(width: 30),
        GestureDetector(
          onTap: () {
           Get.find<HrLeaveController>().getHrLeaveCalender(startDate: controller.startDate.toString(),endDate: controller.endDate.toString());
            Get.back(canPop: false);

          },
          child: Text(
            AppString.text_ok.tr,
            style: AppStyle.normal_text_grey.copyWith(
              color: AppColor.primaryColor,
            ),
          ),
        ),
      ],
    ),
  );
}
