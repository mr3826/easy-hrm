// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class ApplyLeaveDobMultiDay extends GetView<LeaveController> {
//   const ApplyLeaveDobMultiDay({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() => Row(
//       children: [
//         Flexible(
//           child: _dobField(
//               isStartDate: true,
//               hintText: controller.startDate.value,
//               context: context,
//               fieldTitleText: AppString.text_start_day),
//         ),
//         customSpacerWidth(width: 12),
//         Flexible(
//           child: _dobField(
//               isStartDate: false,
//               hintText: controller.endDate.value,
//               context: context,
//               fieldTitleText: AppString.text_end_day),
//         ),
//       ],
//     ));
//   }
// }
//
// Widget _dobField(
//     {context, fieldTitleText, hintText, required bool isStartDate}) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       textFieldTitleText(titleText: fieldTitleText),
//       customDateOfBirthField(
//           hintText: hintText,
//           dobIcon: Icons.calendar_month,
//           dobIconAction: () => popUpDialog(
//               context: context,
//               child: ApplyLevPopUpCalendar(
//                 isStartDay: isStartDate,
//               ))),
//     ],
//   );
// }
