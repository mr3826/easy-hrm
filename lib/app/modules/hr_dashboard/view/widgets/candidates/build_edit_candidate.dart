import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_double_app_button.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import '../../../../../../../common/widget/custom_appbar.dart';
import '../../../../../../../common/widget/custom_spacer.dart';
import '../../../../../../../common/widget/custom_text_field.dart';
import '../../../../../../../common/widget/custom_title_text_widget.dart';
import '../../../../../../../init_ app.dart';
import '../../../../../../../utils/app_style.dart';
import '../../../../../global/view/widget/app_margin.dart';
import '../../../controllers/hr_deshboard_controller.dart';

class BuildEditCandidate extends StatelessWidget {
  BuildEditCandidate({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    HrDashBoardController controller = Get.find<HrDashBoardController>();
    return Scaffold(
      appBar: customAppbar(title: AppString.text_edit_candidate.tr),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: marginLayout,
          child: Column(
            children: [
              _userTextFieldLayout(
                titleText: "Email",
                controller: controller.candidateEmail,
                hintText: "Enter email address",
                validator: (value) {
                  if (value.isEmpty ||
                      !RegExp(emailValidExp()).hasMatch(value)) {
                    return AppString.please_insert_a_valid_email_address.tr;
                  } else {
                    return null;
                  }
                },
              ),
              _userTextFieldLayout(
                  titleText: AppString.text_first_name,
                  controller: controller.candidateFirstName,
                  hintText: "Enter first name"),
              _userTextFieldLayout(
                  titleText: AppString.text_last_name,
                  controller: controller.candidateLastName,
                  hintText: "Enter last name"),
              customSpacerHeight(height: 26),
              Obx(() => _buildButton(context)),
            ],
          ),
        ),
      ),
    );
  }

  _buildButton(context) {
    var controller = Get.find<HrDashBoardController>();

    if (controller.isUpdateCandidateLoading.isTrue) {
      return const Center(child: CupertinoActivityIndicator());
    }
    return CustomDoubleAppButton(onAction: () {
      FocusScope.of(context).requestFocus(FocusNode());
      if (_formKey.currentState!.validate()) {
        controller.updateCandidate(
            candidateId: controller.selectedCandidateId.value,
            jobId: controller.selectedJobId.value,
            email: controller.candidateEmail.text,
            firstName: controller.candidateFirstName.text,
            lastName: controller.candidateLastName.text).then((e){
              Get.back(canPop: false);
              Get.back(canPop: false);
              controller.getCandidateBySearch();
        });
      }
    }, cancelAction: () {
      _clear();
    });
  }

  void _clear() {
    HrDashBoardController controller = Get.find<HrDashBoardController>();
    Get.back(canPop: false);
    controller.candidateLastName.clear();
    controller.candidateFirstName.clear();
    controller.candidateEmail.clear();
  }
}

_userTextFieldLayout(
    {required String titleText,
    required TextEditingController controller,
    required String hintText,
    final String? Function(String?)? onChanged,
    validator}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      customTitleText(text: titleText),
      customSpacerHeight(height: 12),
      CustomInputField(
        hint: hintText,
        hintStyle:
            AppStyle.normal_text_grey.copyWith(fontWeight: FontWeight.w500),
        controller: controller,
        validator: validator,
        onChanged: onChanged,
      ),
      customSpacerHeight(height: 12),
    ],
  );
}
