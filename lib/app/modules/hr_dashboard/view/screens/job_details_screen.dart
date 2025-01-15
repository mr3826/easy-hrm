import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/modules/hr_dashboard/models/job_applocation_board.dart';
import 'package:payrun_mobile/app/modules/hr_dashboard/view/widgets/deshboard_widget.dart';
import 'package:payrun_mobile/app/modules/hr_dashboard/view/widgets/job_details/tabbar/build_tabbar.dart';
import 'package:payrun_mobile/common/widget/custom_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/loading_indicator.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import '../../../../../common/widget/custom_appbar.dart';
import '../../../../../common/widget/custom_buttom_sheet.dart';
import '../../../../../common/widget/custom_dialog.dart';
import '../../../../../common/widget/custom_double_app_button.dart';
import '../../../../../common/widget/custom_svg_image.dart';
import '../../../../../common/widget/hr_deshboard/more_info_text_divider.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../../utils/images.dart';
import '../../../../../utils/utils.dart';
import '../../controllers/hr_deshboard_controller.dart';

class JobDetailsScreen extends GetView<HrDashBoardController> {
  const JobDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {


    return Obx((){
      if(controller.isJobApplicationBoardLoading.isTrue){
        return const Scaffold(body: LoadingIndicator(),);
      }else{

        return Scaffold(
          appBar: customAppbar(title: AppString.text_job_details.tr, actions: [
            IconButton(
              onPressed: () {
                customButtonSheet(height: .5, context: context, child: _buildMoreView());
              },
              icon: const Icon(Icons.more_vert_sharp, color: AppColor.hintColor),
            )
          ]),
          floatingActionButton: _buildPasteButton(),
          body: Column(
            children: [
              customSpacerHeight(height: 18),
              _buildJobTitleWithDescription(),
              customSpacerHeight(height: 12),
              _buildTimeAddressWithDate(),
              customSpacerHeight(height: 4),
              TabBarWidget(),
            ],
          ),
        );


      }


    });

  }

  _buildJobTitleWithDescription() {
    GetJobApplicationBoard? data=controller.jobApplicationBoard?.getJobApplicationBoard;
    return Column(
      children: [
        Center(
          child: Text(
            data?.title??"",
            style: AppStyle.mid_large_text.copyWith(
                color: AppColor.secondaryColor,
                fontWeight: FontWeight.w600,
                fontSize: Dimensions.fontSizeDefault + 3),
          ),
        ),
        Center(
          child: Text(
            data?.department?.name??"No department",
            style: AppStyle.mid_large_text.copyWith(
                color: AppColor.normalTextColor,
                fontWeight: FontWeight.w500,
                fontSize: Dimensions.fontSizeDefault),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeAddressWithDate() {
    GetJobApplicationBoard? data=controller.jobApplicationBoard?.getJobApplicationBoard;

    // Define a list of objects that include the text and corresponding icons
    final List<Map<String, dynamic>> list = [
      {
        'icon': Icons.access_time_rounded,
        'text': capitalizeWords(data?.type??"")
      },
      {
        'icon': Icons.location_on_outlined,
        'text': data?.location??"",
      },
      {
        'icon': Icons.date_range,
        'text': formatDate(
            date: data?.lastDateOfApply ?? "", format: "dd MMM, yyy"),
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: list.map((item) {
          return Padding(
            padding: const EdgeInsets.only(right: 6.0), // Space between items
            child: Row(
              children: [
                Icon(
                  item['icon'], // Use the dynamic icon
                  size: 16,
                  color: AppColor.normalTextColor.withOpacity(0.4),
                ),
                const SizedBox(width: 3), // Spacer between icon and text
                Text(
                  item['text'], // Use the dynamic text
                  style: AppStyle.normal_text_black.copyWith(
                      color: AppColor.normalTextColor.withOpacity(0.5),
                      fontSize: Dimensions.fontSizeSmall,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  _buildPasteButton() {
    return Obx(() {


      return AnimatedOpacity(
        opacity: Get.find<HrDashBoardController>().isPasteButtonActive.value
            ? 1.0
            : 0.0, // Fully visible when selected, hidden otherwise
        duration:
            const Duration(milliseconds: 400), // Duration of the fade in/out
        child: Get.find<HrDashBoardController>().isPasteButtonActive.value
            ? Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child:
                CustomAppButton(
                  buttonText:Get.find<HrDashBoardController>().isJobApplicationUpdateLoading.isTrue?const CupertinoActivityIndicator(color: AppColor.cardColor,):

                  Text(
                    "Paste here",
                    style: AppStyle.normal_text_grey
                        .copyWith(color: AppColor.cardColor, fontSize: 15),
                  ),
                  onPressed: () {

                    HrDashBoardController controller=Get.find<HrDashBoardController>();
                    controller.updateJobApplication(hiringStageId: controller.selectedHiringStageId.value, jobApplicationId: controller.selectedJobApplicationId.value, entryId: controller.jobApplicationBoard?.getJobApplicationBoard?.id??"");


                  },
                  buttonColor: AppColor.primaryColor,
                  borderRadius: 35,
                ),
              )
            : const SizedBox.shrink(), // Empty widget when not selected
      );
    });
  }
}

Widget _buildMoreView() {
  return SingleChildScrollView(
    child: Column(
      children: [
        _buildHeaderSection(),
        _buildMoreInfoSection(
          text: AppString.text_share.tr,
          onTap: () {
            showShareDialog(
                titleText: AppString.text_job_post.replaceAll("p", "P").tr,
                description: AppString.text_this_is_visible_to_everyone_etc,
                linkDinAction: () {},
                messengerAction: () {},
                slackAction: () {},
                whatAppAction: () {},
                copyAction: () {});
          },
        ),
        _buildMoreInfoSection(
          text: AppString.text_unpublish.tr,
          onTap: () {
            _showRemoveDialog();
          },
        ),
      ],
    ),
  );
}

// A method to build the header section with profile image and name.
Widget _buildHeaderSection() {
  return customButtonSheetAppbar(
    height: 150,
    titleWidget: Text(
      "Node.js Developer",
      style: AppStyle.mid_large_text.copyWith(
        color: AppColor.secondaryColor,
        fontWeight: FontWeight.w700,
        fontSize: Dimensions.fontSizeDefault + 3,
      ),
    ),
    subtext: "Laravel department",
  );
}

// A method to build individual more info items with divider.
Widget _buildMoreInfoSection({
  required String text,
  required VoidCallback onTap,
}) {
  return customMoreInfoTextWithDiver(
    text: text,
    onTap: onTap,
  );
}

void _showRemoveDialog() {
  return displayCustomDialog(
      context: Get.context!,
      customIconWidget: SizedBox(
          height: 65,
          width: 65,
          child: customSvgImage(imageUrl: Images.UNPUBLISH_ICON)),
      titleText: AppString.text_unpublish_job.tr,
      descriptionText:
          AppString.text_you_are_going_to_unpublish_this_job_etc.tr,
      customActionButtons: CustomDoubleAppButton(
        onAction: () {},
        cancelAction: () => Get.back(canPop: false),
        btnColor: AppColor.pendingColor,
        buttonText: AppString.text_unpublish.tr,
      ));
}
