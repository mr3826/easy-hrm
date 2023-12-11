import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_svg_image.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/profile/view/widget/dotted_style_layout.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';

class DepartmentHistory extends StatelessWidget {
  final String departmentName;
  final String date;
  final String employeeStatus;
  final String name;
  final String employeeDptStatus;
  final dynamic imageUrl;
  final int itemCount;

  const DepartmentHistory(
      {super.key,
      required this.departmentName,
      required this.date,
      required this.itemCount,
      required this.employeeStatus,
      required this.name,
      required this.employeeDptStatus,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customButtonSheetAppbar(
            text: AppString.text_deparmtnet.tr,
            subtext: AppString.text_history.tr),
        Expanded(
            child: ListView.builder(
          itemCount: itemCount,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return _departmentSectionInfoLayout(
                imageUrl: imageUrl,
                date: date,
                departmentName: departmentName,
                employeeDptStatus: employeeDptStatus,
                employeeStatus: employeeStatus,
                name: name);
          },
        ))
      ],
    );
  }

  _divider() {
    return Padding(
      padding: const EdgeInsets.only(left: 6.0, right: 6),
      child: Container(
        width: 1,
        color: AppColor.hintColor,
        height: 12,
      ),
    );
  }

  _departmentSectionInfoLayout(
      {required departmentName,
      required date,
      required employeeStatus,
      required name,
      required employeeDptStatus,
      required imageUrl}) {
    return Padding(
      padding: marginLayout.copyWith(bottom: 18, left: 0, right: 0, top: 16),
      child: Stack(
        children: [
          Padding(
            padding: marginLayout,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customSvgImage(
                    imageUrl: Images.department_notification,
                    color: AppColor.normalTextColor,
                    height: 18,
                    width: 18),
                customSpacerWidth(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$departmentName",
                      style: AppStyle.normal_text_grey.copyWith(
                          color: AppColor.normalTextColor,
                          fontSize: Dimensions.fontSizeMid - 3),
                    ),
                    Row(
                      children: [
                        Text(
                          "${AppString.text_child_of_deparmtnet.tr} ",
                          style: AppStyle.mid_large_text.copyWith(
                              color: AppColor.secondaryColor,
                              fontSize: Dimensions.fontSizeDefault - 2),
                        ),
                        _divider(),
                        Text(
                          "$date - ",
                          style: AppStyle.mid_large_text.copyWith(
                              color: AppColor.hintColor,
                              fontSize: Dimensions.fontSizeDefault - 2),
                        ),
                        Text(
                          "$employeeStatus",
                          style: AppStyle.mid_large_text.copyWith(
                              color: AppColor.primaryColor,
                              fontSize: Dimensions.fontSizeDefault - 2,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                    customSpacerHeight(height: 14),
                    SizedBox(
                      child: Stack(
                        children: [
                          Positioned(
                            child: Container(
                              height: AppLayout.getHeight(20),
                              width: AppLayout.getWidth(18),
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                      width: .9,
                                      color:
                                          AppColor.hintColor.withOpacity(0.6)),
                                  bottom: BorderSide(
                                      width: .9,
                                      color:
                                          AppColor.hintColor.withOpacity(0.6)),
                                ),
                              ),
                            ),
                          ),
                          Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 18,
                                      backgroundColor: AppColor.primaryOrange,
                                      child: CircleAvatar(
                                        radius: 17.2,
                                        backgroundColor: AppColor.cardColor,
                                        child: CircleAvatar(
                                          radius: 16,
                                          backgroundImage: AssetImage(imageUrl),
                                        ),
                                      ),
                                    ),
                                    customSpacerWidth(width: 20),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "$name",
                                          style: AppStyle.normal_text_grey
                                              .copyWith(
                                            color: AppColor.secondaryColor,
                                            fontSize:
                                                Dimensions.fontSizeDefault - 1,
                                          ),
                                        ),
                                        Text(
                                          "$employeeDptStatus",
                                          style: AppStyle.mid_large_text
                                              .copyWith(
                                                  color:
                                                      AppColor.normalTextColor,
                                                  fontSize: Dimensions
                                                          .fontSizeDefault -
                                                      3),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              _departmentCircleLayout()
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Positioned(
              top: 26,
              left: 1,
              bottom: 0,
              child: dottedStyleLayout(height: 88)),
        ],
      ),
    );
  }

  _departmentCircleLayout() {
    return Positioned(
        left: 40,
        bottom: 0,
        child: CircleAvatar(
          radius: 8,
          backgroundColor: AppColor.pureOrange,
          child: customSvgImage(
              imageUrl: Images.department_notification,
              color: AppColor.cardColor,
              height: 10),
        ));
  }
}
