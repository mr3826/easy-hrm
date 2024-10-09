import 'package:get/get.dart';

class EmploymentController extends GetxController {
  var selectedOption = ''.obs;
  var employeeStatusValue = ''.obs;
  var employeeDesignationValue = ''.obs;
  var employeeDepartmentValue = ''.obs;

  final List<String> items = [
    'Permanent',
    'Ad-hoc',
    'Probation',
  ];
}
