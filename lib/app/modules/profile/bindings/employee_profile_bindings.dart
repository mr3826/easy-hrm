import 'package:get/get.dart';
import 'package:payrun_mobile/app/global/services/api_service.dart';
import '../controller/employee_profile_controller.dart';
import '../repositories/profile_data_source.dart';
import '../services/profile_api_service.dart';


class EmployeeProfileBindings  extends Bindings {
  @override
  void dependencies() {
    ProfileApiService profileApiService = Get.put(ProfileApiService(Get.find<ApiService>()));
    ProfileDataSource profileDataSource  = Get.put(ProfileDataSourceImpl(profileApiService));
    Get.put(EmployeeProfileController(profileDataSource));

  }
}
