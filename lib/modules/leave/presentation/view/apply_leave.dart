import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/modules/leave/presentation/widget/apply_leave_button_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import '../../../../common/widget/custom_buttom_sheet.dart';



class ApplyLeaveScreen extends StatelessWidget {
  const ApplyLeaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        customButtonSheetAppbar(text: AppString.text_apply_leve.tr,subtext: "Thursday"),
        const ApplyLeaveButtonLayout()


      ],
    );
  }
}
