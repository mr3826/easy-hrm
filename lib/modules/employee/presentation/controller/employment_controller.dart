import 'package:get/get.dart';
import 'package:payrun_mobile/modules/employee/data/employee_remote_data_source.dart';
import 'package:payrun_mobile/modules/employee/domain/employee_info.dart';

class EmploymentController extends GetxController {
  var selectedOption = ''.obs;
  var employeeStatusValue = ''.obs;
  var employeeDesignationValue = ''.obs;
  var employeeDepartmentValue = ''.obs;

  final EmployeeRemoteDataSource _employeeRemoteDataSource =
      Get.find<EmployeeRemoteDataSource>();

  EmployeeInfo? employeeInfo = EmployeeInfo();

  Future<void> getEmployees() async {
    employeeInfo = await _employeeRemoteDataSource.getEmployees();
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
