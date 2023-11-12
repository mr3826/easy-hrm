import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_alert_dialog.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';

class LeaveScreen extends StatelessWidget {
  const LeaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [sliverAppBar, sliverToBoxAdapter],
      ),
    );
  }
}

SliverAppBar get sliverAppBar {
  return SliverAppBar(
    expandedHeight: AppLayout.getHeight(299),
    elevation: 0,
    bottom: _buttonRadiusLayout(),
    pinned: true,
    backgroundColor: AppColor.primaryColor,
    flexibleSpace: FlexibleSpaceBar(
      background: SizedBox(
        height: AppLayout.getHeight(100),
        width: AppLayout.getWidth(200),
        child: Padding(
          padding: marginLayout,
          child: Column(
            children: [
              customSpacerHeight(height: 6),
              appBar,
              customSpacerHeight(height: 6),
              _leaveLayout(),
              customSpacerHeight(height: 14),
              _leaveRecordBtnLayout()
            ],
          ),
        ),
      ),
    ),
  );
}

_leaveRecordBtnLayout() {
  return GestureDetector(
    onTap: () {},
    child: Container(
      height: AppLayout.getHeight(36),
      width: AppLayout.getWidth(200),
      decoration: BoxDecoration(
        color: AppColor.secondaryColor,
        borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge),
      ),
      child: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppString.text_leave_records.tr,
            style:
                AppStyle.normal_text_black.copyWith(color: AppColor.cardColor),
          ),
          customSpacerWidth(width: 6),
          const Icon(
            Icons.arrow_forward,
            color: AppColor.cardColor,
            size: 17,
          )
        ],
      )),
    ),
  );
}

_leaveLayout() {
  return SizedBox(
    height: AppLayout.getHeight(124),
    width: double.infinity,
    child: Padding(
      padding: EdgeInsets.only(left: AppLayout.getHeight(12)),
      child: Card(
        elevation: 0,
        shape: roundedRectangleBorder.copyWith(
            borderRadius: BorderRadius.circular(8)),
        color: AppColor.cardColor.withOpacity(0.3),
        child: Padding(
          padding: marginLayout.copyWith(top: 12, bottom: 12),
          child: Row(
            children: [
              
              Column(
                children: [
                  _countLayout(
                      dynamicText: "12d",
                      staticText: AppString.text_total_leave.tr),

                  const Spacer(),

                  _countLayout(
                      dynamicText: "12d",
                      staticText: AppString.text_token.tr),
                ],
              ),
              const Spacer(),
              _dividerLayout(),
              const Spacer(),


              Column(
                children: [
                  _countLayout(
                      dynamicText: "12d",
                      staticText: AppString.text_paid_leave.tr),
                  const Spacer(),
                  _countLayout(
                      dynamicText: "12d",
                      staticText: AppString.text_balance.tr),
                ],
              ),

              const Spacer(),
             _dividerLayout(),
              const Spacer(),

              Column(
                children: [
                  _countLayout(
                      dynamicText: "12d",
                      staticText: AppString.text_unpaid_leave.tr),
                  const Spacer(),
                  _countLayout(
                      dynamicText: "12d",
                      staticText: AppString.text_pendding.tr),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

_dividerLayout() {
  return   Column(
    children: [
      _divider(),
      const Spacer(),
      _divider(),
    ],
  );
}

_divider() {
  return Container(
    width: 0.8,
    height: AppLayout.getHeight(25),
    color: AppColor.cardColor,
  );
}

_countLayout({required dynamicText, required staticText}) {
  return Column(
    children: [
      Text(
        "$dynamicText",
        style: AppStyle.normal_text_black
            .copyWith(color: AppColor.cardColor, fontWeight: FontWeight.bold),
      ),
      Text(
        "$staticText",
        style: AppStyle.normal_text_black.copyWith(
            color: AppColor.cardColor.withOpacity(0.9),
            fontSize: Dimensions.fontSizeDefault - 2),
      ),
    ],
  );
}

_buttonRadiusLayout() {
  return PreferredSize(
    preferredSize: const Size.fromHeight(20),
    child: Container(
        decoration: const BoxDecoration(
            color: AppColor.cardColor,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        width: double.maxFinite,
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: const Center(
            child: Text(
          "",
          style: TextStyle(fontSize: 23),
        ))),
  );
}

SliverToBoxAdapter get sliverToBoxAdapter {
  return const SliverToBoxAdapter(
    child: Text(
        "Lorem Ipsum is simplyLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem IpsumLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
  );
}

AppBar get appBar {
  return AppBar(
    elevation: 0,
    title: Text(
      AppString.text_leave,
      style: AppStyle.mid_large_text.copyWith(fontSize: 20),
    ),
    actions: const [
      Icon(
        Icons.menu,
        color: AppColor.cardColor,
      )
    ],
  );
}
