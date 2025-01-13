import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/app/modules/employee/enum/termination_type_enum.dart';
import 'package:payrun_mobile/app/modules/employee/model/terminate_org_user.dart';
import 'package:payrun_mobile/common/widget/custom_app_button.dart';
import 'package:payrun_mobile/common/widget/warning_message.dart';
import '../../../../../../../common/widget/custom_spacer.dart';
import '../../../../../../../common/widget/custom_svg_image.dart';
import '../../../../../../../common/widget/input_note.dart';
import '../../../../../../../utils/app_color.dart';
import '../../../../../../../utils/app_string.dart';
import '../../../../../../../utils/app_style.dart';
import '../../../../../../../utils/dimensions.dart';
import '../../../../../../../utils/images.dart';
import '../../../../../../common/widget/timePicker/custom_date_picker.dart';
import '../../../controller/employment_controller.dart';

class TerminateWidget extends StatelessWidget {
  final String orgUserName;
  final String orgUserId;

  const TerminateWidget({
    super.key,
    required this.orgUserId,
    required this.orgUserName,
  });

  @override
  Widget build(BuildContext context) {
    _resetTerminationValue();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customSvgImage(imageUrl: Images.terminate, width: 64, height: 64),
            customSpacerHeight(height: 20),
            _buildTitleRow(),
            customSpacerHeight(height: 15),
            _buildDescription(),
            customSpacerHeight(height: 15),
            _buildTerminationOptions(context, Get.find<EmploymentController>()),
            customSpacerHeight(height: 8),
            _buildTerminateDatePicker(context),
            customSpacerHeight(height: 16),
            _buildReasonNote(),
            customSpacerHeight(height: 20),
            _buildButtons(),
            customSpacerHeight(height: 300),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleRow() {
    return Row(
      children: [
        Text(
          AppString.textTerminating.tr,
          style: AppStyle.title_text.copyWith(
            color: AppColor.normalTextColor,
            fontSize: Dimensions.fontSizeMid - 1,
            fontWeight: FontWeight.w500,
          ),
        ),
        customSpacerWidth(width: 8),
        Text(
          orgUserName,
          style: AppStyle.title_text.copyWith(
            color: AppColor.secondaryColor,
            fontSize: Dimensions.fontSizeMid - 1,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Text(
      AppString.textThisActionWillRemoveEtc.tr,
      style: AppStyle.normal_text_black.copyWith(
        color: AppColor.hintColor,
        fontSize: Dimensions.fontSizeDefault,
      ),
    );
  }

  Widget _buildTerminationOptions(
      BuildContext context, EmploymentController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "What type of termination?",
          style: AppStyle.title_text.copyWith(
            color: AppColor.normalTextColor,
            fontWeight: FontWeight.w500,
            fontSize: Dimensions.fontSizeDefault + 1,
          ),
        ),
        customSpacerHeight(height: 8),
        Obx(() => Row(
              children: [
                _buildRadioOption(
                    context, AppString.textTerminate, "1", controller),
                _buildRadioOption(
                    context, AppString.textResigned, "2", controller),
              ],
            )),
      ],
    );
  }

  Widget _buildTerminateDatePicker(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppString.textTerminateDate.tr,
          style: AppStyle.title_text.copyWith(
            color: AppColor.normalTextColor,
            fontSize: Dimensions.fontSizeDefault,
          ),
        ),
        customSpacerHeight(height: 8),
        _datePicker(context),
      ],
    );
  }

  Widget _buildReasonNote() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppString.textReasonNote.tr,
          style: AppStyle.title_text.copyWith(
            color: AppColor.normalTextColor,
            fontSize: Dimensions.fontSizeDefault,
          ),
        ),
        customSpacerHeight(height: 12),
        InputNote(
          controller:
              Get.find<EmploymentController>().terminationEditNoteController,
          hintText: "Type here",
          borderColor: AppColor.hintColor.withOpacity(0.5),
          onChanged: (value) {
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildButtons() {
    EmploymentController controller = Get.find<EmploymentController>();
    return Obx(
      () => controller.isTerminatedUserDataLoading.isTrue
          ? const Center(
              child: CupertinoActivityIndicator(
                color: AppColor.primaryColor,
                radius: 14,
              ),
            )
          : Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 45,
                    child: CustomAppButton(
                      borderRadius: Dimensions.radiusDefault,
                      isButtonExpanded: false,
                      buttonText: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.close,
                              color: AppColor.hintColor, size: 23),
                          customSpacerWidth(width: 8),
                          Text(
                            AppString.text_cancel.tr,
                            style: AppStyle.normal_text.copyWith(
                              color: AppColor.hintColor,
                              fontSize: Dimensions.fontSizeDefault + 2,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () => Get.back(),
                      buttonColor: AppColor.cardColor,
                      borderColor: AppColor.hintColor.withOpacity(0.5),
                    ),
                  ),
                ),
                customSpacerWidth(width: 14),
                Expanded(
                  child: SizedBox(
                    height: 45,
                    child: CustomAppButton(
                      isButtonExpanded: false,
                      borderRadius: Dimensions.radiusDefault,
                      buttonText: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.block_flipped,
                              color: AppColor.cardColor, size: 23),
                          customSpacerWidth(width: 8),
                          Text(
                            AppString.textTerminate.tr,
                            style: AppStyle.normal_text.copyWith(
                              color: AppColor.cardColor,
                              fontSize: Dimensions.fontSizeDefault + 2,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () async {
                        if (controller.selectedTerminationOption.isNotEmpty) {
                          bool isUserTerminated =
                              await controller.terminatedAUser(
                            TerminateUserModel(
                                orgUserId: orgUserId,
                                terminationTypeEnum: controller
                                            .selectedTerminationOption.value ==
                                        '1'
                                    ? TerminationTypeEnum.terminated.name
                                    : TerminationTypeEnum.resigned.name,
                                terminationOrResignationDate: controller
                                    .selectedTerminationDate
                                    .toString(),
                                terminationOrResignationReason: controller
                                    .terminationEditNoteController.text),
                          );
                          if (isUserTerminated) {
                            Get.back();
                          }
                        } else {
                          showWarningMessage(
                              message: AppString.pleaseProvideATerminationType);
                        }
                      },
                      buttonColor: AppColor.errorColorLight,
                      borderColor: AppColor.errorColorLight,
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildRadioOption(BuildContext context, String value,
      String assignEdValue, EmploymentController controller) {
    return Expanded(
      child: Row(
        children: [
          Radio<String>(
              value: assignEdValue,
              activeColor: AppColor.primaryColor,
              groupValue: controller.selectedTerminationOption.value,
              onChanged: (newValue) {
                controller.selectedTerminationOption.value = newValue ?? '';
              }),
          Text(
            value,
            style:
                AppStyle.normal_text.copyWith(color: AppColor.normalTextColor),
          ),
        ],
      ),
    );
  }

  Widget _datePicker(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final selectedDate = await showDialog<Map<String, DateTime?>>(
          context: context,
          builder: (BuildContext context) => CustomCalendarPicker(
              isRangeSelectionEnabled: false,
              weekendDays: const <int>[],
              cancelTextStyle: AppStyle.normal_text.copyWith(
                  color: AppColor.secondaryColor,
                  fontSize: Dimensions.fontSizeDefault + 1),
              baseColor: AppColor.primaryColor,
              holidayDates: const []),
        );
        if (selectedDate != null) {
          DateTime? terminationDate = selectedDate["start"];
          Get.find<EmploymentController>().selectedTerminationDate.value =
              terminationDate!;
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: AppColor.hintColor.withOpacity(0.5)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(
              () => _showTerminationDate(),
            ),
            const Icon(
              CupertinoIcons.calendar,
              color: Colors.grey,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }

  _showTerminationDate() {
    final dateTime =
        Get.find<EmploymentController>().selectedTerminationDate.value;
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    return Text(
      formattedDate,
      style: const TextStyle(color: Colors.black, fontSize: 16),
    );
  }

  void _resetTerminationValue() {
    Get.find<EmploymentController>()
      ..selectedTerminationOption.value = ''
      ..selectedTerminationDate = DateTime.now().obs
      ..terminationEditNoteController.clear();
  }
}
