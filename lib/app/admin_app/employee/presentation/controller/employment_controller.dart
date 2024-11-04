import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../data/employee_remote_data_source.dart';
import '../../domain/employee_info.dart';

class EmploymentController extends GetxController {
  var selectedOption = ''.obs;
  var employeeStatusValue = ''.obs;
  var employeeDesignationValue = ''.obs;
  var employeeDepartmentValue = ''.obs;
  RxBool isSearchInfoLoading = false.obs;
  RxBool isEmployeesInfoLoading = false.obs;

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  RxString searchQuery = ''.obs;

  TextEditingController searchController = TextEditingController();

  RxInt daysCount = 0.obs;
  RxInt applicationBalanceCount = 0.obs;
  RxInt applicationMaxDaysCount = 0.obs;

  void dayIncrement() {
    daysCount++;
  }

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

  final EmployeeRemoteDataSource _employeeRemoteDataSource =
      Get.find<EmployeeRemoteDataSource>();

  EmployeeInfo? employeeInfo = EmployeeInfo();

  List<Data>? employeeList = <Data>[];

  Future<void> getEmployees() async {
    isEmployeesInfoLoading(true);
    employeeInfo = await _employeeRemoteDataSource.getEmployees();
    isEmployeesInfoLoading(false);
  }

  Future<void> getEmployeesBySearch({required String searchQuery}) async {
    isSearchInfoLoading(true);
    final EmployeeInfo? employees =
        await _employeeRemoteDataSource.getEmployees(searchQuery);
    employeeList = employees?.getOrganizationUsers?.data ?? [];
    isSearchInfoLoading(false);
  }

  final List<String> items = [
    'Permanent',
    'Ad-hoc',
    'Probation',
  ];

  @override
  void onInit() {
    getEmployees();
    super.onInit();
  }
}
