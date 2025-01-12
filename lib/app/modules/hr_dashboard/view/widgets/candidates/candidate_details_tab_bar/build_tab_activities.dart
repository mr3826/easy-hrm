import 'package:flutter/cupertino.dart';
import 'package:payrun_mobile/common/widget/hr_deshboard/custom_network_img.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';

class BuildTabActivities extends StatelessWidget {
  const BuildTabActivities({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(left: 20, right: 20),
      itemBuilder: (context, index) {
        return _buildContext();
      },
    );
  }
}



_buildContext() {
  return LayoutBuilder(
    builder: (context, constraints) {
      double width = constraints.maxWidth;
      double textFontSize = width * 0.04; // Dynamic font size
      double smallTextFontSize = width * 0.03; // Smaller text font size
      double spacerWidth = width * 0.03; // Spacer width

      return Padding(
        padding: EdgeInsets.only(
          top: width * 0.05, // Dynamic top padding
          bottom: width * 0.03, // Dynamic bottom padding
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomNetworkImage(
              imageUrl: Images.demoImage,
              isCircleImage: true,
              radius: 18,
              borderColor: AppColor.primaryColor,
            ),
            SizedBox(width: spacerWidth), // Spacer with dynamic width
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Noah",
                    style: AppStyle.normal_text_grey.copyWith(
                      color: AppColor.normalTextColor,
                      fontSize: textFontSize,
                    ),
                  ),
                  const SizedBox(height: 3),
                  _buildContent(smallTextFontSize, "5"),
                ],
              ),
            )
          ],
        ),
      );
    },
  );
}

_buildContent(double fontSize, [context]) {
  var file = ["F"];

  if (context == "1") {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Sent email to ",
                style: AppStyle.normal_text.copyWith(
                  color: AppColor.normalTextColor.withOpacity(0.7),
                  fontSize: fontSize + 1,
                ),
              ),
              TextSpan(
                text: "Katarina Neilson",
                style: AppStyle.normal_text.copyWith(
                  color: AppColor.normalTextColor,
                  fontSize: fontSize + 1,
                ),
              ),
            ],
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          "on Mon, 22 April, 20022 at 13:00",
          style: AppStyle.normal_text.copyWith(
            color: AppColor.normalTextColor.withOpacity(0.6),
            fontSize: fontSize + 1,
          ),
        ),
        if (file.isNotEmpty) ...[const SizedBox(height: 8), _buildAttachFile()]
      ],
    );
  } else if (context == "2") {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Edited ",
                style: AppStyle.normal_text.copyWith(
                  color: AppColor.normalTextColor.withOpacity(0.7),
                  fontSize: fontSize + 1,
                ),
              ),
              TextSpan(
                text: "Name ",
                style: AppStyle.normal_text.copyWith(
                  color: AppColor.normalTextColor,
                  fontSize: fontSize + 1,
                ),
              ),
              TextSpan(
                text: "of ",
                style: AppStyle.normal_text.copyWith(
                  color: AppColor.normalTextColor.withOpacity(0.7),
                  fontSize: fontSize + 1,
                ),
              ),
              TextSpan(
                text: "Katarina Neilson",
                style: AppStyle.normal_text.copyWith(
                  color: AppColor.normalTextColor,
                  fontSize: fontSize + 1,
                ),
              ),
            ],
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          "on Mon, 22 April, 20022 at 13:00",
          style: AppStyle.normal_text.copyWith(
            color: AppColor.normalTextColor.withOpacity(0.6),
            fontSize: fontSize + 1,
          ),
        ),
        if (file.isNotEmpty) ...[const SizedBox(height: 8), _buildAttachFile()]
      ],
    );
  } else if (context == "3") {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Reviewed  ",
                style: AppStyle.normal_text.copyWith(
                  color: AppColor.normalTextColor.withOpacity(0.7),
                  fontSize: fontSize + 1,
                ),
              ),
              TextSpan(
                text: "4.0",
                style: AppStyle.normal_text_grey.copyWith(
                  color: AppColor.pendingColor,
                  fontSize: fontSize + 1,
                ),
              ),
              TextSpan(
                text: " ★ ",
                style: AppStyle.normal_text.copyWith(
                    color: AppColor.pendingColor, fontSize: fontSize + 5),
              ),
              TextSpan(
                text: "to ",
                style: AppStyle.normal_text.copyWith(
                  color: AppColor.normalTextColor.withOpacity(0.7),
                  fontSize: fontSize + 1,
                ),
              ),
              TextSpan(
                text: "Katarina Neilson",
                style: AppStyle.normal_text.copyWith(
                  color: AppColor.normalTextColor,
                  fontSize: fontSize + 1,
                ),
              ),
            ],
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          "on Mon, 22 April, 20022 at 13:00",
          style: AppStyle.normal_text.copyWith(
            color: AppColor.normalTextColor.withOpacity(0.6),
            fontSize: fontSize + 1,
          ),
        ),
        if (file.isNotEmpty) ...[const SizedBox(height: 8), _buildAttachFile()]
      ],
    );
  } else if (context == "4") {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Moved ",
                style: AppStyle.normal_text.copyWith(
                  color: AppColor.normalTextColor.withOpacity(0.7),
                  fontSize: fontSize + 1,
                ),
              ),
              TextSpan(
                text: "Katarina Neilson",
                style: AppStyle.normal_text.copyWith(
                  color: AppColor.normalTextColor,
                  fontSize: fontSize + 1,
                ),
              ),
              TextSpan(
                text: " to ",
                style: AppStyle.normal_text.copyWith(
                  color: AppColor.normalTextColor.withOpacity(0.7),
                  fontSize: fontSize + 1,
                ),
              ),
              TextSpan(
                text: "shortlisted for interview",
                style: AppStyle.normal_text.copyWith(
                  color: AppColor.normalTextColor,
                  fontSize: fontSize + 1,
                ),
              ),
            ],
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          "on Mon, 22 April, 20022 at 13:00",
          style: AppStyle.normal_text.copyWith(
            color: AppColor.normalTextColor.withOpacity(0.6),
            fontSize: fontSize + 1,
          ),
        ),
        if (file.isNotEmpty) ...[const SizedBox(height: 8), _buildAttachFile()]
      ],
    );
  } else if (context == "5") {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Applied for ",
                style: AppStyle.normal_text.copyWith(
                  color: AppColor.normalTextColor.withOpacity(0.7),
                  fontSize: fontSize + 1,
                ),
              ),
              TextSpan(
                text: "QA Engineer (Cypress)",
                style: AppStyle.normal_text.copyWith(
                  color: AppColor.normalTextColor,
                  fontSize: fontSize + 1,
                ),
              ),
            ],
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          "on Mon, 22 April, 20022 at 13:00",
          style: AppStyle.normal_text.copyWith(
            color: AppColor.normalTextColor.withOpacity(0.6),
            fontSize: fontSize + 1,
          ),
        ),
        if (file.isNotEmpty) ...[const SizedBox(height: 8), _buildAttachFile()]
      ],
    );
  }
}

_buildAttachFile() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        height: 100,
        width: 80,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColor.hintColor.withOpacity(0.1)),
          child: Icon(
            CupertinoIcons.doc_text,
            size: 50,
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
  );
}
