import 'dart:developer';
import '../../../../network/exception_helper.dart';
import '../../../../network/network_client.dart';
import '../../../../utils/api_endpoints.dart';

class ApplyAndUpdateLeaveDateSource {

  final NetworkClient networkClient;
  ApplyAndUpdateLeaveDateSource(this.networkClient);

  Future<bool> updateAssignLeave(Map<String, dynamic> inputData) async {
    try {
      final response = await networkClient.graphRequest(
          queryString: updatedLeaveQuery, variables: inputData);
      if (response.hasException) {
        ExceptionHelper.errorHandler(
            exception: response.exception!, methodName: "updateLeave");
        return false;
      }

      return true;
    } catch (e) {
      log('Error in applyLeave: $e');
      return true;
    }
  }
}
