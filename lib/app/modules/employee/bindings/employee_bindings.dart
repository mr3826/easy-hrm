import 'package:get/get.dart';
import 'package:payrun_mobile/app/global/services/api_service.dart';
import 'package:payrun_mobile/app/modules/employee/repository/employee_data_sourse.dart';

import '../controller/employment_controller.dart';
import '../services/employee_api_service.dart';

class EmployeeBindings extends Bindings {
  @override
  void dependencies() {
    EmployeeApiService employeeRemoteService = Get.put(EmployeeApiService(Get.find<ApiService>()));
    EmployeeDataSource employeeDataSource = Get.put(
        EmployeeDataSourceImpl(employeeRemoteService));

    Get.put(EmploymentController(employeeDataSource));
  }
}
