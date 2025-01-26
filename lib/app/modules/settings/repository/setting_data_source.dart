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
   print("getAppSetting_called");
   try {
   Map<String, dynamic>? response=await  _apiServices.getSettingApi();
   print("getAppSetting : $response");
   if(response !=null){
     return OrgSetting.fromJson(response);
   }
   } catch (e) {
     log("getOrgSetting: $e");
   }
   return null;
 }


}