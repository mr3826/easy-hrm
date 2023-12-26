import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/common/widget/custom_alert_dialog.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
class SummaryTimeLogCalendar extends StatelessWidget {
  SummaryTimeLogCalendar({super.key});

  final int startingYear = 2022;
  final int currentYear = DateTime.now().year;






  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppLayout.getHeight(45),
      child: Padding(
        padding: marginLayout,
        child: ListView.builder(
          itemCount: currentYear - startingYear + 1,
          scrollDirection: Axis.horizontal,

          itemBuilder: (context, index) {
            final year = startingYear + index;
            return SizedBox(
              width: AppLayout.getWidth(880),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Card(
                      shape: roundedRectangleBorder.copyWith(borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge)),
                        elevation: 0,
                        color: AppColor.hintColor.withOpacity(0.8),
                        child: Padding(
                          padding: marginLayout.copyWith(left: 8,right: 8),
                          child: Text(
                            year.toString(),
                            style: AppStyle.mid_large_text.copyWith(color: AppColor.cardColor,fontSize: Dimensions.fontSizeDefault+2),
                          ),
                        )),
                  ),
                  customSpacerWidth(width: 2),

                  Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,

                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 12,
                        reverse: true,
                        itemBuilder: (context, index) {


                          final month = DateTime.utc(year, index + 1);

                          final monthName = DateFormat('MMMM').format(month);
                          DateTime now = DateTime.now();


                          bool isCurrentMonth = year == now.year && index + 1 == now.month;
                          Color textColor = isCurrentMonth ? AppColor.primaryColor : AppColor.hintColor;
                          return Padding(
                            padding: const EdgeInsets.only(left: 8.0,right: 8),
                            child: InkWell(

                                onTap: (){
                                  print(year);
                                  print(month);
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(monthName, style :AppStyle.normal_text_grey.copyWith(color: textColor,fontSize: isCurrentMonth?Dimensions.fontSizeDefault+2:Dimensions.fontSizeDefault),),
                                    isCurrentMonth?
                                    Text(year.toString(), style :AppStyle.mid_large_text.copyWith(color: AppColor.hintColor,fontSize: isCurrentMonth?Dimensions.fontSizeDefault-2:Dimensions.fontSizeDefault),):Container(),
                                  ],
                                )),
                          );
                        },
                      )),

                ],
              ),
            );
          },
        ),
      ),
    );
  }
}