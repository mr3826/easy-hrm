import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/controllers/hr_timeline_controller.dart';
import 'package:payrun_mobile/common/widget/employee/status_button_helper.dart';
import 'package:payrun_mobile/enum.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import '../../../../../../../../common/widget/custom_app_button.dart';
import '../../../../../../../../common/widget/custom_buttom_sheet.dart';
import '../../../../../../../../common/widget/custom_dialog.dart';
import '../../../../../../../../common/widget/custom_network_image.dart';
import '../../../../../../../../common/widget/custom_spacer.dart';
import '../../../../../../../../common/widget/custom_svg_image.dart';
import '../../../../../../../../common/widget/timePicker/date_time_picker_controller.dart';
import '../../../../../../../../utils/app_color.dart';
import '../../../../../../../../utils/app_style.dart';
import '../../../../../../../../utils/dimensions.dart';
import '../../../../../../../../utils/images.dart';
import '../../../../../../../../utils/utils.dart';
import '../../../../leave_hr/presentation/controller/hr_leave_controller.dart';
import '../../../../leave_hr/presentation/controller/hr_update_leave_controller.dart';
import '../../../../leave_hr/presentation/controller/leave_controller.dart';
import '../../../../leave_hr/presentation/model/leave_details_by_id.dart';
import '../../../../leave_hr/presentation/view/widget/leave_record/leave_record_details/edit_leave_record/edit_leave_record_details.dart';
import '../../../../leave_hr/presentation/view/widget/leave_record/leave_record_details/see_documents/see_document_details.dart';



/// A widget that displays detailed information for a specific leave record,
/// including options to approve, reject, edit, and view attached documents.
/// The actions displayed depend on the leave record's status.



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
          name:"",

          details:""
        ),


        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildText("06:15 pm -07:00pm"),
            _buildText("45m",AppColor.hintColor),
            _buildText("Project name"),
            _buildText("No task",AppColor.hintColor),


          ],
        )

      ],
    ));
  }

_buildText(String text,[Color? color]){
    return Padding(
      padding: const EdgeInsets.only(left: 8.0,right: 8),
      child: Text(text,style: AppStyle.normal_text_black.copyWith(color:color?? AppColor.normalTextColor),),
    )
;
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
