import 'package:get/get.dart';
import 'package:payrun_mobile/network/network_client.dart';

class NotificationController extends GetxController {

  getUnReadNotification()async{
    await NetworkClient().getGraphQuery(queryString: "");
  }

}