import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_card_style.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import '../../../../../../../../utils/utils.dart';

class SeeDocumentDetails extends StatelessWidget {
  const SeeDocumentDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView.builder(
              itemCount: 4,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) => _buildDocumentCard(fileName: "File_name_one.pdf",date: "2024-10-29 16:13:16.049738"),
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
  Widget _buildDocumentCard({required String date,required String fileName}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: SizedBox(
        height: 70,
        width: double.infinity,
        child: Card(
          elevation: 0,
          color: AppColor.leaveRecordCardColor,
          shape: roundedRectangleBorder.copyWith(borderRadius: BorderRadius.circular(5)),
          child: Row(
            children: [
              _buildDocumentIcon(),
              customSpacerWidth(width: 8),
              _buildDocumentInfo(date: date,fileName: fileName),
              customSpacerWidth(width: 4),
              _buildDownloadIcon(),
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
        shape: roundedRectangleBorder.copyWith(borderRadius: BorderRadius.circular(7)),
        child: const Icon(
          CupertinoIcons.doc_text,
          color: AppColor.cardColor,
          size: 28,
        ),
      ),
    );
  }

  /// Builds the document info section with file name and date.
  Widget _buildDocumentInfo({String ?fileName,String ?date}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            fileName??"",
            maxLines: 1,
            style: AppStyle.normal_text_black.copyWith(overflow: TextOverflow.ellipsis),
          ),
          Text(
            formatDate(date: date??"", format: "dd MMM, yyyy"),
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
  Widget _buildDownloadIcon() {
    return InkWell(
      onTap: () {},
      child: Icon(
        Icons.file_download_outlined,
        color: AppColor.hintColor.withOpacity(0.6),
        size: 28,
      ),
    );
  }
}
