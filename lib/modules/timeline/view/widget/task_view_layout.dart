

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_text_field.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/timeline/controller/selected_task_controller.dart';
import 'package:payrun_mobile/modules/timeline/controller/timeline_controller.dart';
import 'package:payrun_mobile/modules/timeline/model/project_dropdown_response.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/utils.dart';

import '../../../leave/view/widget/custom_title_text_widget.dart';

class TaskViewLayout extends StatelessWidget {
  const TaskViewLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: marginLayout.copyWith(top: 20, bottom: 20),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customTitleText(text: AppString.text_project_task.tr,isRequired: true),
                  customSpacerHeight(height: 8),
                  taskSearchInputField(),
                  customSpacerHeight(height: 12),

                  Obx(() => Get.find<TimelineController>().isLoading.isTrue
                      ? const Center(
                          child: CupertinoActivityIndicator(),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: Get.find<TimelineController>()
                                    .projectDropDownResponse
                                    ?.getProjectsDropdown
                                    ?.length ??
                                0,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return _projectListLayout(index,context);
                            },
                          ),
                        )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _projectListLayout(int index,context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Get.find<TimelineController>()
                  .projectDropDownResponse
                  ?.getProjectsDropdown?[index]
                  .name !=
              null
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Icon(
                    Icons.circle,
                    size: 13,
                    color: Get.find<TimelineController>()
                                .projectDropDownResponse
                                ?.getProjectsDropdown?[index]
                                .color !=
                            null
                        ? HexColor(Get.find<TimelineController>()
                                .projectDropDownResponse
                                ?.getProjectsDropdown?[index]
                                .color ??
                            "")
                        : Colors.black87,
                  ),
                ),
                customSpacerWidth(width: 6),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Get.find<TimelineController>()
                              .projectDropDownResponse
                              ?.getProjectsDropdown?[index]
                              .name ??
                          "",
                      style: AppStyle.mid_large_text.copyWith(
                          fontSize: Dimensions.fontSizeMid - 3,
                          color: AppColor.normalTextColor),
                    ),
                    customSpacerHeight(height: 8),
                    Column(
                      children: [
                        ...?Get.find<TimelineController>()
                            .projectDropDownResponse
                            ?.getProjectsDropdown?[index]
                            .tasks
                            ?.map((Tasks task) => _taskLayout(task,context))
                            .toList(growable: true),
                      ],
                    ),
                  ],
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...?Get.find<TimelineController>()
                    .projectDropDownResponse
                    ?.getProjectsDropdown?[index]
                    .tasks
                    ?.map((Tasks tasks) => _taskLayout(tasks,context))
                    .toList(growable: true),
              ],
            ),
    );
  }

  Widget _taskLayout(Tasks task,context) {
    return InkWell(
      onTap: () {
        taskSearchController.text = task.name ?? "";
        Get.find<TimelineController>().taskName.value = task.name ?? "";
        Get.find<TimelineController>().taskId.value = task.taskId ?? "";
        Navigator.pop(context);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(task.name ?? "", overflow: TextOverflow.ellipsis),
          customSpacerHeight(height: 8),
        ],
      ),
    );
  }
}

Widget taskSearchInputField() {
  return SizedBox(
    height: AppLayout.getHeight(55),
    child: TextFormField(
      controller: taskSearchController,
      style: subTextFieldTitleStyle,
      autofocus: true,
      onChanged: (value) {
        Get.find<TimelineController>().getProjectDropdown();
      },
      decoration: InputDecoration(
        hintText: AppString.text_select_option.tr,
        suffixIcon: GestureDetector(
          onTap: () {
            taskSearchController.clear();
          },
          child: taskSearchController.text.isNotEmpty
              ? const Icon(
                  Icons.close,
                  size: 30,
                  color: AppColor.hintColor,
                )
              : const Icon(CupertinoIcons.search),
        ),
        hintStyle: TextStyle(
            color: AppColor.hintColor,
            fontFamily: "Poppins",
            fontSize: Dimensions.fontSizeDefault + 1),
        border: OutlineInputBorder(
          borderSide:
              const BorderSide(width: 0.0, color: AppColor.primaryColor),
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault + 2),
        ),
        focusColor: AppColor.primaryColor,
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColor.hintColor,
            ),
            borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor.hintColor),
            borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
      ),
    ),
  );
}

class HexColor extends Color {
  static int _getColor(String hex) {
    String formattedHex = "FF${hex.toUpperCase().replaceAll("#", "")}";
    return int.parse(formattedHex, radix: 16);
  }

  HexColor(final String hex) : super(_getColor(hex));
}
