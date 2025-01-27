import 'dart:developer';
import '../models/employee_work_history.dart';
import '../models/organization_info.dart';
import '../models/user_log_history.dart';
import '../models/user_profile.dart';
import '../services/profile_api_service.dart';


abstract class ProfileDataSource {
  Future<UserDetails?> getProfileInfo(String ordId);
  Future<UserLogHistory?> getUserLogHistory();
  Future<EmployeeWorkHistory?> getEmploymentInfo(String ordId);
  Future<OrganizationInfoDetails?> getOrganizationInfo();

}

class ProfileDataSourceImpl implements ProfileDataSource {

  final ProfileApiService _profileApiService;
  ProfileDataSourceImpl(this._profileApiService);


  @override
  Future<UserDetails?> getProfileInfo(String ordId) async {
    try {
      final response = await _profileApiService.getProfileInfo(ordId);
      if (response != null) {
        return UserDetails.fromJson(response);
      }
      return null;
    } catch (e) {
      log('Error in getProfileInfo: $e');
      return null;
    }
  }


  @override
  Future<UserLogHistory?> getUserLogHistory() async {
    try {
      final response = await _profileApiService.getUserLogHistory();
      if (response != null) {
        return UserLogHistory.fromJson(response);
      }
      return null;
    } catch (e) {
      log('Error in getUserLogHistory: $e');
      return null;
    }
  }

    @override
  Future<EmployeeWorkHistory?> getEmploymentInfo(String ordId) async {
    try {
      final response = await _profileApiService.getEmploymentInfo(ordId);
      if (response != null) {
        return EmployeeWorkHistory.fromJson(response);
      }
      return null;
    } catch (e) {
      log('Error in getEmploymentInfo: $e');
      return null;
    }
  }

      @override
  Future<OrganizationInfoDetails?> getOrganizationInfo() async {
    try {
      final response = await _profileApiService.getOrganizationInfo();
      if (response != null) {
        return OrganizationInfoDetails.fromJson(response);
      }
      return null;
    } catch (e) {
      log('Error in getOrganizationInfo: $e');
      return null;
    }
  }





}
