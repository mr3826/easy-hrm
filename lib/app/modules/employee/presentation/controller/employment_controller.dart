import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:payrun_mobile/modules/leave/data/remote/leave_remote_data_source.dart';
import 'package:payrun_mobile/modules/profile/model/employee_work_history.dart';
import 'package:payrun_mobile/modules/profile/model/user_log_history.dart';
import 'package:payrun_mobile/modules/profile/model/user_profile.dart';

import '../../../../../modules/leave/domain/leave_record_response.dart' as lr;
import '../../data/employee_remote_data_source.dart';
import '../../domain/employee_info.dart';
import '../../domain/user_work_info_dropdown.dart' as emp_wrk_inf;
import '../view/widget/filter/check_box.dart';

class EmploymentController extends GetxController with StateMixin {

  final EmployeeRemoteDataSource _employeeRemoteDataSource =
  Get.find<EmployeeRemoteDataSource>();
  final LeaveRemoteDataSource _employeeLeaveRemoteDataSource =
  Get.find<LeaveRemoteDataSource>();

  var selectedOption = ''.obs;

  RxBool isSearchInfoLoading = false.obs;
  RxBool isEmployeesInfoLoading = false.obs;
  RxBool isFilterInfoLoading = false.obs;
  bool isEmploymentHistoryApiCalled = false;
  bool isProfileInfoApiCalled = false;

  RxString searchQuery = ''.obs;

  TextEditingController searchController = TextEditingController();
  TextEditingController editFirstNameController = TextEditingController();
  TextEditingController editLastNameController = TextEditingController();
  TextEditingController editJoiningController = TextEditingController();

  RxInt daysCount = 0.obs;
  RxInt applicationBalanceCount = 0.obs;
  RxInt applicationMaxDaysCount = 0.obs;
  RxBool hasChangedProfileInfo = false.obs;

  ///init values
  ///check for update data
  String? initFirstName;
  String? initLastName;
  String? initEmploymentStatusId;
  String? initDesignationId;
  String? initDepartmentId;
  String? initJoiningDate;

  EmployeeInfo? employeeInfo = EmployeeInfo();
  UserDetails? employeeProfileInfo = UserDetails();
  EmployeeWorkHistory? employeeWorkHistory = EmployeeWorkHistory();
  UserLogHistory? employeesLogHistory = UserLogHistory();
  List<lr.GetLeaveRecordsForApp?> getLeaveRecordList =
      <lr.GetLeaveRecordsForApp?>[];

  List<Data>? employeeList = <Data>[];

  List<Data>? searchedEmployeeList = <Data>[];

  List<CheckBoxModel> departmentList = [];

  List<CheckBoxModel> employmentStatusList = [];

  emp_wrk_inf.DesignationList? designations;
  emp_wrk_inf.EmploymentStatusList? employmentStatuses;
  emp_wrk_inf.DepartmentList? departments;

  List<CheckBoxModel> userStatusList = [
    CheckBoxModel(checkBoxName: "Active", checkBoxNameValue: "active"),
    CheckBoxModel(checkBoxName: "Inactive", checkBoxNameValue: "inactive"),
    CheckBoxModel(checkBoxName: "Invited", checkBoxNameValue: "invited")
  ];

  List<CheckBoxModel> attendanceList = [
    CheckBoxModel(checkBoxName: "Working", checkBoxNameValue: "working"),
    CheckBoxModel(
        checkBoxName: "Not working", checkBoxNameValue: "not_working"),
    CheckBoxModel(checkBoxName: "On leave", checkBoxNameValue: "on_leave")
  ];

  ///methods
  Future<void> getEmployees() async {
    isEmployeesInfoLoading(true);

    List<String> departmentIds = getSelectedCheckBoxValues(departmentList);
    List<String> employmentStatusIds = getSelectedCheckBoxValues(employmentStatusList);
    List<String> userStatusIds = getSelectedCheckBoxValues(userStatusList);
    List<String> attendanceIds = getSelectedCheckBoxValues(attendanceList);

    Map<String, Map<String, Object>> queryMap = {
      "queryData": {
        "role": ["org_employee"]
      },
      "optionData": {"limit": 20, "offset": 0}
    };

    if (departmentIds.isNotEmpty) {
      queryMap["queryData"]?["department_id"] = departmentIds;
    }
    if (employmentStatusIds.isNotEmpty) {
      queryMap["queryData"]?["employment_status_ids"] = employmentStatusIds;
    }
    if (userStatusIds.isNotEmpty) {
      queryMap["queryData"]?["user_status"] = userStatusIds;
    }
    if (attendanceIds.isNotEmpty) {
      queryMap["queryData"]?["attendance"] = attendanceIds;
    }
    EmployeeInfo? employeeInfo =
        await _employeeRemoteDataSource.getEmployees(queryVariable: queryMap);
    employeeList = employeeInfo?.getOrganizationUsers?.data;
    update();
    isEmployeesInfoLoading(false);
  }

  Future<void> getEmployeesBySearch({required String searchQuery}) async {
    isSearchInfoLoading(true);

    Map<String, Map<String, Object>> queryMap = {
      "queryData": {
        "role": ["org_employee"],
        "search_text": searchQuery,
      },
      "optionData": {"limit": 20, "offset": 0}
    };

    final EmployeeInfo? employees =
        await _employeeRemoteDataSource.getEmployees(queryVariable: queryMap);
    searchedEmployeeList = employees?.getOrganizationUsers?.data ?? [];
    isSearchInfoLoading(false);
  }

