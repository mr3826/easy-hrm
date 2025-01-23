import 'package:get/get.dart';
import 'package:payrun_mobile/app/modules/employee/controller/update_org_user_info_controller.dart';
import 'package:payrun_mobile/app/modules/employee/repository/employee_data_sourse.dart';

class UpdateOrgUserInfoBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => UpdateOrgUserInfoController(
          employeeDataSource: Get.find<EmployeeDataSource>()),
    );
  }
}
