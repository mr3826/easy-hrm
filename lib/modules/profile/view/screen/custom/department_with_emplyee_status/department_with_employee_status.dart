import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../../common/widget/custom_card_style.dart';
import '../../../../../../common/widget/custom_svg_image.dart';
import '../../../../../../utils/app_color.dart';
import '../../../../../../utils/app_layout.dart';
import '../../../../../../utils/app_string.dart';
import '../../../../../../utils/app_style.dart';
import '../../../../../../utils/dimensions.dart';
import '../../../../../../utils/images.dart';
import '../../../../../../utils/utils.dart';
import '../../../../../auth/presentation/view/otp_screen.dart';
import '../custom.dart';
import 'department.dart';
import 'employee_status.dart';




class BuildDepartmentWithEmployeeStatus extends StatelessWidget {
  final UserInformation userInformation;
  const BuildDepartmentWithEmployeeStatus({super.key,required this.userInformation});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DepartmentLayout(userInformation: userInformation,),

        Row(
          children: [
           // EmployeeStatusCard()
          ],
        )
      ],
    );
  }
}





