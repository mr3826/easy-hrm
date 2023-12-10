import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/timelog_summary_working_gol_layout.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../leave/controller/calendar_date_controller.dart';
import '../../../leave/view/widget/single_date_picker_calendar.dart';


class TimeLogView extends StatelessWidget {
  const TimeLogView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        customSpacerHeight(height: 5),
        Obx(() =>   _dateCalendarLayout(),),
        customSpacerHeight(height: 8),
        workingScheduleLayout(),








        // Container(
        //   height: MediaQuery.of(context).size.height,
        //
        //   child: SfCalendar(
        //     view: CalendarView.day,
        //     // appointmentTimeTextFormat: 'H:mm',
        //
        //     onTap: (details) {
        //
        //       if (details.appointments == null) {
        //         return;
        //       }
        //       final event = details.appointments!.first;
        //       print("object");
        //     },
        //     //  headerHeight: 0,
        //     dataSource: MeetingDataSource(getAppointment()),
        //     allowDragAndDrop: true,
        //     showCurrentTimeIndicator: false,
        //     appointmentTextStyle: const TextStyle(color: Colors.black),
        //     showNavigationArrow: true,
        //     selectionDecoration: BoxDecoration(
        //       color: Colors.transparent,
        //       border:
        //       Border.all(color: Colors.white60,
        //         width: 1,),
        //       borderRadius: const BorderRadius.all(Radius.circular(4)),
        //       shape: BoxShape.rectangle,
        //     ),
        //     headerStyle: const CalendarHeaderStyle(
        //       textAlign: TextAlign.center,
        //     ),
        //     cellEndPadding: 100,
        //
        //
        //     viewHeaderStyle: const ViewHeaderStyle(dateTextStyle: TextStyle(color: Colors.blue)),
        //
        //
        //     //cellEndPadding: 200,
        //   ),
        // ),
      ],
    );
  }

  _dateCalendarLayout() {
    var controller = Get.find<DateController>();
    var textColor =
        controller.getFormattedDate() == controller.getFormattedCurrentData()
            ? AppColor.secondaryColor
            : AppColor.normalTextColor;

    return GestureDetector(
      onTap: () {
        showDialog(
          context: Get.context!,
          builder: (context) {
            return const Dialog(
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                insetPadding: EdgeInsets.zero,
                child: SingleDatePicker());
          },
        );
      },
      child: Padding(
        padding: marginLayout,
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                    onTap: () {
                      controller.decrementDate();
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: AppColor.normalTextColor,
                      size: 20,
                    )),
                const Spacer(),
                Text(
                  controller.getFormattedDate() ==
                          controller.getFormattedCurrentData()
                      ? AppString.text_today
                      : controller.getFormattedDate(),
                  style: AppStyle.mid_large_text.copyWith(
                      color: textColor,
                      fontSize: Dimensions.fontSizeMid - 1,
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                GestureDetector(
                    onTap: () {
                      controller.incrementMonth();
                    },
                    child: const Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: AppColor.normalTextColor,
                      size: 20,
                    )),
              ],
            ),
            customSpacerHeight(height: 2),
            Center(
                child: Text(
              controller.getOnlyDay().toString(),
              style: AppStyle.mid_large_text.copyWith(
                  color: AppColor.hintColor,
                  fontSize: Dimensions.fontSizeDefault - 2),
            )),
            customSpacerHeight(height: 6),
          ],
        ),
      ),
    );
  }
}

List<Appointment> getAppointment() {
  final DateTime today = DateTime.now();
  final DateTime startTime =
      DateTime(today.year, today.month, today.day, 6, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 4));

  final DateTime startTime1 =
      DateTime(today.year, today.month, today.day, 10, 0, 0);
  final DateTime endTime1 = startTime.add(const Duration(hours: 4));

  List<Appointment> metting = <Appointment>[
    Appointment(
      startTime: startTime,
      endTime: endTime,
      subject: "Conference",
      color: Colors.blue.withOpacity(0.2),
    ),
    Appointment(
      startTime: startTime1,
      endTime: endTime1,
      subject: "Conference1",
      color: Colors.blue.withOpacity(0.2),
    ),
    Appointment(
      startTime: DateTime.now(),
      endTime: DateTime.now().add(const Duration(hours: 2)),
      subject: "Conference",
      color: Colors.blue.withOpacity(0.2),
    ),
  ];

  // metting.add(
  //   Appointment(
  //     startTime: startTime,
  //     endTime: endTime,
  //     subject: "Conference",
  //     color: Colors.blue.withOpacity(0.2),
  //
  //   ),
  // );

  return metting;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
