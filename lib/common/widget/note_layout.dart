import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/app_layout.dart';
import '../../utils/app_string.dart';
import '../../utils/app_style.dart';
import '../../utils/dimensions.dart';
import 'input_note.dart';

Widget noteLayout() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        AppString.text_note,
        style: AppStyle.normal_text_black
            .copyWith(color: Colors.grey, fontWeight: FontWeight.w600),
      ),
      SizedBox(height: AppLayout.getHeight(Dimensions.paddingDefault)),
      // InputNote(
      //   controller:
      //   Get.find<AttendanceLogsController>().textEditingController,
      // ),
    ],
  );
}