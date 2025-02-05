import 'dart:developer';
import '../models/employee_work_history.dart';
import '../models/organization_info.dart';
import '../models/user_log_history.dart';
import '../models/user_profile.dart';
import '../services/profile_api_service.dart';

abstract class ProfileDataSource {
  Future<UserDetails?> getProfileInfo(String ordId);

  Future<UserLogHistory?> getUserLogHistory([String? ordUserId]);

  Future<List<DeptHistories>> getOrgUserDeptHistory(String ordId);

  Future<List<DesignationHistories>> getOrgUserDesignationHistory(String ordId);

  Future<List<EmploymentHistories>> getOrgUserEmploymentHistory(String ordId);

  Future<EmployeeWorkHistory?> getEmploymentInfo(String ordId);

  Future<OrganizationInfoDetails?> getOrganizationInfo();
  Future<bool?> updateOrgLeaveAvailability({required String leaveStatusId, int? availableNumOfApplication, int? maximumConsecutiveDays, int? availableNumberOfDays});
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
  Future<UserLogHistory?> getUserLogHistory([String? ordUserId]) async {
    try {
      final response = await _profileApiService.getUserLogHistory(ordUserId);
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
  Future<List<DeptHistories>> getOrgUserDeptHistory(String ordId) async {
    try {
      final response = await _profileApiService.getOrgUserDeptHistory(ordId);
      if (response != null) {
        return EmployeeWorkHistory.fromJson(response)
            .getOrganizationUserHistory
            .deptHistories;
      }
    } catch (e) {
      log('Error in getOrgUserDeptHistory: $e');
    }
    return [];
  }

  @override
  Future<List<DesignationHistories>> getOrgUserDesignationHistory(
      String ordId) async {
    try {
      final response =
          await _profileApiService.getOrgUserDesignationHistory(ordId);
      if (response != null) {
        return EmployeeWorkHistory.fromJson(response)
            .getOrganizationUserHistory
            .designationHistories;
      }
    } catch (e) {
      log('Error in getOrgUserDesignationHistory: $e');
    }
    return [];
  }

  @override
  Future<List<EmploymentHistories>> getOrgUserEmploymentHistory(
      String ordId) async {
    try {
      final response =
          await _profileApiService.getOrgUserEmploymentStatusHistory(ordId);
      if (response != null) {
        return EmployeeWorkHistory.fromJson(response)
            .getOrganizationUserHistory
            .employmentHistories;
      }
    } catch (e) {
      log('Error in getOrgUserEmploymentHistory: $e');
    }
    return [];
  }

  @override
  Future<bool?> updateOrgLeaveAvailability({required String leaveStatusId, int? availableNumOfApplication, int? maximumConsecutiveDays, int? availableNumberOfDays}) async {

    try {
      final response = await _profileApiService.updateOrgLeaveAvailability(
          leaveStatusId,
          availableNumOfApplication,
          maximumConsecutiveDays,
          availableNumberOfDays);

      print("updateOrgLeaveAvailability : $response $leaveStatusId $availableNumberOfDays");
      if (response != null) {
        return true;
      }
      return false;
    } catch (e) {
      log('Error in updateOrgLeaveAvailability: $e');
      return false;
    }
  }
}
