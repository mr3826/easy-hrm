import 'package:get/get.dart';
import 'package:payrun_mobile/app/global/services/api_service.dart';
import 'package:payrun_mobile/app/modules/settings/controller/app_setting_controller.dart';
import 'package:payrun_mobile/app/modules/settings/repository/setting_data_source.dart';
import 'package:payrun_mobile/app/modules/settings/services/setting_api_services.dart';


class SettingBindings extends Bindings{
  @override
  void dependencies() {
    SettingApiServices settingApiServices=Get.put(SettingApiServices(Get.find<ApiService>()));
    SettingDataSource settingDataSource=SettingDataSourceIml(settingApiServices);
    Get.put(AppSettingController(settingDataSource));
  }
}