import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../controller/leave_controller.dart';
import '../../../view/widget/leave_record/range_calendar.dart';
import '../../../../../../../utils/app_color.dart';
import '../../../../../../../utils/app_style.dart';
import '../../../../../../../utils/dimensions.dart';

class DateNavigatorWidget extends StatelessWidget {
  const DateNavigatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    LeaveController controller = Get.put(LeaveController());
    return Padding(
      padding: const EdgeInsets.only(top: 12, left: 12, right: 10),
      child: GestureDetector(
        onTap: () {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) =>
                Dialog(child: leaveRecodeFilterDialog()),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) =>
                        Dialog(child: leaveRecodeFilterDialog()),
                  );
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColor.normalTextColor,
                  size: 18,
                ),
              ),
              Obx(
                    () => Column(
                  children: [
                    Text(
                      controller.currentDate.value,
                      style: AppStyle.mid_large_text.copyWith(
                        color: AppColor.secondaryColor,
                        fontSize: Dimensions.fontSizeDefault + 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Center(
                      child: Text(
                        _getDay(controller.currentDate.value),
                        style: AppStyle.mid_large_text.copyWith(
                          color: AppColor.hintColor,
                          fontSize: Dimensions.fontSizeDefault - 2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) =>
                        Dialog(child: leaveRecodeFilterDialog()),
                  );
                },
                child: const Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: AppColor.normalTextColor,
                  size: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getDay(date) {
    try {
      DateTime parsedDate = DateTime.parse(date);
      String formattedDate = DateFormat('EEEE').format(parsedDate);
      return formattedDate;
    } catch (e) {
      print("Invalid date format: ${e.toString()}");
      return date;
    }
  }
}