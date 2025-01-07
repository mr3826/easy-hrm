import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../../utils/app_color.dart';
import '../../../../../../../utils/app_style.dart';
import '../../../../../../../utils/dimensions.dart';
import '../../../controller/leave_controller.dart';

class BuildTabBar extends StatelessWidget {
  const BuildTabBar({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LeaveController());
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: SizedBox(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: controller.tabList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Obx(() => GestureDetector(
                  onTap: () => _updatedTabIndex(controller, index),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2.2,
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      color: controller.tabLength.value == index
                          ? AppColor.primaryColor
                          : AppColor.hintColor.withOpacity(0.1),
                      child: Center(
                        child: Text(
                          controller.tabList[index],
                          style: AppStyle.normal_text.copyWith(
                            fontSize: Dimensions.fontSizeDefault,
                            color: controller.tabLength.value == index
                                ? AppColor.cardColor
                                : AppColor.normalTextColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ));
          },
        ),
      ),
    );
  }
}

_updatedTabIndex(LeaveController controller, index) {
  controller.tabLength.value = index;
  controller.currentDate.value = "This month";
}
