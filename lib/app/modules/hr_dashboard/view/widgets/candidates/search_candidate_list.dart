import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/modules/hr_dashboard/controllers/hr_deshboard_controller.dart';
import 'package:payrun_mobile/app/modules/hr_dashboard/models/candidate_list.dart';
import '../../../../../../../common/widget/custom_search_field.dart';
import '../../../../../../../common/widget/custom_spacer.dart';
import '../../../../../../../common/widget/custom_text_field.dart';
import '../../../../../../../utils/app_color.dart';
import '../../../../../../../utils/app_string.dart';
import '../../../../../../../utils/app_style.dart';
import '../../../../../../../utils/dimensions.dart';
import '../../../../../../common/widget/custom_button_sheet_appbar.dart';
import '../../../../../../common/widget/hr_deshboard/custom_network_img.dart';
import '../../../../../../utils/utils.dart';


class SearchCandidateList extends StatelessWidget {
  final Function(UserInfo)? userInfo;
  final Function onClickRouteAction;

  const SearchCandidateList(
      {Key? key,
        required this.onClickRouteAction,
        this.userInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildBottomSheetHeader(text: AppString.textEmployees.tr),
        customSpacerHeight(height: 20),

        /// Search candidate input field
        _buildSearchField(),

        customSpacerHeight(height: 8),

        Obx(() {
          return  Get.find<HrDashBoardController>().isCandidateBySearchLoading.isTrue
              ? const Center(
            child: CupertinoActivityIndicator(
              color: AppColor.primaryColor,
              radius: 14,
            ),
          )
              : ListView.builder(
            shrinkWrap: true,
            itemCount: Get.find<HrDashBoardController>()
                .candidateList?.getCandidates?.data
                ?.length ??
                0,
            itemBuilder: (context, index) {
              Data? data = Get.find<HrDashBoardController>()
                  .candidateList?.getCandidates?.data?[index];

            return GestureDetector(
              onTap: () {
                 userInfo?.call(UserInfo("${data?.candidate?.firstName ?? ""} ${data?.candidate?.lastName ?? ""}", data?.candidate?.avatarKey ?? ""));
                 onClickRouteAction.call();
              },
              child: _buildCandidateInfo(
                  name:
                  "${data?.candidate?.firstName ?? ""} ${data?.candidate?.lastName ?? ""}",
                  role: data?.job?.department?.name ?? "",
                  imgUrl: data?.candidate?.avatarKey??""),
            );
            },
          );
        }),
      ],
    );
  }

  void _onSearchValueChanged(String value) {
   // _clearSearchField();
    final controller = Get.find<HrDashBoardController>();
    controller.candidateSearchController.text = value;
  }

  // Widget _buildRecentlySearchedEmployeeSection() => _buildEmployeeList();

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: CustomSearchField(
        onSearchChanged: (value) async {
          _onSearchValueChanged(value);
          if (value.isNotEmpty) {
            await Get.find<HrDashBoardController>().getCandidateBySearch(searchKey: value);
          }
        },
        searchController: Get.find<HrDashBoardController>().candidateSearchController,
        searchHintText: AppString.textSearchAndSelect.tr,
      ),
    );
  }


  Widget _buildCandidateInfo({
    required String name,
    required String role,
    required String imgUrl,
  }) {
    return Padding(
      padding:
      const EdgeInsets.only(left: 20.0, right: 20, top: 14, bottom: 16),
      child: Row(
        children: [
          CustomNetworkImage(
            imageUrl: buildImgIxUrl(imgKey: imgUrl),
            isCircleImage: true,
            errorText: getInitials(name),
            radius: 22,
          ),
          customSpacerWidth(width: 14),
          Expanded(child: _buildCandidateDetails(name, role)),
        ],
      ),
    );
  }

  Widget _buildCandidateDetails(String name, String role) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: AppStyle.mid_large_text.copyWith(
            color: AppColor.secondaryColor,
            fontWeight: FontWeight.w600,
            fontSize: Dimensions.fontSizeDefault + 2,
          ),
        ),
        Text(
          role,
          style: subTextFieldTitleStyle.copyWith(
            color: AppColor.hintColor,
          ),
        ),
      ],
    );
  }

  // Widget _buildEmployeeList() {
  //   return ValueListenableBuilder(
  //     valueListenable: Hive.box('dataBox').listenable(),
  //     builder: (BuildContext context, Box value, Widget? child) {
  //       List dataList = value.values.toList();
  //       return ListView.builder(
  //         shrinkWrap: true,
  //         padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //         physics: const NeverScrollableScrollPhysics(),
  //         itemCount: dataList.length,
  //         // Adjust based on your data
  //         itemBuilder: (context, index) {
  //           return _buildEmployeeListItem(dataList[index]);
  //         },
  //       );
  //     },
  //   );
  // }



