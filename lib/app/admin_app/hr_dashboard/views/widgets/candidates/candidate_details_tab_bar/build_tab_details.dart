import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';

class BuildTabDetails extends StatelessWidget {
  const BuildTabDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: marginLayout.copyWith(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleText("Basic information"),
          _buildBasicInfo(),
          customSpacerHeight(height: 20),
          _buildTitleText("Contact & Social media"),
          _buildContactsAndSocialMedia(),

        ],
      ),
    );
  }
}





_buildBasicInfo() {
  final List<Map<String, dynamic>> infoList = [
    {
      'label': "First name:",
      'value': "Noah Ali",
    },
    {
      'label': "Last name:",
      'value': "Noah Ali",
    },
    {
      'label': "Email:",
      'value': "noah@gmail.com",
    },
    {
      'label': "Gender:",
      'value': "Male",
    },
    {
      'label': "Date of birth:",
      'value': "27 October 2023",
    },
  ];
  return Padding(
    padding: const EdgeInsets.only(top: 12),
    child: Column(
        children: infoList
            .map((e) => _buildDetailsRow("${e["label"]}", e["value"]))
            .toList()),
  );
}

_buildContactsAndSocialMedia() {
  final List<Map<String, dynamic>> infoList = [
    {
      'label': "Phone:",
      'value': "+880678785234",
    },
    {
      'label': "Address:",
      'value': "Mirpur-12, Dhaka, Bangladesh",
    },
    {
      'label': "Skype:",
      'link': "https://test-owner-org.dev.payrun.app/hiring/applications",
    },
    {
      'label': "Linked in:",
      'link': "https://github.com/GainHQ/Mobile.App.Payrun",
    },
  ];
  return Padding(
    padding: const EdgeInsets.only(top: 12),
    child: Column(
        children: infoList
            .map((e) => _buildDetailsRow("${e["label"]}", e["value"] ?? "",
                link: e["link"]))
            .toList()),
  );
}

_buildTitleText(String text) {
  return Text(
    text,
    style: AppStyle.mid_large_text.copyWith(
        color: AppColor.normalTextColor.withOpacity(0.8),
        fontSize: Dimensions.fontSizeDefault,
        fontWeight: FontWeight.w600),
  );
}


Widget _buildDetailsRow(String label, String value, {String? link}) {
  final hasValue = value.isNotEmpty;
  final hasLink = link?.isNotEmpty ?? false;

  return Padding(
    padding: EdgeInsets.only(bottom: (hasValue || hasLink) ? 9.0 : 0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasValue || hasLink)
          Expanded(
            flex: 1,
            child: Text(
              label,
              style: AppStyle.normal_text.copyWith(color: AppColor.hintColor),
            ),
          ),
        if (hasValue || hasLink) const SizedBox(width: 16),
        if (hasValue)
          Expanded(
            flex: 2,
            child: Text(
              value,
              maxLines: 3,
              style: AppStyle.normal_text
                  .copyWith(color: AppColor.normalTextColor),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        if (hasLink)
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () {
                // TODO: Add open browser URL functionality here
              },
              child: Text(
                link!,
                maxLines: 3,
                style: AppStyle.normal_text.copyWith(
                  color: AppColor.secondaryColor,
                  decoration: TextDecoration.underline,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
      ],
    ),
  );
}

