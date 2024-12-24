import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../employee/presentation/view/widget/filter/check_box.dart';

class HrDashBoardController extends GetxController {
  final RxInt currentIndex = 0.obs;
  final ScrollController scrollController = ScrollController();

  List jobIndex = ["Job 1", "Job 2", "Job 3", "Job 4"]; // Example data

  TextEditingController candidateEmail = TextEditingController();
  TextEditingController candidateFirstName = TextEditingController();
  TextEditingController candidateLastName = TextEditingController();



  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      final double offset = scrollController.offset;
      final int index = (offset / 340).round(); // Assuming item width is 340
      currentIndex.value = index;
    });
  }

  @override
  void onClose() {
    scrollController.dispose();
    candidateEmail.dispose();
    candidateFirstName.dispose();
    candidateLastName.dispose();
    super.onClose();
  }
}
