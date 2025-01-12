import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payrun_mobile/app/modules/employee/presentation/view/widget/serach_employee_list/search_employee_list.dart';
import '../../../../../../../utils/app_color.dart';
import '../../../../../../../utils/app_style.dart';
import '../../../../../../../utils/dimensions.dart';
import '../../../../common/widget/custom_card_style.dart';
import '../../../../common/widget/custom_network_image.dart';
import '../../../../common/widget/custom_spacer.dart';
import '../../../common/widget/custom_buttom_sheet.dart';




class TabBarWidget extends StatefulWidget {
  final List<TabItem> tabs;
  final ValueChanged<int> onTabSelect;

  const TabBarWidget({super.key, required this.tabs, required this.onTabSelect});

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> {
  int selectedTabIndex = 0;

  void _onTabSelect(int index) {
    setState(() {
      selectedTabIndex = index;
    });
    widget.onTabSelect(index); // Call the callback to return the selected index
  }

  @override
  Widget build(BuildContext context) {


    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SizedBox(
            height: 40,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(widget.tabs.length, (index) {
                  return GestureDetector(
                    onTap: () => _onTabSelect(index),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2.3,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0.0, right: 0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: selectedTabIndex == index
                                ? AppColor.primaryColor
                                : AppColor.leaveRecordCardColor,
                          ),
                          child: Center(
                            child: Text(
                              widget.tabs[index].label,
                              style: AppStyle.normal_text.copyWith(
                                fontSize: Dimensions.fontSizeDefault + 1,
                                color: selectedTabIndex == index
                                    ? AppColor.cardColor
                                    : AppColor.normalTextColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),



        const SizedBox(height: 18),
         const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: SizedBox(height: 50, child: CustomSearchBar()),
        ),
        const SizedBox(height: 8),

        // Display the body of the selected tab
        Expanded(child: widget.tabs[selectedTabIndex].body),
      ],
    );
  }
}

class TabItem {
  final String label;
  final Widget body;
  TabItem({ required this.label, required this.body});
}

class CustomSearchBar extends StatelessWidget {
  final Function(String)? onValueSelected;
  final Function(UserInfo)? userInfo;
  final Function? onClickRouteAction;

  const CustomSearchBar(
      {Key? key,
        this.onValueSelected,
         this.onClickRouteAction,
        this.userInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        customButtonSheet(
          context: context,
          child: SearchEmployeeList(
            onValueSelected:onValueSelected?? (value) {},
            userInfo: userInfo??(name) {},
            onClickRouteAction:onClickRouteAction?? () {},
          ),
          height: 0.8,
        );
      },
      child: SizedBox(
        height: 52,
        width: MediaQuery.of(context).size.width,
        child: Card(
          elevation: 0,
          color: AppColor.cardColor,
          shape: roundedRectangleBorder.copyWith(
            side: BorderSide(
              color: AppColor.hintColor.withOpacity(0.3),
              width: 1.3,
            ),
            borderRadius: BorderRadius.circular(Dimensions.fontSizeMid + 2),
          ),
          child: Row(
            children: [
              customSpacerWidth(width: 12),
              const Icon(CupertinoIcons.search,
                  color: AppColor.hintColor, size: 25),
              customSpacerWidth(width: 8),
              CustomNetworkImage(
                imgUrlKey: "",
                errorText: "er",
                height: 12,
                borderColor: Colors.transparent,
                errorTextStyle: AppStyle.normal_text_black
                    .copyWith(fontSize: 14, color: AppColor.secondaryColor),
              ),
              customSpacerWidth(width: 6),
              // Employee name display or a default message
              Expanded(
                  child: Text(
                "Search employee",
                style:
                    AppStyle.normal_text.copyWith(color: AppColor.hintColor),
              )),
              // Clear icon
              InkWell(
                onTap: () {},
                child: const Icon(CupertinoIcons.clear,
                    color: AppColor.hintColor, size: 23),
              ),
              customSpacerWidth(width: 12),
            ],
          ),
        ),
      ),
    );
  }
}
