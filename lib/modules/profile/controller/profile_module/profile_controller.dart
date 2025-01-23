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

  UserDetails? userDetails;
  final ProfileDataSource _profileDataSource = Get.find<ProfileDataSource>();

  Future<void> getUserProfile() async {
    change(null, status: RxStatus.loading());
    userDetails = (await _profileDataSource.getUserProfile()) ?? UserDetails();
    change(null, status: RxStatus.success());
  }


}