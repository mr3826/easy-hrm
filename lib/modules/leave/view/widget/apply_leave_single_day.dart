import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/controller/date_time_helper_controller.dart';
import 'package:payrun_mobile/common/controller/timer_picker.dart';
import 'package:payrun_mobile/common/widget/custom_alert_dialog.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_svg_image.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/leave/view/widget/single_date_picker_calendar.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/utils.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/dimensions.dart';
import 'timmer_text_field_dob.dart';

class ApplyLeaveDobSingleDay extends StatelessWidget {
  const ApplyLeaveDobSingleDay({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _dateText(),
        customSpacerHeight(height: 10),
        GestureDetector(
          onTap: () => showDialog(
            context: Get.context!,
            builder: (context) {
              return const Dialog(
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  insetPadding: EdgeInsets.zero,
                  child: SingleDatePicker());
            },
          ),
          child: Column(
            children: [
             Obx(() => _dateLayoutField()),
             customSpacerHeight(height: 20),
             Obx(() =>  _timeLayoutField(context)),
            ],
          ),
        ),
        customSpacerHeight(height: 20),
        _selectedDayScheduleLayout()
      ],
    );
  }

  _dateText() {
    return Text(
      AppString.text_date.tr,
      style: AppStyle.small_text.copyWith(
          color: AppColor.hintColor,
          fontWeight: FontWeight.w600,
          fontSize: Dimensions.fontSizeDefault),
    );
  }

  _dateLayoutField() {
    return  Container(
      width: double.infinity,
      decoration: decorationStyle,
      padding: marginLayout.copyWith(
          top: 14, bottom: 14, left: 14, right: 14),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              Get.find<DateTimeController>().requestedDate.value,
              style: AppStyle.normal_text_grey,
            ),
            const Icon(
              Icons.calendar_today_outlined,
              color: AppColor.hintColor,
            )
          ]),
    );
  }

  _timeLayoutField(context) {
    return Row(
      children: [
        Expanded(child: _applyLeaveStartTime(context: context)),
        customSpacerWidth(width: 12),
        Expanded(child: _applyLeaveStartTime(context: context)),
      ],
    );

  }
  _selectedDayScheduleLayout() {
    var currentIndex=0.obs;

    return SizedBox(
      height: AppLayout.getHeight(50),
      child: ListView.builder(
        itemCount: 3,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              currentIndex.value=index;
            },
            child: Obx(() => Card(
              color: AppColor.primaryColor.withOpacity(0.05),
              shape: roundedRectangleBorder.copyWith(side: BorderSide(color: currentIndex.value==index? AppColor.primaryColor:AppColor.primaryColor.withOpacity(0.05))),
              elevation: 0,
              child: Padding(
                padding: marginLayout.copyWith(top: 8,bottom: 8,left: 5,right: 5),
                child: Row(
                  children: [
                    customSvgImage(imageUrl: selectedDayIconIndex[index]),
                    customSpacerWidth(width: 8),
                    Text(selectedDayIndex[index],style: AppStyle.normal_text_black.copyWith(color:currentIndex.value==index? AppColor.primaryColor: AppColor.hintColor),),
                    customSpacerWidth(width: 8),

                  ],
                ),
              ),
            )),
          );

      },),
    );

  }
}

Decoration get decorationStyle {
  return BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color:AppColor.solidGray,));
}

Widget _applyLeaveStartTime({required BuildContext context}) {
  return timerTextField(
    hintText: Get.find<DateTimeController>().pickedInTime.isEmpty
        ? AppString.text_select_time
        : Get.find<DateTimeController>().pickedInTime.value,
    dobIcon: Icons.access_time_outlined,
    dobIconAction: () {
      Get.find<DateTimeController>().isInTimeClicked.value = true;
      timePicker(context);
    },
  );
}