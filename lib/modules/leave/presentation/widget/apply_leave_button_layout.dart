import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_alert_dialog.dart';
import 'package:payrun_mobile/common/widget/custom_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_double_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_svg_image.dart';
import 'package:payrun_mobile/common/widget/input_note.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/leave/presentation/controller/file_upload_controller.dart';
import 'package:payrun_mobile/modules/leave/presentation/widget/apply_leave_multi_day.dart';
import 'package:payrun_mobile/modules/leave/presentation/widget/custom_title_text_widget.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';
import 'package:payrun_mobile/utils/utils.dart';

import 'apply_leave_single_day.dart';


class ApplyLeaveButtonLayout extends StatefulWidget {
  const ApplyLeaveButtonLayout({Key? key}) : super(key: key);

  @override
  State<ApplyLeaveButtonLayout> createState() => _ApplyLeaveButtonLayoutState();
}

class _ApplyLeaveButtonLayoutState extends State<ApplyLeaveButtonLayout> {
  var currentIndex = 0;

  List buttonText = [
    AppString.text_single_day.tr,
    AppString.text_multi_day.tr,

  ];
  final _selectedFieldIndex = [
    const ApplyLeaveDobSingleDay(),
    const ApplyLeaveDobMultiDay(),

  ];
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: marginLayout.copyWith(top: Dimensions.fontSizeMid),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(
              height: AppLayout.getHeight(80),
              child: GridView.builder(
                itemCount: buttonText.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    crossAxisCount: 2,
                    childAspectRatio: 3.14),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(Dimensions.radiusDefault),
                          side: BorderSide(
                              color: currentIndex == index
                                  ? AppColor.primaryColor
                                  : AppColor.disableColor.withOpacity(0.4))),
                      color: currentIndex == index
                          ? AppColor.primaryColor.withOpacity(0.05)
                          : AppColor.disableColor.withOpacity(0.4),
                      child: Center(
                          child: Row(
                            children: [
                              customSpacerWidth(width: 12),

                              customSvgImage(imageUrl: currentIndex == index?
                              Images.calendar_lav:   Images.calendar_outline_lav),
                              customSpacerWidth(width: 12),
                              Text(
                                buttonText[index],
                                style: AppStyle.small_text_black.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: Dimensions.fontSizeDefault,
                                    letterSpacing: 0.2,
                                    color: currentIndex == index
                                        ? AppColor.primaryColor
                                        : AppColor.normalTextColor),
                              ),
                            ],
                          )),
                    ),
                  );
                },
              ),
            ),

            _selectedFieldIndex[currentIndex],

            customSpacerHeight(height: 20),

            customTitleText(text: AppString.text_leave_type.tr),

            customSpacerHeight(height: 8),

            _leaveTypeDropDown(),

            customSpacerHeight(height: 20),

            customTitleText(text: AppString.text_description.tr),

            customSpacerHeight(height: 8),

            _noteTextField(),

            customTitleText(text: AppString.text_document.tr),
            customSpacerHeight(height: 6),
            Text(AppString.text_jpeg_jpg_png_etc,style: AppStyle.normal_text_black.copyWith(color: AppColor.hintColor.withOpacity(0.7)),),
            customSpacerHeight(height: 8),
            _addAttachment(),
            customSpacerHeight(height: 20),

            CustomDoubleAppButton(onAction: (){
            },buttonText: AppString.text_apply.tr,cancelAction: (){
              Navigator.pop(context);
              Get.find<FileUploadController>()
                  .storageForUpload
                  .filePath
                  .value = "";
            },),

            customSpacerHeight(height: 100),

          ],
        ),
      ),
    );
  }

  _leaveTypeDropDown() {
    List<String> leaveType = [
      "Casual leave",
      "Paid leave",
      "Unpaid leave",
      "Normal leave",
    ];
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppLayout.getWidth(10)),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8)),
      child: DropdownButton<String>(
        style: const TextStyle(fontWeight: FontWeight.w500),
        isExpanded: true,
        underline: const SizedBox.shrink(),
        icon: const Icon(Icons.expand_more, color: Colors.grey),
        iconEnabledColor: AppColor.normalTextColor,
        hint: Row(
          children: [

            Text(
              AppString.text_slected_an_option.tr,
              style: AppStyle.normal_text.copyWith(color: AppColor.hintColor),
            )
          ],
        ),
        value: dropdownValue,
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        items: leaveType.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
                value,
                style: AppStyle.normal_text.copyWith(color: AppColor.hintColor),
              )

          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue;
          });
        },
      ),
    );
  }

   _noteTextField() {
    return
      InputNote(controller: leaveNoteController);
  }

  _addAttachment() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      _dottedBorderLayout(
          child: GestureDetector(
              onTap: () {
                Get.find<FileUploadController>().storageForUpload.pickFile();
              },
              child: Obx(() => Get.find<FileUploadController>()
                  .storageForUpload
                  .filePath
                  .isNotEmpty
                  ? Get.find<FileUploadController>()
                  .storageForUpload
                  .filePath
                  .endsWith(".pdf")
                  ? _replaceFileLayout()
                  : _selectedImageViewLayout()
                  : _emptyBox()))),
      customSpacerHeight(height: 8),
     Obx(() =>  _pathNameText(),),

    ],
  );

  _replaceFileLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          elevation: 0,
          shape: roundedRectangleBorder.copyWith(side: BorderSide(color: AppColor.hintColor.withOpacity(0.3))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Icon(
                  Icons.image_outlined,
                  color: AppColor.primaryColor,
                ),
                customSpacerWidth(width: 8),
                Text(
                  AppString.text_replace_file.tr,
                  style: AppStyle.mid_large_text.copyWith(
                      color: AppColor.primaryColor,
                      fontSize: Dimensions.fontSizeDefault + 2),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _emptyBox() {
    return Container(
      color: AppColor.primaryColor.withOpacity(0.05),
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 0,
              shape: roundedRectangleBorder.copyWith(side: BorderSide(color: AppColor.hintColor.withOpacity(0.3))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.image_outlined,
                      color: AppColor.hintColor,
                    ),
                    customSpacerWidth(width: 8),
                    Text(
                      AppString.text_upload_image.tr,
                      style: AppStyle.mid_large_text.copyWith(
                          color: AppColor.hintColor,
                          fontSize: Dimensions.fontSizeDefault + 2),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  _pathNameText() {
    return Text(
        Get.find<FileUploadController>()
            .storageForUpload
            .filePath
            .value
            .split('/')
            .last,
        style: AppStyle.mid_large_text.copyWith(
            color: AppColor.primaryColor,
            fontSize: Dimensions.fontSizeDefault - 2));
  }

}



_selectedImageViewLayout() {
  return Container(
    height: AppLayout.getHeight(100),
    decoration: BoxDecoration(
      color: AppColor.disableColor.withOpacity(0.4),
      image: DecorationImage(
        image: FileImage(
            File(Get.find<FileUploadController>()
            .storageForUpload
            .filePath
            .value)
            .absolute

        ),
        fit: BoxFit.cover,
      ),
    ),
  );
}

Widget _dottedBorderLayout({required child}) {
  return DottedBorder(
    radius: Radius.circular(Dimensions.radiusMid),
    color: AppColor.disableColor,
    strokeCap: StrokeCap.square,
    dashPattern: const [8, 6],
    strokeWidth: AppLayout.getWidth(2),
    child: SizedBox(
      height: AppLayout.getHeight(140),
      child: child,
    ),
  );
}
