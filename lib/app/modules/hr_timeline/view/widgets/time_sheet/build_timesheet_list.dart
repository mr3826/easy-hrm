import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/modules/settings/controller/app_setting_controller.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/controllers/time_sheet_controller.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/models/time_sheet_model.dart';
import '../../../../../../common/widget/hr_timeline/custom_network_image.dart';
import '../../../../../../enum.dart';
import '../../../../../../utils/app_color.dart';
import '../../../../../../utils/app_style.dart';
import '../../../../../../utils/dimensions.dart';
import '../../../../../../utils/utils.dart';

class BuildTimesheetList extends GetView<TimeSheetController> {
  const BuildTimesheetList({super.key});

  @override
  Widget build(BuildContext context) {


    return Obx((){

      if(controller.isTimeSheetLoading.isTrue){
        return const CupertinoActivityIndicator(color: AppColor.primaryColor,radius: 18,);
      }else if(controller.timeSheetModel?.getUsersTimeSheet?.data?.isEmpty??false){
        return Center(child: Text("Timesheet not found!",style: AppStyle.normal_text_grey,));
      }
      else{
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.timeSheetModel?.getUsersTimeSheet?.data?.length??0,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            Data? data=controller.timeSheetModel?.getUsersTimeSheet?.data?[index];
            return _timeSheetDetailsCard(data??Data());
          },);
      }

    });
  }


  _timeSheetDetailsCard(Data data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: AppColor.leaveRecordCardColor,
            borderRadius: BorderRadius.circular(8),
          ),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _profileInfo(data),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 10.0, // Horizontal space between items
                  runSpacing: 12.0, // Vertical space between rows
                  children: [
                    _buildDetailRow('Date:', _getTime(data)),
                    Row(
                      children: [
                        Flexible(child: _buildDetailRow('Scheduled:', getConvertSecondsToHours (data.totalScheduledSeconds.toString())

                        )),
                        const SizedBox(width: 12),
                        Flexible(child: _buildDetailRow('Logged:',  getConvertSecondsToHours (data.loggedTotalSeconds.toString())
                        )),
                      ],
                    ),
                    _buildBalanceRow(data),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }

  String _getTime(Data data) {
    final timeZone = Get.find<AppSettingController>().orgSetting?.getOrganizationSetting?.timeZone ?? "";

    // Format start and end times
    final startTime = formatDateTimeWithZone(
      dateTimeInput: data.timelineStartDate.toString(),
      timeZone: timeZone,
      include: DateTimePart.time,
    );

    final endTime = data.timelineEndDate==null?"Ongoing":
    formatDateTimeWithZone(
      dateTimeInput: data.timelineEndDate.toString(),
      timeZone: timeZone,
      include: DateTimePart.time,
    );

    // Format start and end dates
    final startDate = formatDate(
      date: formatDateTimeWithZone(
        dateTimeInput: data.timelineStartDate.toString(),
        timeZone: timeZone,
        include: DateTimePart.date,
      ),
      format: "dd MMM",
    );
    final endDate = formatDate(
      date: formatDateTimeWithZone(
        dateTimeInput: data.timelineEndDate.toString(),
        timeZone: timeZone,
        include: DateTimePart.date,
      ),
      format: "dd MMM",
    );

    // Determine if start and end dates are the same
    return startDate == endDate
        ? 'Today ($startTime - $endTime)'
        : '$startDate - $endDate ($startTime - $endTime)';
  }


}

  // Helper method for individual rows
  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: AppStyle.normal_text.copyWith(
            color: AppColor.normalTextColor.withOpacity(0.5),
            fontSize: Dimensions.fontSizeSmall,
          ),
        ),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            value,
            overflow: TextOverflow.ellipsis, // Prevent overflow if the text is too long
            style: AppStyle.normal_text.copyWith(
              color: AppColor.normalTextColor.withOpacity(0.8),
              fontSize: Dimensions.fontSizeSmall,
            ),
          ),
        ),
      ],
    );
  }

  // Helper method for the balance row with styled containers
  Widget _buildBalanceRow(Data data) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Balance:',
          style: AppStyle.normal_text.copyWith(
            color: AppColor.normalTextColor.withOpacity(0.5),
            fontSize: Dimensions.fontSizeSmall,
          ),
        ),
        const SizedBox(width: 4),
        Text(getConvertSecondsToHours (data.loggedTotalSeconds.toString()), style: AppStyle.normal_text.copyWith(color: AppColor.normalTextColor.withOpacity(0.8))),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.only(left: 12.0, right: 12,top: 0,bottom: 0),
          decoration: BoxDecoration(
            color: AppColor.pendingColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),

          ),
          child: Text(
                getConvertSecondsToHours (data.totalLeavesSeconds.toString()),
            style: AppStyle.normal_text.copyWith(color: AppColor.pendingColor,fontSize: Dimensions.fontSizeSmall+1),
          ),
        ),
      ],
    );
  }

  // Profile information layout
  Widget _profileInfo(Data data) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         CircularNetworkImage(
          imageUrl: buildImgIxUrl(imagePath: data.organizationUser?.profile?.image??"",isPublic: true),
          radius: 18,
          errorText: getInitials( "${data.organizationUser?.profile?.firstName??""} ${data.organizationUser?.profile?.lastName??""}",),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${data.organizationUser?.profile?.firstName??""} ${data.organizationUser?.profile?.lastName??""}",
                style: AppStyle.normal_text.copyWith(
                    color: AppColor.secondaryColor, fontSize: Dimensions.fontSizeDefault + 1),
              ),
              Text(
                data.organizationUser?.department?.name??"",
                style: AppStyle.normal_text.copyWith(
                    color: AppColor.hintColor, fontSize: Dimensions.fontSizeSmall),
              ),
            ],
          ),
        ),
      ],
    );
  }
