import 'dart:async';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/app/modules/profile/repositories/profile_data_source.dart';
import '../models/user_profile.dart';
import '../../../../utils/app_string.dart';
import 'global_profile_controller.dart';

class ProfileRouteBaseController extends GetxController {
  final ProfileDataSource _profileDataSource;
  ProfileRouteBaseController(this._profileDataSource);

  final isLoadingProfile = false.obs;

  UserDetails? userDetails;


  Future<void> getUserProfile({String ?ordId}) async {
    isLoadingProfile(true);
    userDetails = (await _profileDataSource.getProfileInfo(ordId??GetStorage().read(AppString.ORGANIZATION_USER_ID))) ?? UserDetails();
    _addUserInfo();
    isLoadingProfile(false);
  }
  void _addUserInfo() {
    Get.find<ProfileGlobalController>().employeeName.value ="${userDetails?.getOrganizationUserDetails?.profile?.firstName??""} ${userDetails?.getOrganizationUserDetails?.profile?.lastName??""}";
    Get.find<ProfileGlobalController>().employeeImeKey.value =userDetails?.getOrganizationUserDetails?.profile?.image??"";
  }


}