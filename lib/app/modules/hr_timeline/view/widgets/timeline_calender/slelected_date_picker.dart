import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../../common/controller/date_time_controller.dart';
import '../../../../../../utils/app_color.dart';
import '../../../../../../utils/app_style.dart';
import '../../../../../../utils/dimensions.dart';
import '../../../../../global/view/widgets/custom_date_picker.dart';


class BuildSelectDateLayout extends StatelessWidget {
  final Function(String)? dateRange;
  const BuildSelectDateLayout ({super.key,this.dateRange});
  @override
  Widget build(BuildContext context) {
    return  Obx(()=>SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: GestureDetector(
          onTap: ()=> _showCustomDateRangeDialog(context),
          child: Padding(
            padding: const EdgeInsets.only(top: 8, left: 25, right: 25),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () async {

                          Get.find<DateTimeController>().requestedDate.value =
                              DateFormat("yyyy-MM-dd").format(DateTime.parse(
                                  Get.find<DateTimeController>()
                                      .requestedDate
                                      .value)
                                  .subtract(const Duration(days: 1)));

                          dateRange?.call("");

                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: AppColor.normalTextColor,
                          size: 17,
                        )),
                    Column(
                      children: [
                        Text(
                          Get.find<DateTimeController>().requestedDate.value ==
                              DateFormat('yyyy-MM-dd').format(DateTime.now())
                              ? "Today"
                              : DateFormat('dd MMM yyyy').format(DateTime.parse(
                              Get.find<DateTimeController>()
                                  .requestedDate
                                  .value)),
                          style: AppStyle.mid_large_text.copyWith(
                              color: AppColor.secondaryColor,
                              fontSize: Dimensions.fontSizeMid - 2,
                              fontWeight: FontWeight.bold),
                        ),
                        Center(
                            child: Text(
                              DateFormat("EEEE")
                                  .format(DateTime.parse(Get.find<DateTimeController>()
                                  .requestedDate
                                  .value))
                                  .toString(),
                              style: AppStyle.mid_large_text.copyWith(
                                  color: AppColor.hintColor,
                                  fontSize: Dimensions.fontSizeDefault - 3),
                            ))
                      ],
                    ),
                    GestureDetector(
                        onTap: () async {
                          Get.find<DateTimeController>().requestedDate.value =
                              DateFormat("yyyy-MM-dd").format(DateTime.parse(
                                  Get.find<DateTimeController>()
                                      .requestedDate
                                      .value)
                                  .add(const Duration(days: 1)));
                          dateRange?.call("");
                        },
                        child: const Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: AppColor.normalTextColor,
                          size: 17,
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
  void _showCustomDateRangeDialog(BuildContext context) async {

    final selectedRange = await showDialog<Map<String, DateTime?>>(
      context: context,
      builder: (BuildContext context) => CustomCalendarPicker(
          isRangeSelectionEnabled: false,
          weekendDays: const [],
          cancelTextStyle: AppStyle.normal_text.copyWith(
              color: AppColor.secondaryColor,
              fontSize: Dimensions.fontSizeDefault + 1),
          baseColor: AppColor.primaryColor,
          holidayDates: const []),
    );
    if (selectedRange != null) {
      DateTime? startDate = selectedRange["start"];
      if(startDate !=null){
        Get.find<DateTimeController>().requestedDate.value = DateFormat("yyyy-MM-dd").format(DateTime.parse(startDate.toString()));
      }
     dateRange?.call("");

    }
  }
}