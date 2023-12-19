import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/common/widget/custom_alert_dialog.dart';
import 'package:payrun_mobile/common/widget/custom_network_image.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_svg_image.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/profile/controller/user_profile_controller.dart';
import 'package:payrun_mobile/routes/app_pages.dart';
import 'package:payrun_mobile/utils/api_endpoints.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../../common/widget/custom_buttom_sheet.dart';
import '../../../../common/widget/custom_status_button.dart';
import '../../../leave/presentation/widget/leave_record_details_view.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});
   final PageController _pageController = PageController();
   final  currentPage = 0.obs;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          child: Column(
            children: [
                Container(
                  height: MediaQuery.of(context).size.height/1.8,
                  decoration: BoxDecoration(
                      color: AppColor.primaryColor.withOpacity(0.1), borderRadius: BorderRadius.only(bottomLeft: Radius.circular(Dimensions.radiusExtraLarge-14),bottomRight: Radius.circular(Dimensions.radiusExtraLarge-14))),
                  width: double.infinity,
                  child: Padding(
                    padding: marginLayout,
                    child: Column(
                      children: [
                        customSpacerHeight(height: 46),
                        _userInfoAppbarLayout(),

                        customSpacerHeight(height: 28),
                        Expanded(
                          child: PageView(
                            physics:  const BouncingScrollPhysics(),
                            controller: _pageController,

                            onPageChanged: (page){
                              print("${page.toDouble()}");
                              currentPage.value = page;
                            },

                            children: [
                              Center(child: Column(
                                children: [
                                  Text(AppString.text_daily_summary.tr,style: AppStyle.mid_large_text.copyWith(color: AppColor.normalTextColor.withOpacity(0.7),fontSize: Dimensions.fontSizeDefault-1,letterSpacing: 5),),

                                  customSpacerHeight(height: 18),

                                  _progressBarLayout(percent: 90),

                                  _golTimeLayout(goalText:AppString.text_today_goal.tr,loggedText:AppString.text_logged_time.tr,goalValue:"08h 00m",loggedValue:"03h 17m")

                                ],
                              )), Center(child: Column(
                                children: [
                                  Text(AppString.text_monthly_summary.tr,style: AppStyle.mid_large_text.copyWith(color: AppColor.normalTextColor.withOpacity(0.7),fontSize: Dimensions.fontSizeDefault-1,letterSpacing: 5),),
                                  customSpacerHeight(height: 18),

                                  _progressBarLayout(percent: 50),
                                  _golTimeLayout(goalText:AppString.text_monthly_goal.tr,loggedText:AppString.text_logged_time.tr,goalValue:"08h 00m",loggedValue:"03h 17m")



                                ],
                              )),
                            ],
                          ),
                        ),


                        Obx(() => _dotsDecorator(currentIndex:currentPage )),

                        customSpacerHeight(height: 20),


                      ],
                    ),
                  ),
                ),


                _entryAndStartTimeLayout(),
                Text(AppString.text_upcoming_leave.tr,style: AppStyle.mid_large_text.copyWith(color: AppColor.normalTextColor),),
              _upcomingLeaveLayout(),



            ],
          ),
        ),
      ),
    );


  }

  _progressBarLayout({required double percent}) {
    return SizedBox(
      height: AppLayout.getHeight(190),
      width: AppLayout.getWidth(190),
      child: SfRadialGauge(axes: <RadialAxis>[
        RadialAxis(
            minimum: 0,
            maximum: 100,
            showLabels: false,
            showTicks: false,
            axisLineStyle:  const AxisLineStyle(
              thickness: 0.17,

              cornerStyle: CornerStyle.bothCurve,
              color: AppColor.hintColor,
              thicknessUnit: GaugeSizeUnit.factor,
            ),
            pointers: <GaugePointer>[
              RangePointer(
                value:percent,
                cornerStyle: CornerStyle.bothCurve,
                width: 0.17,
                sizeUnit: GaugeSizeUnit.factor,
                color: AppColor.primaryColor,
                animationDuration:600 ,
                enableAnimation: true,
              )
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                  angle: 90,
                  widget: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppString.text_progress.tr,style: AppStyle.normal_text_grey.copyWith(color: AppColor.hintColor,fontSize: Dimensions.fontSizeDefault),),
                      customSpacerHeight(height: 5),
                      Text(
                        '${percent.toStringAsFixed(0)}%',
                        style: AppStyle.normal_text_grey.copyWith(color: AppColor.normalTextColor,fontSize: Dimensions.fontSizeExtraLarge+4,fontWeight: FontWeight.w900),
                      ),
                    ],
                  ))
            ]
        )
      ]),
    );
  }

  _golTimeLayout({required String goalText, required String loggedText, required String goalValue, required String loggedValue}) {
    return Padding(
      padding: marginLayout.copyWith(top: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(goalText,style: AppStyle.mid_large_text.copyWith(color: AppColor.hintColor,fontSize: Dimensions.fontSizeDefault-1),),
              Text(goalValue,style: AppStyle.normal_text_grey.copyWith(fontSize: Dimensions.fontSizeMid),)

            ],
          ), Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(loggedText,style: AppStyle.mid_large_text.copyWith(color: AppColor.hintColor,fontSize: Dimensions.fontSizeDefault-1),),
              Text(loggedValue,style: AppStyle.normal_text_grey.copyWith(fontSize: Dimensions.fontSizeMid,color: AppColor.primaryColor),)
            ],
          ),

        ],
      ),
    );
  }

  _userInfoAppbarLayout() {
    return    Row(
      children: [
        _userImageLayout(),
        customSpacerWidth(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppString.text_welcome.tr,style: AppStyle.mid_large_text.copyWith(color: AppColor.hintColor,fontSize: Dimensions.fontSizeDefault),),
            Text("Aleksander",style: AppStyle.normal_text_grey.copyWith(color: AppColor.normalTextColor,fontSize: Dimensions.fontSizeMid),),

          ],
        )
      ],
    );
  }

   _userImageLayout() {
     return CustomNetworkImage(height:22,imgUrl:"${Api.PUBLIC_IMAGE_URL_DOMAIN}/files/${GetStorage().read(AppString.ORGANIZATION_ID)}/${Get.find<UserProfileController>().userDetails?.getOrganizationUserDetails?.profile?.image}",
     borderColor: Colors.transparent,
     );
   }

  _entryAndStartTimeLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: ()=>Get.toNamed(Routes.NEW_ENTRY_SCREEN),
          child: SizedBox(
              height: AppLayout.getHeight(170),
              width: AppLayout.getWidth(170),
              child: customSvgImage(imageUrl: Images.add_time_entry)),
        ),
        customSpacerWidth(width: 22),
        InkWell(
          onTap: ()=>Get.toNamed(Routes.TIMER_SCREEN),
          child: SizedBox(
              height: AppLayout.getHeight(170),
              width: AppLayout.getWidth(170),
              child: customSvgImage(imageUrl: Images.start_time)),
        ),

      ],
    );
  }

  _upcomingLeaveLayout() {
    return Padding(
      padding:marginLayout,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 12,
        itemBuilder: (context, index) {
          return SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: GestureDetector(
                onTap: () => customButtonSheet(
                    context: context,
                    child: const LeaveRecordDetails(
                      status:  "token",
                    ),
                    height: 0.5),
                child: Card(
                  elevation: 0,
                  color: AppColor.primaryColor.withOpacity(0.06),
                  shape: roundedRectangleBorder,
                  child: Padding(
                    padding: marginLayout.copyWith(left: 12,right: 12,top: 12,bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Sick leave",style: AppStyle.normal_text_grey.copyWith(color: AppColor.normalTextColor.withOpacity(0.8),fontSize: Dimensions.fontSizeDefault,),),
                            customSpacerHeight(height: 4),
                            Row(
                              children: [
                                Text("22Apr - 23 Apr",style: AppStyle.mid_large_text.copyWith(color: AppColor.secondaryColor,fontSize: Dimensions.fontSizeDefault),),
                              _divider(),
                                Text("2 days",style: AppStyle.mid_large_text.copyWith(color: AppColor.hintColor,fontSize: Dimensions.fontSizeDefault-2),)
                              ],
                            ),
                          ],
                        ),
                        CustomStatusButton(bgColor: AppColor.primaryColor.withOpacity(0.1),text: "Taken",textColor: AppColor.primaryColor.withOpacity(0.9)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );


        },),
    );
  }

  _divider() {
    return   Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(width: 1,height: 8,color: AppColor.hintColor,),
    );
  }
}
Widget _dotsDecorator({required currentIndex}) {
  return  DotsIndicator(
    dotsCount: 2, // Number of dots should match the number of pages
    position: currentIndex.value,
    decorator: const DotsDecorator(
        color: AppColor.hintColor,
        activeColor: AppColor.primaryColor,
        size: Size.square(10.0),
        activeSize: Size(25.0, 9),
        activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(
                right: Radius.circular(5.0), left: Radius.circular(5.0)))

    ),
  );
}



