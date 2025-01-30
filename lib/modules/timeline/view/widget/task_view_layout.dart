import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/controllers/employee_timeline_controller.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/controllers/hr_timeline_controller.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_text_field.dart';
import 'package:payrun_mobile/app/modules/auth/view/screens/otp_screen.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/models/project_dropdown_response.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/utils.dart';
import '../../../../app/modules/hr_timeline/controllers/global_timline_controller.dart';
import '../../../leave/presentation/view/widget/custom_title_text_widget.dart';

class TaskViewLayout extends StatelessWidget {
  final bool isEmployee;
  const TaskViewLayout({super.key, required this.isEmployee});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: marginLayout.copyWith(top: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [customTitleText(text: AppString.text_project_task.tr, isRequired: true),
              customSpacerHeight(height: 8),
              const TaskSearchInputField(),

              customSpacerHeight(height: 12),
              Obx(() {
                if (isEmployee == true) {
                  return _buildEmployeeTaskList();
                } else {
                  return _buildAdminTaskList();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmployeeTaskList() {
    if (Get.find<TimelineGlobalController>().isProjectListLoading.isTrue) {
      return const Center(child: CupertinoActivityIndicator());
    }

    final projectDropDownResponse = Get.find<TimelineGlobalController>().projectDropDownResponse;

    if (projectDropDownResponse?.getProjectsDropdown?.isEmpty ?? true) {
      return Center(
        child: Text(
          AppString.text_no_data_found.tr,
          style: AppStyle.normal_text_black
              .copyWith(color: AppColor.normalTextColor.withOpacity(0.4)),
        ),
      );
    }

    return ListView.builder(
      itemCount: projectDropDownResponse?.getProjectsDropdown?.length ?? 0,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {

        GetProjectsDropdown? data = projectDropDownResponse?.getProjectsDropdown?[index];

        return _projectListLayout(context, data ?? GetProjectsDropdown(),(){
          /// when it select project
          /// then it became task name that shown in ui
          /// pass its name to task name

          if (Get.find<EmployeeTimelineController>().projectId.value != data?.projectId) {
            Get.find<EmployeeTimelineController>().isValueChangeForTimeLogUpdate(true);
          }


          Get.find<EmployeeTimelineController>().taskName.value = data?.name ?? "";


          Get.find<EmployeeTimelineController>().projectId.value = data?.projectId ?? "";

          Get.find<EmployeeTimelineController>().projectColor.value = data?.color ?? "";

          Get.find<EmployeeTimelineController>().taskId.value = "";

          taskSearchController.clear();

          Navigator.pop(context);


        });
      },
    );
  }

  Widget _buildAdminTaskList() {
    print("_buildAdminTaskList_called");
    if (Get.find<TimelineGlobalController>().isProjectListLoading.isTrue) {
      return const Center(child: CupertinoActivityIndicator());
    }

    final projectDropDownResponse = Get.find<TimelineGlobalController>().projectDropDownResponse;

    if (projectDropDownResponse?.getProjectsDropdown?.isEmpty ?? true) {
      return Center(
        child: Text(
          AppString.text_no_data_found.tr,
          style: AppStyle.normal_text_black
              .copyWith(color: AppColor.normalTextColor.withOpacity(0.4)),
        ),
      );
    }

    return ListView.builder(
      itemCount: projectDropDownResponse?.getProjectsDropdown?.length ?? 0,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        GetProjectsDropdown? data =
            projectDropDownResponse?.getProjectsDropdown?[index];
        return _projectListLayout(context, data ?? GetProjectsDropdown(),(){
          /// when it select project
          /// then it became task name that shown in ui
          /// pass its name to task name

          if (Get.find<TimelineGlobalController>().projectId.value != data?.projectId) {
            Get.find<TimelineGlobalController>()
                .isValueChangeForTimeLogUpdate(true);
          }


          Get.find<TimelineGlobalController>().taskName.value = data?.name ?? "";
          Get.find<TimelineGlobalController>().projectId.value = data?.projectId ?? "";
          Get.find<TimelineGlobalController>().projectColor.value = data?.color ?? "";
          Get.find<TimelineGlobalController>().taskId.value = "";
          taskSearchController.clear();
          print(''''
          
          task_newma: ${ Get.find<TimelineGlobalController>().taskName.value}
          projectId: ${ Get.find<TimelineGlobalController>().projectId.value}
          projectColor: ${ Get.find<TimelineGlobalController>().projectColor.value}
          
          ''');
          Navigator.pop(context);
        });
      },
    );
  }
}

_projectListLayout(BuildContext context, GetProjectsDropdown data, Function onSelect) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: data.name != null
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Icon(
                  Icons.circle,
                  size: 13,
                  color: data.color != null
                      ? HexColor(data.color ?? "")
                      : Colors.black87,
                ),
              ),
              customSpacerWidth(width: 6),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () => onSelect(),
                      child: Text(
                        data.name ?? "",
                        style: AppStyle.mid_large_text.copyWith(
                            fontSize: Dimensions.fontSizeMid - 3,
                            color: AppColor.normalTextColor),
                      ),
                    ),
                    customSpacerHeight(height: 8),
                    Column(
                      children: [
                        ...?data.tasks
                            ?.map((Tasks task) => _taskLayout(task, context))
                            .toList(growable: true),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...?data.tasks
                  ?.map((Tasks tasks) => _taskLayout(tasks, context))
                  .toList(growable: true),
            ],
          ),
  );
}