  Future<void> getEmploymentStatus() async {
    isFilterInfoLoading(true);
    isEmploymentHistoryApiCalled = true;
    employmentStatuses = await _employeeRemoteDataSource.getEmploymentsStatus();
    if (employmentStatuses != null) {
      employmentStatusList = employmentStatuses!.statuses
          .map(
            (emp_wrk_inf.EmploymentStatus employmentStatus) => CheckBoxModel(
                checkBoxName: employmentStatus.name,
                checkBoxNameValue: employmentStatus.id),
          )
          .toList();
    }
    isFilterInfoLoading(false);
  }

  Future<void> getDepartments() async {
    isFilterInfoLoading(true);
    isEmploymentHistoryApiCalled = true;
    departments = await _employeeRemoteDataSource.getDepartments();

    if (departments != null) {
      departmentList = departments!.departments
          .map(
            (emp_wrk_inf.DropdownItem department) => CheckBoxModel(
                checkBoxName: department.name,
                checkBoxNameValue: department.id),
          )
          .toList();
    }

    isFilterInfoLoading(false);
  }

  Future<void> getDesignations() async {
    change(null, status: RxStatus.loading());
    isEmploymentHistoryApiCalled = true;
    designations = await _employeeRemoteDataSource.getDesignations();
    change(null, status: RxStatus.success());
  }

  Future<void> getEmployeeProfile({required String orgUserId}) async {
    change(null, status: RxStatus.loading());
    employeeProfileInfo = await _employeeRemoteDataSource.getEmployeeProfile(
        orgUserId: orgUserId);
    change(null, status: RxStatus.success());
  }

  Future<void> getEmployeesEmploymentInfo({required String orgUserId}) async {
    change(null, status: RxStatus.loading());
    employeeWorkHistory = await _employeeRemoteDataSource
        .getEmployeesEmploymentInfo(orgUserId: orgUserId);
    change(null, status: RxStatus.success());
  }

  Future<void> getUserLogHistory({required String orgUserId}) async {
    change(null, status: RxStatus.loading());
    employeesLogHistory =
        await _employeeRemoteDataSource.getUserLogHistory(orgUserId: orgUserId);
    change(null, status: RxStatus.success());
  }

  _getEmployeeUserLeaveRecord({required String orgUserId}) async {
    change(null, status: RxStatus.loading());
    final List<lr.GetLeaveRecordsForApp>? res =
        await _employeeLeaveRemoteDataSource.getLeaveRecordList(
            limit: 20, offset: 0, orgUserId: orgUserId);
    change(null, status: RxStatus.success());
  }

  void resetCheckBoxList(List<CheckBoxModel> checkBoxList) {
    for (CheckBoxModel item in checkBoxList) {
      item.value = false;
    }
  }

  // Method to check for changes
  void checkForChanges() {
    hasChangedProfileInfo.value =
        editFirstNameController.text != initFirstName ||
            editLastNameController.text != initLastName;
  }

  void addRecentSearchData(Data data) async {
    var box = Hive.box<Data>('dataBox');
    final dataList = box.values.toList();
    // Check if the data already exists
    if (dataList.any((element) => element.id == data.id)) {
      return;
    }
    // Ensure the list has a maximum of 3 elements
    if (dataList.length >= 3) {
      await dataList.last.delete();
    }
    await box.add(data);
  }

  void removeRecentSearchData(String id) async {
    var box = Hive.box<Data>('dataBox');
    final data = box.values.firstWhere((element) => element.id == id);
    await data.delete();
  }

  void clearAllRecentSearchData() async {
    Box<Data> box = Hive.box<Data>('dataBox');
    await box.clear();
  }

  void increment() {
    count++;
  }

  void decrement() {
    if (count > 0) {
      count--;
    }
  }

  final List<String> items = [
    'Permanent',
    'Ad-hoc',
    'Probation',
  ];

  List<String> getSelectedCheckBoxValues(List<CheckBoxModel> checkBoxList) {
    return checkBoxList
        .where((item) => item.value == true) // Filter items where value is true
        .map((item) => item.checkBoxNameValue) // Extract checkBoxNameValue
        .toList();
  }


  void dayIncrement() {
    daysCount++;
  }

  var count = 0.obs;

  void dayDecrement() {
    if (daysCount > 0) {
      daysCount--;
    }
  }

  void applicationBalanceIncrement() {
    applicationBalanceCount++;
  }

  void applicationBalanceDecrement() {
    if (applicationBalanceCount > 0) {
      applicationBalanceCount--;
    }
  }

  void applicationMaxDayIncrement() {
    applicationMaxDaysCount++;
  }

  void applicationMaxDayDecrement() {
    if (applicationMaxDaysCount > 0) {
      applicationMaxDaysCount--;
    }
  }

  @override
  void onInit() {
    getEmployees();
    getDepartments();
    getEmploymentStatus();
    super.onInit();
  }

  @override
  void onClose() {
    searchController.dispose();
    editFirstNameController.dispose();
    editLastNameController.dispose();
    editJoiningController.dispose();
    super.onClose();
  }
}
