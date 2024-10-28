import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/app/admin_app/leave_hr/presentation/controller/leave_controller.dart';
import 'package:payrun_mobile/app/admin_app/leave_hr/presentation/view/widget/range_calendar.dart';
import '../../../../../../utils/app_color.dart';
import '../../../../../../utils/app_style.dart';
import '../../../../../../utils/dimensions.dart';

class DateNavigatorWidget extends StatelessWidget {
  const DateNavigatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(LeaveController());

    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 8, right: 8),
      child: GestureDetector(
        onTap: () {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => Dialog(child: leaveRecodeFilterDialog()),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: AppColor.normalTextColor,
                      size: 18,
                    ),
                  ),
                  Obx(
                    () => Text(
                      controller.currentDate.value,
                      style: AppStyle.mid_large_text.copyWith(
                        color: AppColor.secondaryColor,
                        fontSize: Dimensions.fontSizeDefault + 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: AppColor.normalTextColor,
                      size: 18,
                    ),
                  ),
                ],
              ),
              Center(
                child: Text(
                  DateFormat('EEEE').format(DateTime.now()),
                  style: AppStyle.mid_large_text.copyWith(
                    color: AppColor.hintColor,
                    fontSize: Dimensions.fontSizeDefault - 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
