import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/controllers/hr_timeline_controller.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/models/timelog_entries_details.dart';
import 'package:payrun_mobile/common/widget/employee/status_button_helper.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import '../../../../../../../../common/widget/custom_network_image.dart';
import '../../../../../../../../common/widget/custom_spacer.dart';
import '../../../../../../../../utils/app_color.dart';
import '../../../../../../../../utils/app_style.dart';
import '../../../../../../../../utils/dimensions.dart';



class TimeLogSummaryDetails extends GetView<HrTimelineController> {
  final String? leaveId;
  const TimeLogSummaryDetails({super.key, this.leaveId});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isTimeEntryLoading.isTrue
        ? const Center(
        child: CupertinoActivityIndicator(
          radius: 15,
          color: AppColor.primaryColor,
        ))
        : Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Header with employee details
        _buildHeader(
          imageUrl: "",
          name:"Agens Nelson",
          details:"Laravel department"
        ),


        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _buildText("Time entries",AppColor.hintColor,AppStyle.normal_text_black.copyWith(color:AppColor.hintColor,letterSpacing: 4)),
        ),

      Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(left: 12,right: 12,top: 6),
            itemCount: controller.timeLogsEntriesDetails?.getTimeLineEntries?.data?.length??0,
            itemBuilder: (context, index){
              Data? data=controller.timeLogsEntriesDetails?.getTimeLineEntries?.data?[index];
              return Container(
                decoration: BoxDecoration(color: AppColor.leaveRecordCardColor,borderRadius: BorderRadius.circular(8)),
                width:  double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(left:8,right: 8,bottom: 14,top: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(child: _buildText("06:15 pm -07:00pm")),
                          IconButton(onPressed: (){}, icon: const Icon(Icons.more_horiz)),

                        ],
                      ),
                      _buildText("45m",AppColor.hintColor),
                      _buildText(data?.project?.name??""),
                      _buildText(data?.task??"No task added",AppColor.hintColor),
                      const SizedBox(height: 8,),
                      SizedBox(
                          width: AppLayout.getWidth(100),
                          child: _showStatusButton(data?.status??""))


                    ],
                  ),
                ),
              );
            },)
      ),

        const SizedBox(height: 30,)


      ],
    ));
  }

Widget _buildText(String text,[Color? color,TextStyle ?textStyle]){
    return Padding(
      padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 4),
      child: Text(text,style:textStyle ?? AppStyle.normal_text_black.copyWith(color:color?? AppColor.normalTextColor),),
    )
;
}
  Widget _showStatusButton(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return StatusBtnHelper.approvedStatusBtn();
      case 'rejected':
        return StatusBtnHelper.rejectedStatusBtn();
      case 'pending':
        return StatusBtnHelper.pendingStatusBtn();
      case 'taken':
        return StatusBtnHelper.tokenStatusBtn();
      case 'cancelled':
        return StatusBtnHelper.cancelledStatusBtn();
      case 'cancel':
        return StatusBtnHelper.cancelStatusBtn();
      default:
        return Container();
    }
  }

  /// Builds the header containing profile image, name, and leave details.
  Widget _buildHeader({String? imageUrl, String? name, String? details}) {
    final screenHeight = MediaQuery.of(Get.context!).size.height;

    return Container(
      height: screenHeight / 5,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColor.bgColorWithTimeline,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                height: 4, width: 120, color: AppColor.backgroundColor),
          ),
          customSpacerHeight(height: 12),
          CustomNetworkImage(
            profileImageKey: imageUrl,
            imgUrlKey: "",
            errorText: "ER",
          ),
          customSpacerHeight(height: 12),
          Text(
            name ?? "",
            style: AppStyle.mid_large_text.copyWith(
              color: AppColor.secondaryColor,
              fontWeight: FontWeight.w600,
              fontSize: Dimensions.fontSizeDefault + 2,
            ),
          ),
          Text(
            details ?? "",
            style: AppStyle.small_text_black.copyWith(
              color: AppColor.hintColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }}
