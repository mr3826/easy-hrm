import 'package:get/get.dart';
import 'package:payrun_mobile/app/modules/auth/controller/forgot_password_controller.dart';

class ForgotPasswordBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ForgotPasswordController(),);
  }
}