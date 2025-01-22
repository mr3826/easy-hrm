import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/global/view/widget/app_margin.dart';
import 'package:payrun_mobile/app/modules/hr_dashboard/controllers/hr_deshboard_controller.dart';
import 'package:payrun_mobile/app/modules/hr_dashboard/models/candidate_list.dart' as can_list;
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

class SearchCandidateList extends GetView<HrDashBoardController> {
  final Function(UserInfo)? onUserSelected;
  final Function onRouteAction;

  const SearchCandidateList({
    Key? key,
    required this.onRouteAction,
    this.onUserSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBottomSheetHeader(),
        customSpacerHeight(height: 20),
        _buildSearchInputField(),
        customSpacerHeight(height: 8),
        Obx(() => _buildCandidateListView()),
      ],
    );
  }

  /// Builds the header for the bottom sheet
  Widget _buildBottomSheetHeader() {
    return buildBottomSheetHeader(text: AppString.text_candidate.tr);
  }

  /// Builds the search input field
  Widget _buildSearchInputField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: CustomSearchField(
        onSearchChanged: (value) async {
          _handleSearchValueChange(value);
          if (value.isNotEmpty) {
            await controller.getCandidateBySearch(searchKey: value);
            controller.searchQuery.value = "";
          }
        },
        searchController: controller.candidateSearchController,
        searchHintText: AppString.textSearchAndSelect.tr,
      ),
    );
  }

  /// Handles search input changes
  void _handleSearchValueChange(String value) {
    controller.candidateSearchController.text = value;
    controller.searchQuery.value = value;
  }

  /// Builds the candidate list view based on search results or recent searches
  Widget _buildCandidateListView() {
    if (controller.searchQuery.isEmpty) {
      if (controller.candidates.isNotEmpty) {
        return _buildRecentSearchList();
      }
    }

    return controller.isCandidateBySearchLoading.isTrue
        ? const Center(
            child: CupertinoActivityIndicator(
            color: AppColor.primaryColor,
          ))
        : _buildSearchResultList();
  }

  /// Builds the list of recent searches
  Widget _buildRecentSearchList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: marginLayout.copyWith(top: 12),
          child: Text(
            AppString.textRecentSearch.tr,
            style: AppStyle.normal_text_black.copyWith(
              color: AppColor.normalTextColor,
              fontSize: Dimensions.fontSizeMid - 1,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        ListView.builder(
          itemCount: controller.candidates.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final candidate = controller.candidates[index];
            return GestureDetector(
              onTap: () => _handleCandidateSelection(
                name: "${candidate.firstName} ${candidate.lastName}",
                imgUrl: candidate.avatarKey,
              ),
              child: _buildCandidateTile(
                name: "${candidate.firstName} ${candidate.lastName}",
                role: candidate.department ?? "",
                imgUrl: candidate.avatarKey ?? "",
              ),
            );
          },
        ),
      ],
    );
  }

  /// Builds the list of search results
  Widget _buildSearchResultList() {
    final candidates = controller.candidateList?.getCandidates?.data ?? [];
    return ListView.builder(
      shrinkWrap: true,
      itemCount: candidates.length,
      itemBuilder: (context, index) {
        final data = candidates[index];
        final candidate = data.candidate;

        return GestureDetector(
          onTap: () {
            _handleCandidateSelection(
              name:
                  "${candidate?.firstName ?? ""} ${candidate?.lastName ?? ""}",
              imgUrl: candidate?.avatarKey,
            );
            controller.addItem(can_list.SearchCandidate.name(
              id: candidate?.id ?? "",
              firstName: candidate?.firstName ?? "",
              lastName: candidate?.lastName ?? "",
              department: data.job?.department?.name ?? "",
              avatarKey: candidate?.avatarKey ?? "",
            ));
          },
          child: _buildCandidateTile(
            name: "${candidate?.firstName ?? ""} ${candidate?.lastName ?? ""}",
            role: data.job?.department?.name ?? "",
            imgUrl: candidate?.avatarKey ?? "",
          ),
        );
      },
    );
  }

  /// Handles candidate selection
  void _handleCandidateSelection({required String name, String? imgUrl}) {
    onUserSelected?.call(UserInfo(name, imgUrl));
    onRouteAction.call();
  }

  /// Builds a candidate tile with name, role, and image
  Widget _buildCandidateTile({
    required String name,
    required String role,
    required String imgUrl,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14),
      child: Row(
        children: [
          CustomNetworkImage(
            imageUrl: buildImgIxUrl(imgKey: imgUrl),
            isCircleImage: true,
            errorText: getInitials(name),
            radius: 22,
          ),
          customSpacerWidth(width: 14),
          Expanded(
            child: _buildCandidateDetails(name: name, role: role),
          ),
        ],
      ),
    );
  }

  /// Builds candidate details (name and role)
  Widget _buildCandidateDetails({required String name, required String role}) {
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
}

class UserInfo {
  String? name;
  String? imgUrl;
  UserInfo(this.name, this.imgUrl);
}
