import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';

class BuildTabDetails extends StatelessWidget {
  const BuildTabDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: marginLayout.copyWith(top: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitleText("Basic information"),
            _buildBasicInfo(),
            customSpacerHeight(height: 20),
            _buildTitleText("Contact & Social media"),
            _buildContactsAndSocialMedia(),
            customSpacerHeight(height: 20),
            _buildTitleText("Portfolio"),
            _buildPortfolio(),
            customSpacerHeight(height: 20),
            _buildTitleText("Education & Experience"),
            _buildEducationAndExperience(),
            customSpacerHeight(height: 20),
            _buildTitleText("Skill & Expertise"),
            _buildSkillAndExpertise(),
          ],
        ),
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
            .map((e) =>
                _buildDetailsRow(label: "${e["label"]}", value: e["value"]))
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
            .map((e) => _buildDetailsRow(
                label: e["label"], value: e["value"] ?? "", link: e["link"]))
            .toList()),
  );
}

_buildPortfolio() {
  final List<Map<String, dynamic>> infoList = [
    {
      'label': "Resume:",
      'file': "https://test-owner-org.dev.payrun.app/hiring/applications",
    },
    {
      'label': "cover letter:",
      'file': "https://github.com/GainHQ/Mobile.App.Payrun",
    },
    {
      'label': "Portfolio link:",
      'link': "https://github.com/GainHQ/Mobile.App.Payrun",
    },
  ];
  return Padding(
    padding: const EdgeInsets.only(top: 12),
    child: Column(
        children: infoList
            .map((e) => _buildDetailsRow(
                label: "${e["label"]}", link: e["link"], file: e["file"]))
            .toList()),
  );
}

_buildEducationAndExperience() {
  final List<Map<String, dynamic>> infoList = [
    {
      'label': "Education:",
      'value':
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since.",
    },
    {
      'label': "Experience:",
      'value':
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since.",
    },
  ];
  return Padding(
    padding: const EdgeInsets.only(top: 12),
    child: Column(
        children: infoList
            .map((e) =>
                _buildDetailsRow(label: "${e["label"]}", value: e["value"]))
            .toList()),
  );
}

_buildSkillAndExpertise() {
  return Padding(
    padding: const EdgeInsets.only(top: 12),
    child: _buildSkillAndExperts(),
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

Widget _buildDetailsRow(
    {required String label,
    String? value,
    String? link,
    String? file,
    String? skill}) {
  final hasValue = value?.isNotEmpty ?? false;
  final hasLink = link?.isNotEmpty ?? false;
  final hasFile = file?.isNotEmpty ?? false;
  return Padding(
    padding:
        EdgeInsets.only(bottom: (hasValue || hasLink || hasFile) ? 9.0 : 0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasValue || hasLink || hasFile)
          Expanded(
            flex: 1,
            child: Text(
              label,
              style: AppStyle.normal_text.copyWith(color: AppColor.hintColor),
            ),
          ),
        if (hasValue || hasLink || hasFile) const SizedBox(width: 16),
        if (hasValue)
          Expanded(
            flex: 2,
            child: Text(
              value ?? "",
              maxLines: 20,
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
        if (hasFile) _buildAttachFile(file ?? ""),
      ],
    ),
  );
}

_buildAttachFile(String url) {
  return Expanded(
    flex: 2,
    child: GestureDetector(
      onTap: () {
        //url
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: AppLayout.getHeight(160),
            width: AppLayout.getHeight(140),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColor.hintColor.withOpacity(0.1)),
              child: Icon(
                CupertinoIcons.doc_text,
                size: 85,
                color: AppColor.normalTextColor.withOpacity(0.5),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Resume.pdf",
            style: AppStyle.normal_text.copyWith(
                color: AppColor.normalTextColor.withOpacity(0.8),
                fontSize: Dimensions.fontSizeSmall),
          )
        ],
      ),
    ),
  );
}

Widget _buildSkillAndExperts() {
  List<String> skills = ["Node.js", "React"]; // Skills array
  List<String> experts = [
    "Github",
    "React",
    "Github",
    "Agile"
  ]; // Experts array

  Widget _buildGrid(String title, List<String> items) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            title,
            style: AppStyle.normal_text.copyWith(color: AppColor.hintColor),
          ),
        ),
        Expanded(
          flex: 2,
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 4,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  const Icon(
                    Icons.check_box,
                    color: AppColor.primaryColor,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    items[index],
                    style: AppStyle.normal_text.copyWith(
                      color: AppColor.normalTextColor,
                      fontSize: Dimensions.fontSizeDefault + 1,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  return Column(
    children: [
      _buildGrid("Skill", skills),
      const SizedBox(height: 12),
      SizedBox(
        height: 100, // Set a height to limit the GridView for experts
        child: _buildGrid("Experts", experts),
      ),
    ],
  );
}
