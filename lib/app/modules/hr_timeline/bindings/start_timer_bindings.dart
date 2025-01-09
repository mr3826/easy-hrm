import 'package:get/get.dart';
import '../controllers/start_timer_controller.dart';


class StartTimerBindings extends Bindings {
  @override
  void dependencies() {



    Get.put(StartTimerController());



  }
}
