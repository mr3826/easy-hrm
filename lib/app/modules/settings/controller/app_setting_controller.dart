import 'package:get/get.dart';
import '../models/org_setting.dart';
import '../repository/setting_data_source.dart';

class AppSettingController extends GetxController {

 final SettingDataSource _settingDataSource;
  AppSettingController(this._settingDataSource);

  @override
  void onInit() {
    getAppSetting();
    super.onInit();
  }


  OrgSetting? orgSetting;

  Future<OrgSetting?> getAppSetting() async {
    orgSetting= await _settingDataSource.getAppSetting();
    return null;
  }
}
