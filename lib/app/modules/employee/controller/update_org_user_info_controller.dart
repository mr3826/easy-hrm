import 'package:get/get.dart';
import 'package:payrun_mobile/modules/profile/model/user_profile.dart';

import '../repository/employee_data_sourse.dart';

class UpdateOrgUserInfoController {
  final EmployeeDataSource _employeeDataSource;
  RxBool isInfoDataLoading = false.obs;
  RxBool isUpdateDataChanged = false.obs;

  late GetOrganizationUserDetails getOrganizationUserDetails;

  UpdateOrgUserInfoController({required EmployeeDataSource employeeDataSource})
      : _employeeDataSource = employeeDataSource;

  Future<void> getUpdateAbleUserInfo({required String orgUserId}) async {
    isInfoDataLoading(true);
    getOrganizationUserDetails =
        await _employeeDataSource.getUpdateAbleUserInfo(orgUserId: orgUserId);
    isInfoDataLoading(false);
  }

  void checkForChanges() {
    isUpdateDataChanged.value =
        editFirstNameController.text != getOrganizationUserDetails.profile?.firstName;
  }

}