Widget _taskLayout(Tasks task, context) {

  TimelineGlobalController controller=Get.find<TimelineGlobalController>();
  return InkWell(
    onTap: () {
      if(controller.isEmployee.isTrue){
        if (Get.find<EmployeeTimelineController>().taskId.value != task.taskId) {
          Get.find<EmployeeTimelineController>().isValueChangeForTimeLogUpdate(true);
        }
        taskSearchController.text = task.name ?? "";
        Get.find<EmployeeTimelineController>().taskName.value = task.name ?? "";
        Get.find<EmployeeTimelineController>().taskId.value = task.taskId ?? "";
        Get.find<EmployeeTimelineController>().projectId.value = "";
        Get.find<EmployeeTimelineController>().projectColor.value = "";
        Navigator.pop(context);
        taskSearchController.clear();
      }else{
        if (Get.find<TimelineGlobalController>().taskId.value != task.taskId) {
          Get.find<TimelineGlobalController>().isValueChangeForTimeLogUpdate(true);
        }
        taskSearchController.text = task.name ?? "";
        Get.find<TimelineGlobalController>().taskName.value = task.name ?? "";
        Get.find<TimelineGlobalController>().taskId.value = task.taskId ?? "";
        Get.find<TimelineGlobalController>().projectId.value = "";
        Get.find<TimelineGlobalController>().projectColor.value = "";
        Navigator.pop(context);
        taskSearchController.clear();
      }

    },
    child: Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Wrap(
        children: [
          Text(task.name ?? ''),
        ],
      ),
    ),
  );
}

class TaskSearchInputField extends StatefulWidget {
  const TaskSearchInputField({super.key});

  @override
  State<TaskSearchInputField> createState() => _TaskSearchInputFieldState();
}

class _TaskSearchInputFieldState extends State<TaskSearchInputField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppLayout.getHeight(55),
      width: double.infinity,
      child: TextFormField(
        controller: taskSearchController,
        style: subTextFieldTitleStyle,
        onChanged: (value) {
          setState(() {});
          Get.find<TimelineGlobalController>().getProjectList(searchText: value);
        },
        decoration: InputDecoration(
          hintText: AppString.text_select_option.tr,
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {});
              taskSearchController.clear();
              Get.find<TimelineGlobalController>().getProjectList();
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
}

class HexColor extends Color {
  static int _getColor(String hex) {
    if (hex.isEmpty) return int.parse("FF8F99AD", radix: 16);
    String formattedHex = "FF${hex.toUpperCase().replaceAll("#", "")}";
    return int.parse(formattedHex, radix: 16);
  }

  HexColor(final String hex) : super(_getColor(hex));
}
