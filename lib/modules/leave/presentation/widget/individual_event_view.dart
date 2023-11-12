import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_status_button.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/leave/presentation/widget/calender_widget.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';

class IndividualEventView extends StatelessWidget {
  const IndividualEventView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        const HorizontalCalendar(),
        _eventText(),
        _eventViewLayout(),
        customSpacerHeight(height: 100),
        ],

    );

  }

  _eventText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        customSpacerHeight(height: 50),
        Container(height: 1,width: 140,color: AppColor.disableColor,),

        Padding(
          padding: marginLayout,
          child: Text(AppString.text_event.tr,style: AppStyle.normal_text_black.copyWith(color: AppColor.hintColor),),
        ),
        Container(height: 1,width: 140,color: AppColor.disableColor,),



      ],
    );
  }

  _eventViewLayout() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: marginLayout,
      itemCount: 12,
      itemBuilder: (context, index) {
      return  Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Card(
          elevation: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Sick leave",style: AppStyle.mid_large_text.copyWith(color: AppColor.normalTextColor,fontSize: Dimensions.fontSizeDefault+1,fontWeight: FontWeight.w500),),
                  Text("Full day",style: AppStyle.normal_text_black.copyWith(color: AppColor.hintColor,fontSize: Dimensions.fontSizeDefault-1),)
                ],
              ),
              CustomStatusButton(textColor: AppColor.successColor,bgColor: AppColor.successColor.withOpacity(0.1),text: AppString.text_approved.tr,)
            ],
          ),

        ),
      );

    },);
  }

}
class DottedBorderText extends StatelessWidget {
  final String text;

  DottedBorderText(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black,
            width: 2.0,
            style: BorderStyle.none,
          ),
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: 5.0), // Adjust the spacing as needed
          Text(
            text,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 5.0), // Adjust the spacing as needed
        ],
      ),
    );
  }
}