import 'dart:developer';
import 'package:payrun_mobile/app/modules/settings/services/setting_api_services.dart';
import '../models/org_setting.dart';


abstract class SettingDataSource{
  Future<OrgSetting?> getAppSetting();
}


class SettingDataSourceIml implements SettingDataSource{

 final SettingApiServices _apiServices;
  SettingDataSourceIml(this._apiServices);


 @override
  Future<OrgSetting?> getAppSetting() async {
   try {
   Map<String, dynamic>? response=await  _apiServices.getSettingApi();
   if(response !=null){
     return OrgSetting.fromJson(response);
   }
   } catch (e) {
     log("getOrgSetting: $e");
   }
   return null;
 }


}