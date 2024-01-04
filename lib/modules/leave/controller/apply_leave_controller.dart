import 'package:payrun_mobile/network/network_client.dart';

class ApplyLeaveController {

  applyLeave() async {
    final response = await NetworkClient().mutationGraphData(
        mutationQuery, variables);
  }

  getUploadPolicy() async {
    final response = await NetworkClient().getGraphQuery(
        queryString: queryString);
  }

}