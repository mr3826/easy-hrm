import 'package:get/get.dart';
import 'package:payrun_mobile/modules/dashboard/presentation/controller/employee_dashboard_controller.dart';

class EmployeeDashboardBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => EmployeeDashboardController(),
    );
  }
}
