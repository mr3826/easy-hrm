import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_card_style.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import '../../../../../../../../../utils/utils.dart';
import '../../../../../controller/hr_leave_controller.dart';
import 'document_view.dart';

class SeeDocumentDetails extends GetView<HrLeaveController> {
  const SeeDocumentDetails({super.key});

  @override
  Widget build(BuildContext context) {
    // Null check for files, handle empty or null state
    final files = controller.leaveDetailsById?.getLeaveDetailsById?.files;
    if (files == null || files.isEmpty) {
      return Column(
        children: [
          _buildHeader(),
          const SizedBox(
            height: 20,
          ),
          Center(
              child: Text(
                "No document!",
                style: AppStyle.normal_text_black.copyWith(color: AppColor.hintColor),
              )),
        ],
      );
    }

    return Column(
      children: [
        _buildHeader(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView.builder(
              itemCount: files.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                final file = files[index];
                return _buildDocumentCard(
                  fileName: file.name ?? "Unknown File",
                  date: controller.leaveDetailsById?.getLeaveDetailsById
                      ?.leaveDetails?.first.date ??
                      "",
                  imgUrl: file.key ?? "",
                  context: context,
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  /// Builds the header for the document details section with title and styling.
  Widget _buildHeader() {
    return Container(
      height: 68,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColor.bgColorWithTimeline,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          AppString.textAttachedFiles.tr,
          style: AppStyle.mid_large_text.copyWith(
            color: AppColor.normalTextColor,
            fontSize: Dimensions.fontSizeMid,
          ),
        ),
      ),
    );
  }

  /// Builds each document card displaying document name, date, and download icon.
  Widget _buildDocumentCard(
      {required String date,
        required String fileName,
        required String imgUrl,
        context}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: SizedBox(
        height: 70,
        width: double.infinity,
        child: Card(
          elevation: 0,
          color: AppColor.leaveRecordCardColor,
          shape: roundedRectangleBorder.copyWith(
              borderRadius: BorderRadius.circular(5)),
          child: Row(
            children: [
              _buildDocumentIcon(),
              customSpacerWidth(width: 8),
              _buildDocumentInfo(date: date, fileName: fileName),
              customSpacerWidth(width: 4),
              _buildDownloadIcon(imgUrl, context),
              customSpacerWidth(width: 4),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the document icon in the card.
  Widget _buildDocumentIcon() {
    return SizedBox(
      height: double.infinity,
      width: 60,
      child: Card(
        elevation: 0,
        color: AppColor.primaryColor,
        shape: roundedRectangleBorder.copyWith(
            borderRadius: BorderRadius.circular(7)),
        child: const Icon(
          CupertinoIcons.doc_text,
          color: AppColor.cardColor,
          size: 28,
        ),
      ),
    );
  }

  /// Builds the document info section with file name and date.
  Widget _buildDocumentInfo({String? fileName, String? date}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            fileName ?? "Unknown File",
            maxLines: 1,
            style: AppStyle.normal_text_black
                .copyWith(overflow: TextOverflow.ellipsis),
          ),
          Text(
            formatDate(date: date ?? "", format: "dd MMM, yyyy"),
            maxLines: 1,
            style: AppStyle.normal_text.copyWith(
              color: AppColor.hintColor,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the download icon in the document card.
  Widget _buildDownloadIcon(imgUrl, context) {
    return InkWell(
      onTap: () {
        // Check if imgUrl is not null or empty before navigating
        if (imgUrl.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DocumentView(url: imgUrl)),
          );
        } else {
          // Handle the case when imgUrl is empty or null
          Get.snackbar("Error", "Document URL is not available.");
        }
      },
      child: Icon(
        Icons.remove_red_eye_outlined,
        color: AppColor.hintColor.withOpacity(0.6),
        size: 28,
      ),
    );
  }
}