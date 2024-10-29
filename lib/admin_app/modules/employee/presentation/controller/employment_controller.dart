import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

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

  var count = 0.obs;

  void increment() {
    count++;
  }

  void decrement() {
    if (count > 0) {
      count--;
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
    var box = Hive.box<Data>('dataBox');
    await box.clear();
  }

  @override
  void onInit() {
    getEmployees();
    super.onInit();
  }
}
