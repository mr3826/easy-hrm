import 'package:get/get.dart';

class PasswordController extends GetxController {
  RxBool isValue = true.obs;

  changeVal() {
    return isValue.value = !isValue.value;
  }
}