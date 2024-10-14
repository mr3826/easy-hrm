import 'package:get/get.dart';

class EmploymentController  {
  var selectedOption = ''.obs;
  var employeeStatusValue = ''.obs;
  var employeeDesignationValue = ''.obs;
  var employeeDepartmentValue = ''.obs;

  final List<String> items = [
    'Permanent',
    'Ad-hoc',
    'Probation',
  ];

  var count = 0.obs;

  void increment() {
    count++;
  }

  void decrement() {
    if (count > 0) {
      count--;
    }
  }

}
