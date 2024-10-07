import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/common/widget/custom_app_button.dart';
import '../../../../../../common/widget/custom_spacer.dart';
import '../../../../../../common/widget/custom_svg_image.dart';
import '../../../../../../common/widget/input_note.dart';
import '../../../../../../common/widget/timePicker/custom_time_picker_out_time.dart';
import '../../../../../../common/widget/timePicker/date_time_picker_controller.dart';
import '../../../../../../utils/app_color.dart';
import '../../../../../../utils/app_string.dart';
import '../../../../../../utils/app_style.dart';
import '../../../../../../utils/dimensions.dart';
import '../../../../../../utils/images.dart';
import '../../../controller/employee_controller.dart';


class TerminateWidget extends StatelessWidget {
  const TerminateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final EmployeeController controller = Get.put(EmployeeController());

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
      child: Column(
        children: [
          Expanded(
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
                  _buildTerminationOptions(context, controller),
                  customSpacerHeight(height: 8),
                  _buildTerminateDatePicker(context),
                  customSpacerHeight(height: 16),
                  _buildReasonNote(),
                  customSpacerHeight(height: 300),
                ],
              ),
            ),
          ),
          _buildButtons(),

        ],
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
          "Bartosz Friedemann",
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

  Widget _buildTerminationOptions(BuildContext context, EmployeeController controller) {
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
            _buildRadioOption(context, AppString.textTerminate, controller),
            _buildRadioOption(context, AppString.textResigned, controller),
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
          controller: TextEditingController(),
          hintText: "Type here",
          borderColor: AppColor.hintColor.withOpacity(0.5),
          onChanged: (value) {},
        ),
      ],
    );
  }

  Widget _buildButtons() {
    return Row(
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
                  const Icon(Icons.close, color: AppColor.hintColor, size: 23),
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
              onPressed: ()=>Get.back(),
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
                  const Icon(Icons.block_flipped, color: AppColor.cardColor, size: 23),
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
              onPressed: () {},
              buttonColor: AppColor.errorColorLight,
              borderColor: AppColor.errorColorLight,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRadioOption(BuildContext context, String value, EmployeeController controller) {
    return Expanded(
      child: Row(
        children: [
          Radio<String>(
            value: value,
            activeColor: AppColor.primaryColor,
            groupValue: controller.selectedOption.value,
            onChanged: (newValue) => controller.selectedOption.value = newValue ?? '',
          ),
          Text(
            value,
            style: AppStyle.normal_text.copyWith(color: AppColor.normalTextColor),
          ),
        ],
      ),
    );
  }

  Widget _datePicker(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => Dialog(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  OutDatePicker(),
                ],
              ),
            ),
          ),
        );
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
            Obx(() {
              final dateTime = Get.find<DateTimePickerController>().outDateTime.value;
              DateTime parsedDate = DateTime.tryParse(dateTime) ?? DateTime.now();
              String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
              return Text(
                formattedDate,
                style: const TextStyle(color: Colors.black, fontSize: 16),
              );
            }),
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
}
