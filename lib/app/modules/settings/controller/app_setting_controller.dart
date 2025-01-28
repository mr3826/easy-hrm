import 'package:get/get.dart';
import '../models/org_setting.dart';
import '../repository/setting_data_source.dart';

class AppSettingController extends GetxController {
  final SettingDataSource _settingDataSource;

  AppSettingController(SettingDataSource settingDataSource)
      : _settingDataSource = settingDataSource;

  @override
  void onInit() {
    getAppSetting();
    super.onInit();
  }

  OrgSetting? orgSetting;

  Future<void> getAppSetting() async {

    orgSetting = await _settingDataSource.getAppSetting();
  }
}
