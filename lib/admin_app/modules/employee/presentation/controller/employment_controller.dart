import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:payrun_mobile/admin_app/modules/employee/domain/employement_status.dart';
import 'package:payrun_mobile/admin_app/modules/employee/presentation/view/widget/filter/check_box.dart';

import '../../data/employee_remote_data_source.dart';
import '../../domain/employee_info.dart';

class EmploymentController extends GetxController {
  var selectedOption = ''.obs;
  var employeeStatusValue = ''.obs;
  var employeeDesignationValue = ''.obs;
  var employeeDepartmentValue = ''.obs;
  RxBool isSearchInfoLoading = false.obs;
  RxBool isEmployeesInfoLoading = false.obs;
  RxBool isFilterInfoLoading = false.obs;

  RxString searchQuery = ''.obs;

  TextEditingController searchController = TextEditingController();

  var count = 0.obs;

  final EmployeeRemoteDataSource _employeeRemoteDataSource =
      Get.find<EmployeeRemoteDataSource>();

  EmployeeInfo? employeeInfo = EmployeeInfo();

  List<Data>? employeeList = <Data>[];

  List<CheckBoxModel> departmentList = [];

  List<CheckBoxModel> employmentStatusList = [];

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

  // "attendance": [],
  // "department_id": [],
  // "employment_status_ids": [],
  // "user_status": []

  ///methods
  Future<void> getEmployees() async {
    isEmployeesInfoLoading(true);

    Map<String, Map<String, Object>> queryMap = {
      "queryData": {
        "role": ["org_employee"]
      },
      "optionData": {"limit": 20, "offset": 0}
    };
    employeeInfo = await _employeeRemoteDataSource.getEmployees(queryVariable: queryMap);
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
    employeeList = employees?.getOrganizationUsers?.data ?? [];
    isSearchInfoLoading(false);
  }

  Future<void> getEmploymentStatus() async {
    isFilterInfoLoading(true);
    final response = await _employeeRemoteDataSource.getEmploymentsStatus();
    employmentStatusList = response?.getEmploymentsStatus
            ?.map(
              (GetEmploymentsStatus employmentsStatus) => CheckBoxModel(
                  checkBoxName: employmentsStatus.name ?? "",
                  checkBoxNameValue: employmentsStatus.id ?? ""),
            )
            .toList() ??
        [];
    isFilterInfoLoading(false);
  }

  Future<void> getDepartments() async {
    isFilterInfoLoading(true);
    final response = await _employeeRemoteDataSource.getDepartments();
    departmentList = response?.getDepartments?.data
            ?.map(
              (department) => CheckBoxModel(
                  checkBoxName: department.name ?? "",
                  checkBoxNameValue: department.name ?? ""),
            )
            .toList() ??
        [];
    isFilterInfoLoading(false);
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
    super.onClose();
  }

}
