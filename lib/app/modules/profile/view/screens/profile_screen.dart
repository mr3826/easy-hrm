import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widget/custom_drawer.dart';
import '../../../../../common/widget/employee/user_Info_widget.dart';
import '../../../../../modules/profile/view/widget/common_widget.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/app_style.dart';
import '../../../../../utils/dimensions.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            _buildHeader(context),
            UserInfoWidget(
              employeeStatus: EmployeeStatus(
                firstName: "First",
                lastName: "last",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppString.text_profile.tr,
          style: AppStyle.mid_large_text.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: Dimensions.fontSizeMid + 1,
          ),
        ),
        IconButton(
          onPressed: () {
            showCustomDrawer(
              context: context,
              child: Container(
                color: Colors.transparent,
                width: double.infinity,
                child: endDrawer(context),
              ),
            );
          },
          icon: const Icon(Icons.menu, color: Colors.black),
        ),
      ],
    );
  }
}
