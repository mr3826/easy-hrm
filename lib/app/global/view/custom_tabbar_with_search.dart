import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payrun_mobile/common/widget/hr_timeline/custom_network_image.dart';
import '../../../../../../../utils/app_color.dart';
import '../../../../../../../utils/app_style.dart';
import '../../../../../../../utils/dimensions.dart';
import '../../../../common/widget/custom_card_style.dart';
import '../../../../common/widget/custom_spacer.dart';
import '../../../common/widget/custom_buttom_sheet.dart';
import '../../../utils/utils.dart';
import '../../modules/employee/view/widget/serach_employee_list/search_employee_list.dart';

class TabBarWidget extends StatefulWidget {
  final List<TabItem> tabs;
  final ValueChanged<int> onTabSelect;

  const TabBarWidget(
      {super.key, required this.tabs, required this.onTabSelect});

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

class CustomSearchBar extends StatefulWidget {
  final Function(String)? onValueSelected;
  final Function(UserInfo)? userInfo;
  final Function? onClickRouteAction;
  final Function? onClearAction;
  final String? employeeName;
  final String? employeeImage;
 final TextEditingController? searchTextController;

  const CustomSearchBar({
    Key? key,
    this.onValueSelected,
    this.employeeName,
    this.userInfo,
    this.searchTextController,
    this.onClickRouteAction,
    this.employeeImage,
    this.onClearAction,
  }) : super(key: key);

  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController searchController =
      TextEditingController(text: "Search employee");
  String profileImgKey = "";

  @override
  Widget build(BuildContext context) {
    print("employee ${widget.employeeName}");
    return GestureDetector(
      onTap: () => _showSearchBottomSheet(),
      child: SizedBox(
        height: 52,
        width: MediaQuery.of(context).size.width,
        child: Card(
          elevation: 0,
          color: AppColor.cardColor,
          shape: _buildCardShape(),
          child: Row(
            children: [
              customSpacerWidth(width: 12),
              const Icon(CupertinoIcons.search,
                  color: AppColor.hintColor, size: 25),
              customSpacerWidth(width: 8),
              if (profileImgKey.isNotEmpty)
                CircularNetworkImage(
                  imageUrl:
                      buildImgIxUrl(imagePath: profileImgKey, isPublic: true),
                  errorText: getInitials(searchController.text),
                  radius: 12,
                  borderColor: Colors.transparent,
                ),
              customSpacerWidth(width: 6),
              Expanded(
                child: Text(
                  widget.employeeName?? searchController.text,
                  style: AppStyle.normal_text.copyWith(
                      color: AppColor.normalTextColor.withOpacity(0.7)),
                ),
              ),
              InkWell(
                onTap: () => setState(() {
                  widget.onClearAction!();
                  profileImgKey = "";
                  searchController.text = "Search employee";
                }),
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

  void _showSearchBottomSheet() {
    customButtonSheet(
      context: context,
      height: 0.8,
      child: SearchEmployeeList(
        onValueSelected: widget.onValueSelected,
        userInfo: widget.userInfo ??
            (name) {
              setState(() {
                searchController.text = name.name ?? "";
                profileImgKey = name.imgUrl ?? "";
              });
            },
        onClickRouteAction: widget.onClickRouteAction ?? () {},
      ),
    );
  }

  RoundedRectangleBorder _buildCardShape() {
    return roundedRectangleBorder.copyWith(
      side: BorderSide(
        color: AppColor.hintColor.withOpacity(0.3),
        width: 1.3,
      ),
      borderRadius: BorderRadius.circular(Dimensions.fontSizeMid + 2),
    );
  }
}




class TabItem {
  final String label;
  final Widget body;
  TabItem({required this.label, required this.body});
}
