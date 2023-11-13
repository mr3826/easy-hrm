import 'package:flutter/material.dart';
import 'package:payrun_mobile/common/widget/custom_svg_image.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';

import 'apply_leave_single_day.dart';


class ApplyLeaveButtonLayout extends StatefulWidget {
  const ApplyLeaveButtonLayout({Key? key}) : super(key: key);

  @override
  State<ApplyLeaveButtonLayout> createState() => _ApplyLeaveButtonLayoutState();
}

class _ApplyLeaveButtonLayoutState extends State<ApplyLeaveButtonLayout> {
  var currentIndex = 0;
  List buttonText = [
    AppString.text_single_day,
    AppString.text_multi_day,

  ];
  final _dobField = [
    const ApplyLeaveDobSingleDay(),
    const ApplyLeaveDobSingleDay(),
  //  const ApplyLeaveDobMultiDay(),

  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: marginLayout.copyWith(top: Dimensions.fontSizeMid),
      child: Column(
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
                            customSvgImage(imageUrl: Images.half_day_lav),
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

          _dobField[currentIndex]
        ],
      ),
    );
  }
}
