import 'package:get/get.dart';
import '../models/candidate_activities_logs.dart';
import '../repositories/dashboard_repository.dart';

class CandidateDetailsController  extends GetxController with StateMixin {

   final DashBoardDataSource _dasBoardDataSource;
   CandidateDetailsController(this._dasBoardDataSource);


   final RxInt currentIndex = 0.obs;
   final RxInt jobTabCurrentIndex = 0.obs;

   CandidateActivitiesLogs? candidateActivitiesLogs;



   getCandidateActivitiesLogs(String jobApplicationId) async {
     change(null,status: RxStatus.loading());
     candidateActivitiesLogs = await _dasBoardDataSource.getCandidateActivitiesLogs(jobApplicationId: jobApplicationId);
     change(null,status: RxStatus.success());
   }


}