// Widget _buildOwnInfo({
//   required String name,
//   required String role,
//   required String imgUrl,
// }) {
//   return Padding(
//     padding:
//     const EdgeInsets.only(left: 20.0, right: 20, top: 14, bottom: 16),
//     child: Row(
//       children: [
//         CustomNetworkImage(
//           imgUrlKey: "", // Replace with actual image URL key
//           profileImageKey: imgUrl,
//           errorText: 'ER',
//           height: 22,
//         ),
//         customSpacerWidth(width: 14),
//         Expanded(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               _buildEmployeeDetails(name, role),
//               const Text("(${AppString.textYou})")
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }


// Widget _buildEmployeeListItem(List employeeData) {
//     return GestureDetector(
//       onTap: () {
//         // onValueSelected?.call(employeeData.id ?? "");
//         // userInfo?.call(UserInfo("${employeeData.profile?.firstName ?? ""} ${employeeData.profile?.lastName ?? ""}", employeeData.profile?.image ?? ""));
//         // onClickRouteAction.call();
//       },
//       child: Padding(
//         padding:
//         const EdgeInsets.only(left: 16.0, right: 20, top: 14, bottom: 8),
//         child: Row(
//           children: [
//              CustomNetworkImage(
//               imageUrl: buildImgIxUrl(imgKey: ),
//               isCircleImage: true,
//               errorText: getInitials(name),
//               height: 22,
//             ),
//
//             customSpacerWidth(width: 14),
//             Expanded(
//               child: _buildEmployeeDetails(
//                   "${employeeData.profile?.firstName ?? ""} ${employeeData.profile?.lastName ?? ""}",
//                   employeeData.department?.name ?? ""),
//             ),
//             IconButton(
//               onPressed: () {
//                 Get.find<EmploymentController>()
//                     .removeRecentSearchData(employeeData.id ?? "");
//               },
//               icon: const Icon(
//                 Icons.close,
//                 color: AppColor.hintColor,
//                 size: 26,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }








  //
  // Widget _buildRecentSearchTitleSection() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Text(
  //           AppString.textRecentSearch.tr,
  //           style: AppStyle.normal_text_black.copyWith(
  //             color: AppColor.normalTextColor,
  //             fontSize: Dimensions.fontSizeMid - 1,
  //             fontWeight: FontWeight.w600,
  //           ),
  //         ),
  //         ValueListenableBuilder(
  //           valueListenable: Hive.box('dataBox').listenable(),
  //           builder: (BuildContext context, Box value, child) {
  //             final dataList = value.values.toList();
  //
  //             return dataList.isNotEmpty
  //                 ? InkWell(
  //               onTap: () {
  //                 Get.find<EmploymentController>()
  //                     .clearAllRecentSearchData();
  //               },
  //               child: Text(
  //                 AppString.textClearAll.tr,
  //                 style: AppStyle.normal_text_black.copyWith(
  //                   color: AppColor.secondaryColor,
  //                   fontSize: Dimensions.fontSizeDefault,
  //                 ),
  //               ),
  //             )
  //                 : Container();
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // void _clearSearchField() {
  //   final controller = Get.find<EmploymentController>();
  //   controller.searchController.clear();
  //   controller.searchQuery.value = "";
  // }
}

class UserInfo {
  String? name;
  String? imgUrl;
  UserInfo(this.name, this.imgUrl);
}
