import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/modules/auth/view/screens/otp_screen.dart';
import 'package:payrun_mobile/modules/profile/model/user_profile.dart';
import 'package:payrun_mobile/modules/profile/view/screen/hr_profile/widgtes.dart';
import '../../../../../common/widget/custom_spacer.dart';
import '../../../../../utils/app_color.dart';
import '../../../controller/user_profile_controller.dart';
import '../../widget/profile_appbar.dart';

class HrProfileScreen extends StatelessWidget {
  const HrProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
  UserDetails? data=  Get.find<UserProfileController>().userDetails;
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: _profileAppbar(context),
      body: Padding(
        padding: marginLayout,
        child: ListView(
          children: [

            UserInfoLayout(information:data??UserDetails()),
            customSpacerHeight(height: 30),


            ///monthlyStatusLayout(),
            customSpacerHeight(height: 30),




          ],
        ),
      ),
    );
  }

  _profileAppbar(BuildContext context) {
    return profileAppbar(
      bgColor: AppColor.backgroundColor ,
      onAction: () {
        // showCustomDrawer(
        //   context: context,
        //   child: Container(
        //     color: Colors.transparent,
        //     width: double.infinity,
        //     child: endDrawer(context),
        //   ),
        // );
      },
    );
  }



}






class UserInformation{
  String ?name;
  String ?departmentName;
  String ?imgKey;
  String ?leaveBalance;
  String ?monthlyGoal;
  String ?loggedTime;
  List<String> ?deptHistories;

  UserInformation(
      {this.name,
      this.departmentName,
      this.imgKey,
      this.deptHistories,
      this.leaveBalance,
      this.monthlyGoal,
      this.loggedTime});
}


