import 'package:get/get.dart';
import '../../../global/controller/timmer_controller.dart';
import '../controllers/start_timer_controller.dart';


class StartTimerBindings extends Bindings {
  @override
  void dependencies() {



    Get.put(TimeCounterController());



  }
}
