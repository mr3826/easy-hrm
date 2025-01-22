import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../model/org_user_info.dart';
import '../repository/employee_data_sourse.dart';

class UpdateOrgUserInfoController extends GetxController with StateMixin {
  final EmployeeDataSource _employeeDataSource;

  UpdateOrgUserInfoController({required EmployeeDataSource employeeDataSource})
      : _employeeDataSource = employeeDataSource;

  RxBool isUpdateDataChanged = false.obs;
  RxBool isUpdateDataLoading = false.obs;

  late GetOrganizationUserDetails getOrganizationUserDetails;
  late TextEditingController editFirstNameController;
  late TextEditingController editLastNameController;
  late TextEditingController editEmployeeIdController;
  String employeeStatusId = '';
  String employeeDesignationId = '';
  String employeeDepartmentId = '';
  RxString employeeJoiningDate = ''.obs;
  PhoneNumber employeePersonalPhoneNumber = PhoneNumber();
  String changedPersonalNumber = '';
  PhoneNumber employeeEmergencyPhoneNumber = PhoneNumber();
  String changedEmergencyNumber = '';

  @override
  void onInit() {
    editFirstNameController = TextEditingController();
    editLastNameController = TextEditingController();
    editEmployeeIdController = TextEditingController();
    editFirstNameController.addListener(checkForChanges);
    editLastNameController.addListener(checkForChanges);
    editEmployeeIdController.addListener(checkForChanges);
    super.onInit();
  }

  Future<void> getUpdateAbleUserInfo({required String orgUserId}) async {
    change(null, status: RxStatus.loading());
    getOrganizationUserDetails =
        await _employeeDataSource.getUpdateAbleUserInfo(orgUserId: orgUserId);
    await _assigningInitValue(getOrganizationUserDetails);
    change(null, status: RxStatus.success());
  }

  Future<bool> updateAOrgUserInfo({required String orgUserId}) async {
    isUpdateDataLoading(true);

    Map<String, Map<String, dynamic>> input = {
      "inputData": {"org_user_id": orgUserId}
    };

    if (editFirstNameController.text !=
        getOrganizationUserDetails.profile.firstName) {
      input['inputData']?['first_name'] = editFirstNameController.text;
    }
    if (editLastNameController.text !=
        getOrganizationUserDetails.profile.lastName) {
      input['inputData']?['last_name'] = editLastNameController.text;
    }
    if (editEmployeeIdController.text !=
        getOrganizationUserDetails.employeeId) {
      input['inputData']?['employee_id'] = editEmployeeIdController.text;
    }
    if (employeeStatusId.isNotEmpty) {
      input['inputData']?['employment_status_id'] = employeeStatusId;
    }
    if (employeeDesignationId.isNotEmpty) {
      input['inputData']?['designation_id'] = employeeDesignationId;
    }
    if (employeeDepartmentId.isNotEmpty) {
      input['inputData']?['department_id'] = employeeDepartmentId;
    }
    if (getOrganizationUserDetails.joinDate.isEmpty &&
            employeeJoiningDate.isNotEmpty ||
        getOrganizationUserDetails.joinDate.isNotEmpty &&
            employeeJoiningDate.isNotEmpty &&
            !employeeJoiningDate.value.substring(0, 10).contains(
                getOrganizationUserDetails.joinDate.substring(0, 10))) {
      input['inputData']?['join_date'] = employeeJoiningDate.value;
    }
    if (changedPersonalNumber.isNotEmpty) {
      input['inputData']?['personal_phone_number'] = changedPersonalNumber;
    }
    if (changedEmergencyNumber.isNotEmpty) {
      input['inputData']?['emergency_phone_number'] = changedEmergencyNumber;
    }

    input.forEach(
      (key, value) => print('key: $key value: $value'),
    );

    bool response = await _employeeDataSource.updateOrgUserInfo(input: input);
    isUpdateDataLoading(false);
    return response;
  }

  void checkForChanges() {
    isUpdateDataChanged.value = editFirstNameController.text !=
            getOrganizationUserDetails.profile.firstName ||
        editLastNameController.text !=
            getOrganizationUserDetails.profile.lastName ||
        editEmployeeIdController.text !=
            getOrganizationUserDetails.employeeId ||
        employeeStatusId.isNotEmpty ||
        employeeDesignationId.isNotEmpty ||
        employeeDepartmentId.isNotEmpty ||
        !changedPersonalNumber
            .contains(employeePersonalPhoneNumber.phoneNumber ?? '') ||
        !changedEmergencyNumber
            .contains(employeeEmergencyPhoneNumber.phoneNumber ?? "") ||
        (getOrganizationUserDetails.joinDate.isEmpty &&
                employeeJoiningDate.isNotEmpty ||
            getOrganizationUserDetails.joinDate.isNotEmpty &&
                employeeJoiningDate.isNotEmpty &&
                !employeeJoiningDate.value.substring(0, 10).contains(
                    getOrganizationUserDetails.joinDate.substring(0, 10)));
  }

  Future<PhoneNumber> _getPhone(String numberString) async {
    PhoneNumber phoneNumber =
        await PhoneNumber.getRegionInfoFromPhoneNumber(numberString);
    return phoneNumber;
  }

  @override
  void onClose() {
    editFirstNameController.dispose();
    editLastNameController.dispose();
    editEmployeeIdController.dispose();
    super.onClose();
  }

  _assigningInitValue(
      GetOrganizationUserDetails getOrganizationUserDetails) async {
    editFirstNameController.text = getOrganizationUserDetails.profile.firstName;
    editLastNameController.text = getOrganizationUserDetails.profile.lastName;
    editEmployeeIdController.text = getOrganizationUserDetails.employeeId;
    employeeJoiningDate.value = getOrganizationUserDetails.joinDate;
    if (getOrganizationUserDetails.profile.personalNumber.isNotEmpty) {
      await _getPhone(getOrganizationUserDetails.profile.personalNumber)
          .then((value) {
        employeePersonalPhoneNumber = value;
      });
    }
    if (getOrganizationUserDetails.profile.emergencyNumber.isNotEmpty) {
      await _getPhone(getOrganizationUserDetails.profile.emergencyNumber)
          .then((value) {
        employeeEmergencyPhoneNumber = value;
      });
    }
  }
}
