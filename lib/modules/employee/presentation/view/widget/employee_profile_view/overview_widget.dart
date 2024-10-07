import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import '../../../../../../common/widget/employee/custom_contact_info.dart';
import '../../../../../profile/view/widget/expanded_text_layout.dart';

class OverviewWidget extends StatelessWidget {
  const OverviewWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          const ExpandedText(
            text: "n publishing ana typeface n publishing ana typeface n publishing ana typeface n publishing ana typeface n publishing ana typeface n publishing ana typeface n publishing ana typeface n publishing ana typeface n publishing ana typeface n publishing ana typeface n publishing ana typeface n publishing ana typeface n publishing ana typeface ",
          ),

          customSpacerHeight(height: 15),

          CustomContactInfoWidget(staticText: AppString.text_email.tr,dynamicText: "",),
          customSpacerHeight(height: 15),

          CustomContactInfoWidget(staticText: AppString.text_phone.tr,dynamicText: "",),

          customSpacerHeight(height: 15),
          CustomContactInfoWidget(staticText: AppString.text_address.tr,dynamicText: "",),

          customSpacerHeight(height: 15),







        ],
      ),
    );
  }
}
