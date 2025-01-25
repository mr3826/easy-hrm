import 'dart:async';
import 'package:get/get.dart';
import '../../../../common/controller/profile_helper/profile_data_source.dart';
import '../../model/user_profile.dart';


class ProfileController extends GetxController with StateMixin {
  @override
  void onInit() {
    getUserProfile();
    super.onInit();
  }
  final isLoadingProfile = false.obs;

  UserDetails? userDetails;
  final ProfileDataSource _profileDataSource = Get.find<ProfileDataSource>();

  Future<void> getUserProfile() async {
    isLoadingProfile(true);
    userDetails = (await _profileDataSource.getUserProfile()) ?? UserDetails();
    print("userDetails : ${userDetails?.getOrganizationUserDetails?.department?.name}");
    isLoadingProfile(false);
  }


}