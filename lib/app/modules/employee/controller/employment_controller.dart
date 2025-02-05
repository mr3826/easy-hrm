import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:payrun_mobile/app/modules/employee/model/terminate_org_user.dart';
import 'package:payrun_mobile/app/modules/employee/repository/employee_data_sourse.dart';
import '../model/employee_info.dart';
import '../model/user_work_info_dropdown.dart' as emp_wrk_inf;
import '../view/widget/filter/check_box.dart';

class EmploymentController extends GetxController with StateMixin {
  final EmployeeDataSource _employeeDataSource;

  EmploymentController(this._employeeDataSource);

  RxString selectedTerminationOption = ''.obs;
  Rx<DateTime> selectedTerminationDate = DateTime.now().obs;

  RxBool isSearchInfoLoading = false.obs;
  RxBool isEmployeesInfoLoading = false.obs;
  RxBool isFilterInfoLoading = false.obs;
  bool isEmploymentHistoryApiCalled = false;
  RxBool isTerminatedUserDataLoading = false.obs;

  RxString searchQuery = ''.obs;

  TextEditingController searchController = TextEditingController();
  TextEditingController terminationEditNoteController = TextEditingController();


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
        await _employeeDataSource.getEmployees(queryVariable: queryMap);
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
        await _employeeDataSource.getEmployees(queryVariable: queryMap);
    searchedEmployeeList = employees?.getOrganizationUsers?.data ?? [];
    isSearchInfoLoading(false);
  }

  Future<void> getEmploymentStatus() async {
    isFilterInfoLoading(true);
    isEmploymentHistoryApiCalled = true;
    employmentStatuses = await _employeeDataSource.getEmploymentsStatus();
    if (employmentStatuses != null) {

      employmentStatusList = employmentStatuses!.statuses.map((emp_wrk_inf.EmploymentStatus employmentStatus) => CheckBoxModel(
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
    departments = await _employeeDataSource.getDepartments();

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
    designations = await _employeeDataSource.getDesignations();
    change(null, status: RxStatus.success());
  }

  Future<bool> terminatedAUser(TerminateUserModel terminateAUserModel) async {
    isTerminatedUserDataLoading(true);
    String? response =
        await _employeeDataSource.terminateAUser(terminateAUserModel);
    isTerminatedUserDataLoading(false);
    if (response != null && response.isNotEmpty) return true;
    return false;
  }


  void resetCheckBoxList(List<CheckBoxModel> checkBoxList) {
    for (CheckBoxModel item in checkBoxList) {
      item.value = false;
    }
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
    terminationEditNoteController.dispose();
    super.onClose();
  }
}
