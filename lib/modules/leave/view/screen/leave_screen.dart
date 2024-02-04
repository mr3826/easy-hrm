import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/loading_indicator.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/leave/controller/apply_leave_controller.dart';
import 'package:payrun_mobile/modules/leave/controller/leave_screen_controller.dart';
import 'package:payrun_mobile/modules/leave/view/screen/apply_leave.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import '../../../../common/widget/custom_drawer.dart';
import '../../../../common/widget/timePicker/date_time_picker_controller.dart';
import '../../../../utils/utils.dart';
import '../widget/individual_event_view.dart';
import '../widget/widget.dart';

class LeaveScreen extends GetView<LeaveScreenController> {
  const LeaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print("ordId: ${GetStorage().read(AppString.ORGANIZATION_ID)}");
    print("idToken: ${GetStorage().read(AppString.ID_TOKEN)}");
    return controller.obx(
        (state) => Scaffold(
              body: RefreshIndicator(
                backgroundColor: Colors.white,
                onRefresh: _refreshScreen,
                child: CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [sliverAppBar, sliverToBoxAdapter],
                ),
              ),
              floatingActionButton: _applyLeaveBtn(context),
            ),
        onLoading: const LoadingIndicator());
  }

  //component
  _applyLeaveBtn(BuildContext context) {
    return GestureDetector(
      onTap: () {
        leaveNoteController.clear();
        if (Get.isRegistered<DateTimePickerController>()) {
          Get.delete<DateTimePickerController>();
        }
        Get.put(DateTimePickerController());

        if (Get.isRegistered<ApplyLeaveController>()) {
          Get.delete<ApplyLeaveController>();
        }
        Get.put(ApplyLeaveController());
          _customButtonSheet(context: context, child: const ApplyLeaveScreen());
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 35.0, bottom: 18),
        child: Container(
          decoration: BoxDecoration(
              color: AppColor.primaryColor,
              borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge)),
          height: AppLayout.getHeight(50),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.add,
                color: AppColor.cardColor,
                size: 17,
              ),
              customSpacerWidth(width: 4),
              Center(
                  child: Text(
                AppString.text_apply_leve.tr,
                style: AppStyle.mid_large_text.copyWith(
                    color: AppColor.cardColor,
                    fontWeight: FontWeight.w700,
                    fontSize: Dimensions.radiusMid - 1),
              )),
            ],
          ),
        ),
      ),
    );
  }

  void _customButtonSheet({context, child}) {
    //For screen size
    // double screenHeight =
    //     MediaQuery.of(context).size.height == 616.0 ? 550 : 700;

    return showCustomAtmBtnSheet(
        height: Get.height * .8,
        context: context,
        child: Material(
          color: AppColor.noColor,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimensions.radiusMid),
                  topLeft: Radius.circular(Dimensions.radiusMid)),
              color: AppColor.cardColor,
            ),
            child: child,
          ),
        ));
  }

  Future<void> _refreshScreen() async {
    await controller.getLeaveSummaryForDashboard();
    await controller.getLeaveDetailsByDate();
  }
}

SliverAppBar get sliverAppBar {
  return SliverAppBar(
    expandedHeight: AppLayout.getHeight(250),
    elevation: 0,
    bottom: _buttonRadiusLayout(),
    pinned: true,
    backgroundColor: AppColor.primaryColor,
    flexibleSpace: FlexibleSpaceBar(
      background: SizedBox(
        height: AppLayout.getHeight(100),
        child: Padding(
          padding: marginLayout,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customSpacerHeight(height: 45),
                  _leaveText(),
                  customSpacerHeight(height: 14),
                  leaveLayout(),
                  customSpacerHeight(height: 14),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

_leaveText() {
  return  Text(
    AppString.text_leave.tr,
    style: AppStyle.mid_large_text.copyWith(fontSize: 20),
  );
}

_buttonRadiusLayout() {
  return PreferredSize(
    preferredSize: const Size.fromHeight(20),
    child: Container(
        decoration: BoxDecoration(
            color: AppColor.backgroundColor,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(Dimensions.radiusMid + 10),
                topLeft: Radius.circular(Dimensions.radiusMid + 10))),
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
  return const SliverToBoxAdapter(child: IndividualEventView());
}
