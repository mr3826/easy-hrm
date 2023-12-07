import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/timelog_summary_working_gol_layout.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';

import '../../../leave/controller/calendar_date_controller.dart';
import '../../../leave/view/widget/single_date_picker_calendar.dart';

class TimeLogView extends StatelessWidget {
  const TimeLogView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [

        customSpacerHeight(height: 5),
        Obx(() =>   _dateCalendarLayout(),),
        customSpacerHeight(height: 8),
        workingScheduleLayout(),


      ],

    );

  }



  _dateCalendarLayout() {
    var controller= Get.find<DateController>();
    var textColor=controller.getFormattedDate()==controller.getFormattedCurrentData()?AppColor.secondaryColor:AppColor.normalTextColor;

    return  GestureDetector(
      onTap: (){
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
                    onTap: (){
                      controller.decrementDate();
                    },
                    child: const Icon(Icons.arrow_back_ios,color: AppColor.normalTextColor,size: 20,)),
                const Spacer(),

                Text(controller.getFormattedDate()==controller.getFormattedCurrentData()?AppString.text_today:controller.getFormattedDate(),style: AppStyle.mid_large_text.copyWith(color:textColor,fontSize: Dimensions.fontSizeMid-1,fontWeight: FontWeight.bold),),
                const Spacer(),
                GestureDetector(
                    onTap: (){
                      controller.incrementMonth();
                    },
                    child: const Icon(Icons.arrow_forward_ios_sharp,color: AppColor.normalTextColor,size: 20,)),
              ],
            ),
            customSpacerHeight(height: 2),

            Center(child: Text(controller.getOnlyDay().toString(),style: AppStyle.mid_large_text.copyWith(color: AppColor.hintColor,fontSize: Dimensions.fontSizeDefault-2),))
            ,  customSpacerHeight(height: 6),


          ],
        ),
      ),
    );
  }



}
