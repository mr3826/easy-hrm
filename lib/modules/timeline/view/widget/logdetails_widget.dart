// import 'dart:developer';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:intl/intl.dart';
// import 'package:payrun_mobile/common/controller/date_time_controller.dart';
// import 'package:payrun_mobile/common/widget/custom_alert_dialog.dart';
// import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
// import 'package:payrun_mobile/common/widget/custom_double_app_button.dart';
// import 'package:payrun_mobile/common/widget/input_note.dart';
// import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
// import 'package:payrun_mobile/modules/leave/view/widget/single_date_picker_calendar.dart';
// import 'package:payrun_mobile/modules/leave/view/widget/timmer_text_field_dob.dart';
// import 'package:payrun_mobile/modules/starting/view/splash_screen.dart';
// import 'package:payrun_mobile/modules/timeline/controller/timeline_controller.dart';
// import 'package:payrun_mobile/modules/timeline/view/widget/task_view_layout.dart';
// import 'package:payrun_mobile/utils/app_color.dart';
// import 'package:payrun_mobile/utils/app_layout.dart';
// import 'package:payrun_mobile/utils/app_string.dart';
// import 'package:payrun_mobile/utils/app_style.dart';
// import 'package:payrun_mobile/utils/dimensions.dart';
// import 'package:payrun_mobile/utils/utils.dart';
// import '../../../../common/controller/timer_picker.dart';
// import '../../../../common/widget/custom_spacer.dart';
// import '../../../../common/widget/warning_message.dart';
// import '../../../leave/view/widget/custom_title_text_widget.dart';
//
// class TimeLogTextField extends StatelessWidget {
//   final String startTime;
//   final String startDateTime;
//   final String endDateTime;
//   final String endTime;
//   final String date;
//   final String scheduleStatus;
//   final String timeLineId;
//   final String status;
//   final String projectName;
//   final String drc;
//   final Color? dotColor;
//
//   const TimeLogTextField(
//       {super.key,
//       required this.startTime,
//       required this.endTime,
//       required this.startDateTime,
//       required this.endDateTime,
//       required this.date,
//       required this.timeLineId,
//       required this.status,
//       required this.scheduleStatus,
//       required this.projectName,
//       required this.drc,
//       this.dotColor});
//
//   @override
//   Widget build(BuildContext context) {
//     String timeLineID = timeLineId.substring(1, timeLineId.length - 1);
//     print("Timeline id :::: ${timeLineId.toString()}");
//     return Padding(
//       padding: marginLayout.copyWith(top: 20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Obx(() => _timerLayout(context: context)),
//           customSpacerHeight(height: 20),
//           customTitleText(text: "${AppString.text_date.tr} *"),
//           customSpacerHeight(height: 8),
//           Obx(() => _dateLayoutField(date: date)),
//           customSpacerHeight(height: 8),
//           _dayScheduleLayout(),
//           customSpacerHeight(height: 20),
//           customTitleText(text: AppString.text_project_or_task.tr),
//           customSpacerHeight(height: 8),
//           taskInputField(onAction: () {
//             customButtonSheet(
//                 context: context, height: .7, child: const TaskViewLayout());
//           }),
//           customSpacerHeight(height: 20),
//           customTitleText(text: AppString.text_description.tr),
//           customSpacerHeight(height: 8),
//           InputNote(
//             controller: timelineLogDetailsDrcController,
//             hintText: AppString.text_add_description.tr,
//             hintColor: AppColor.hintColor,
//           ),
//           customSpacerHeight(height: 20),
//           Obx(() => _updateBtnLayout(
//                 context: context,
//                 timeLineID: timeLineID,
//                 // startDateTime: startTimeD,
//                 // endDateTime: endTimeD,
//               )),
//           customSpacerHeight(height: 40)
//         ],
//       ),
//     );
//   }
//
//   _updateBtnLayout({timeLineID, context}) {
//     return CustomDoubleAppButton(
//         saveBtn: Get.find<TimelineController>().isUpdateTimeLogLoading.isFalse
//             ? Text(
//                 AppString.text_save.tr,
//                 style: AppStyle.mid_large_text.copyWith(
//                     color: AppColor.cardColor,
//                     fontSize: Dimensions.fontSizeDefault + 1),
//               )
//             : const CupertinoActivityIndicator(
//                 color: AppColor.cardColor,
//               ),
//         onAction: () {
//           Get.find<TimelineController>().updateTimelineLogDetails(
//             description: timelineLogDetailsDrcController.text,
//             status: status,
//             projectId: "",
//             startDate: Get.find<DateTimeController>()
//                         .requestedInDate
//                         .value
//                         .length >
//                     10
//                 ? Get.find<DateTimeController>().requestedInDate.value
//                 : DateFormat("yyyy-MM-dd hh:mma")
//                     .parse(
//                         "${Get.find<DateTimeController>().requestedInDate.value} ${Get.find<DateTimeController>().pickedInTime.value}")
//                     .toString(),
//             endDate: Get.find<DateTimeController>()
//                         .requestedOutDate
//                         .value
//                         .length >
//                     10
//                 ? Get.find<DateTimeController>().requestedOutDate.value
//                 : DateFormat("yyyy-MM-dd hh:mma")
//                     .parse(
//                         "${Get.find<DateTimeController>().requestedOutDate.value} ${Get.find<DateTimeController>().pickedOutTime.value}")
//                     .toString(),
//             taskId: "",
//             timeLineId: timeLineID,
//           );
//           Get.find<DateTimeController>().timeLogDate.value.isEmpty
//               ? showWarningMessage(message: "Please selected date")
//               : Container();
//         },
//         cancelAction: () {
//           Navigator.pop(context);
//         });
//   }
//
//   _dayScheduleLayout() {
//     return SizedBox(
//       height: AppLayout.getHeight(50),
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         itemCount: 3,
//         itemBuilder: (context, index) {
//           return GestureDetector(
//             onTap: () {
//               Get.find<DateTimeController>().currentIndex.value = index;
//               switch (index) {
//                 case 0:
//                   Get.find<DateTimeController>().requestedDate.value =
//                       DateFormat('yyyy-MM-dd').format(
//                           DateTime.now().subtract(const Duration(days: 1)));
//                   break;
//                 case 1:
//                   Get.find<DateTimeController>().requestedDate.value =
//                       DateFormat('yyyy-MM-dd').format(DateTime.now());
//                   break;
//                 case 2:
//                   Get.find<DateTimeController>().requestedDate.value =
//                       DateFormat('yyyy-MM-dd')
//                           .format(DateTime.now().add(const Duration(days: 1)));
//                   break;
//               }
//               print(Get.find<DateTimeController>().currentIndex.value);
//             },
//             child: Obx(() => SizedBox(
//                   width: AppLayout.getWidth(127),
//                   child: Padding(
//                     padding: const EdgeInsets.only(right: 8.0),
//                     child: Card(
//                       color:
//                           Get.find<DateTimeController>().currentIndex.value ==
//                                   index
//                               ? AppColor.primaryColor.withOpacity(0.05)
//                               : Colors.transparent,
//                       shape: roundedRectangleBorder.copyWith(
//                           side: BorderSide(
//                               width: 1,
//                               color: Get.find<DateTimeController>()
//                                           .currentIndex
//                                           .value ==
//                                       index
//                                   ? AppColor.primaryColor
//                                   : AppColor.hintColor)),
//                       elevation: 0,
//                       child: Center(
//                           child: Text(
//                         selectedBeforeDayAndAfterDay[index],
//                         style: AppStyle.mid_large_text.copyWith(
//                             color: Get.find<DateTimeController>()
//                                         .currentIndex
//                                         .value ==
//                                     index
//                                 ? AppColor.primaryColor
//                                 : AppColor.hintColor,
//                             fontSize: Dimensions.fontSizeDefault),
//                       )),
//                     ),
//                   ),
//                 )),
//           );
//         },
//       ),
//     );
//   }
// }
//
// _timerLayout({required context}) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       customTitleText(text: AppString.text_set_start_time.tr),
//       customSpacerHeight(height: 8),
//       _newEntryStartTime(
//         context: context,
//       ),
//       customSpacerHeight(height: 20),
//       customTitleText(text: AppString.text_set_end_time.tr),
//       customSpacerHeight(height: 8),
//       _newEntryEndTime(
//         context: context,
//       ),
//     ],
//   );
// }
//
// Widget _newEntryStartTime({
//   required BuildContext context,
// }) {
//   return timerTextField(
//     hintText: Get.find<DateTimeController>().pickedInTime.value.isEmpty
//         ? "select time"
//         : Get.find<DateTimeController>().pickedInTime.value,
//     dobIcon: Icons.access_time_outlined,
//     hintColor: AppColor.normalTextColor,
//     dobIconAction: () {
//       Get.find<DateTimeController>().isInTimeClicked.value = true;
//       timePicker(context, false);
//     },
//   );
// }
//
// Widget _newEntryEndTime({
//   required BuildContext context,
// }) {
//   return timerTextField(
//     hintText: Get.find<DateTimeController>().pickedOutTime.value.isEmpty
//         ? "select time"
//         : Get.find<DateTimeController>().pickedOutTime.value,
//     dobIcon: Icons.access_time_outlined,
//     hintColor: AppColor.normalTextColor,
//     dobIconAction: () {
//       timePicker(context, false);
//     },
//   );
// }
//
// _dateLayoutField({required String date}) {
//   return GestureDetector(
//     onTap: () => showDialog(
//       context: Get.context!,
//       builder: (context) {
//         return const Dialog(
//             backgroundColor: Colors.transparent,
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(16))),
//             insetPadding: EdgeInsets.zero,
//             child: SingleDatePicker(
//               isCalledFormTimeLog: true,
//             ));
//       },
//     ),
//     //     DateTime parsedDate = DateFormat('EEE, dd MMMM - yyyy').parse(dtsDate);
//     // Get.find<DateTimeController>().requestedDate.value = DateFormat('yyyy-MM-dd').format(parsedDate);
//     child: Column(
//       children: [
//         Container(
//           width: double.infinity,
//           decoration: decorationStyle.copyWith(
//               border: Border.all(width: .8, color: AppColor.hintColor),
//               borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
//           padding:
//               marginLayout.copyWith(top: 14, bottom: 14, left: 14, right: 14),
//           child:
//               Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//             Text(
//               Get.find<DateTimeController>().requestedDate.value,
//               style: AppStyle.normal_text_black
//                   .copyWith(color: AppColor.normalTextColor),
//             ),
//             const Icon(
//               Icons.calendar_today_outlined,
//               color: AppColor.hintColor,
//             )
//           ]),
//         )
//       ],
//     ),
//   );
// }
//
// AppBar timeLogAppbar(context) {
//   return AppBar(
//     elevation: 0,
//     backgroundColor: AppColor.backgroundColor,
//     leading: IconButton(
//       onPressed: () {
//         Navigator.pop(context);
//       },
//       icon: Icon(
//         Icons.arrow_back_ios,
//         color: AppColor.hintColor,
//         size: Dimensions.fontSizeMid + 4,
//       ),
//     ),
//     centerTitle: true,
//     title: Text(
//       AppString.text_time_log_details.tr,
//       style:
//           AppStyle.normal_text_black.copyWith(fontSize: Dimensions.fontSizeMid),
//     ),
//   );
// }
//
// Widget taskInputField({required onAction}) {
//   return InkWell(
//     onTap: () => onAction(),
//     child: Card(
//       elevation: 0,
//       color: Colors.transparent,
//       shape: roundedRectangleBorder.copyWith(
//           side: const BorderSide(width: .8, color: AppColor.hintColor)),
//       child: Padding(
//         padding: marginLayout.copyWith(left: 12, right: 8, top: 12, bottom: 12),
//         child: Obx(() => Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Get.find<TimelineController>().taskName.value.isNotEmpty
//                     ? Text(
//                         Get.find<TimelineController>().taskName.value,
//                         style: AppStyle.mid_large_text.copyWith(
//                             fontSize: Dimensions.fontSizeDefault + 1,
//                             color: AppColor.normalTextColor),
//                       )
//                     : Text(
//                         AppString.text_select_option.tr,
//                         style: AppStyle.mid_large_text.copyWith(
//                             fontSize: Dimensions.fontSizeDefault + 1,
//                             color: AppColor.hintColor),
//                       ),
//                 const Icon(
//                   CupertinoIcons.search,
//                   size: 30,
//                   color: AppColor.hintColor,
//                 )
//               ],
//             )),
//       ),
//     ),
//   );
// }
//
// formatDateTime() {
//   DateFormat inputFormat = DateFormat('E, d MMMM - y');
//   DateTime inputDate =
//       inputFormat.parse(Get.find<DateTimeController>().timeLogDate.value);
//
//   return DateFormat('y-MM-dd').format(inputDate);
// }
