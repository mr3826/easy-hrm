import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/leave/presentation/view/apply_leave.dart';
import 'package:payrun_mobile/modules/leave/presentation/widget/individual_event_view.dart';
import 'package:payrun_mobile/modules/leave/presentation/widget/widget.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import '../../../../common/widget/custom_buttom_sheet.dart';

class LeaveScreen extends StatelessWidget {
  const LeaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [sliverAppBar, sliverToBoxAdapter],
      ),
      floatingActionButton: _applyLeaveBtn(context),
    );
    
  }
//component
  _applyLeaveBtn(context) {
    return GestureDetector(
      onTap: ()=>customButtonSheet(context: context,child: ApplyLeaveScreen()),
      child: Padding(
        padding: const EdgeInsets.only(left: 35.0,bottom: 18),
        child: Container(
          decoration: BoxDecoration(
              color: AppColor.primaryColor,
              borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge)
          ),
          height: AppLayout.getHeight(50),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.add,color: AppColor.cardColor,size: 17,),
              customSpacerWidth(width: 4),
              Center(child: Text(AppString.text_apply_leve.tr,style: AppStyle.mid_large_text.copyWith(color: AppColor.cardColor,fontWeight: FontWeight.w700,fontSize: Dimensions.radiusMid-1),)),
            ],
          ),
        ),
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
              leaveLayout(),
              customSpacerHeight(height: 14),
              leaveRecordBtnLayout()
            ],
          ),
        ),
      ),
    ),
  );
}
_buttonRadiusLayout() {
  return PreferredSize(
    preferredSize: const Size.fromHeight(20),
    child: Container(
        decoration: BoxDecoration(
            color: AppColor.cardColor,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(Dimensions.radiusMid+10), topLeft: Radius.circular(Dimensions.radiusMid+10))),
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
    child: IndividualEventView()
  );
}


