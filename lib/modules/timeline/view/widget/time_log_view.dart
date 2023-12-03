import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/leave/presentation/controller/calendar_date_controller.dart';
import 'package:payrun_mobile/modules/leave/presentation/widget/single_date_picker_calendar.dart';
import 'package:payrun_mobile/modules/leave/presentation/widget/status_btn_widget.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';

class TimeLogView extends StatelessWidget {
  const TimeLogView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [

        customSpacerHeight(height: 5),
        Obx(() =>   _dateCalendarLayout(),),
        customSpacerHeight(height: 8),


      ],

    );

  }



  _dateCalendarLayout() {
    var controller= Get.find<DateController>();
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: (){
                      controller.decrementDate();

                    },

                    child: const Icon(Icons.arrow_back_ios,color: AppColor.normalTextColor,size: 20,)),
                Text(controller.getFormattedDate()==controller.getFormattedCurrentData()?AppString.text_today:controller.getFormattedDate(),style: AppStyle.mid_large_text.copyWith(color: AppColor.normalTextColor,fontWeight: FontWeight.bold),),
                GestureDetector(
                    onTap: (){
                      controller.incrementMonth();

                    },

                    child: const Icon(Icons.arrow_forward_ios_sharp,color: AppColor.normalTextColor,size: 20,)),
              ],
            ),

            Center(child: Text(controller.getOnlyDay().toString(),style: AppStyle.mid_large_text.copyWith(color: AppColor.hintColor,fontSize: Dimensions.fontSizeDefault-1),))



          ],
        ),
      ),
    );
  }



}
