import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import '../view/widget/task_view_layout.dart';

class SelectedTaskController extends GetxController{
  RxString selectedTaskIndex = "".obs;
  Rx<Color> hexColor = HexColor("#FFFFFF").obs;

  // Method to update the task
  addTaskText(String data) {
    selectedTaskIndex.value=data;
  }

  // Method to update the color
  void taskAccordingToColor(String newHexColor) {
    hexColor.value = HexColor(newHexColor);
  }


}