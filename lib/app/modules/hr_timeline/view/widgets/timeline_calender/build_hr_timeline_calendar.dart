import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../../common/controller/date_time_controller.dart';
import '../../../../../../modules/leave/presentation/view/widget/single_date_picker_calendar.dart';
import '../../../../../../modules/timeline/view/widget/timeline_calendar.dart';
import '../../../../../../modules/timeline/view/widget/timelog_summary_working_gol_layout.dart';
import '../../../../../../utils/app_color.dart';
import '../../../../../../utils/app_style.dart';
import '../../../../../../utils/dimensions.dart';



class ISEmployeeTimelineCalendar extends StatelessWidget {
  const ISEmployeeTimelineCalendar({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const TimeLineCalendar(),
        Positioned(top: 0,child: _summaryLayout(context)),

      ],
    );
  }
}


class ISAdminTimelineCalendar extends StatelessWidget {
  const ISAdminTimelineCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 70.0),
            child: TimeLineCalendar(),
          ),

          Obx(()=>_dateCalendarLayout(context)),
          Positioned(top: 58,child: _summaryLayout(context))


        ],
      ),
    );
  }
}




Widget _summaryLayout(BuildContext context) {
  return Container(
    color: AppColor.cardColor,
    width: MediaQuery.of(context).size.width,
    child: workingScheduleLayout(
        schedule: "12",
        balanceTime: "!2",
        loggedTime: "3423",
        paidLeave: "5423"),
  );
}



Widget _dateCalendarLayout(BuildContext context) {
  return Positioned(
    top: 0,
    child: SizedBox(
      width: MediaQuery.of(context).size.width,

      child: Card(
        elevation: 0,
        child: GestureDetector(
          onTap: () {

            showDialog(
              context: context,
              builder: (context) {
                return const Dialog(
                    child: SingleDatePicker(
                      isCalledFormTimeLog: true,
                    ));
              },
            );


          },
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
                              fontSize: Dimensions.fontSizeMid - 3,
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
    ),
  );
}
