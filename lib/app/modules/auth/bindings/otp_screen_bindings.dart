import 'package:get/get.dart';

import '../controller/otp_controller.dart';

class OtpScreenBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => OtpController());
  }

}