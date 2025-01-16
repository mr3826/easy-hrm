import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/utils.dart';
import '../models/candidate_activities_logs.dart';
import '../models/file_sign_url.dart';
import '../repositories/dashboard_repository.dart';

class CandidateDetailsController extends GetxController with StateMixin {
  final DashBoardDataSource _dasBoardDataSource;
  CandidateDetailsController(this._dasBoardDataSource);

  final RxInt currentIndex = 0.obs;
  final RxInt jobTabCurrentIndex = 0.obs;
  RxBool isFileSignUrlLoading=false.obs;

  CandidateActivitiesLogs? candidateActivitiesLogs;
  FileSignedUrl? fileSignedUrl;

  getCandidateActivitiesLogs(String jobApplicationId) async {
    change(null, status: RxStatus.loading());
    candidateActivitiesLogs = await _dasBoardDataSource
        .getCandidateActivitiesLogs(jobApplicationId: jobApplicationId);
    change(null, status: RxStatus.success());
  }


  getFileSignUrl(String fileKey) async {
    isFileSignUrlLoading(true);
    final urlPath = '${"files"}/${GetStorage().read(AppString.ORGANIZATION_ID)}/$fileKey';
    fileSignedUrl = await _dasBoardDataSource.getFileSignUrl(fileKey: urlPath);
    isFileSignUrlLoading(false);
    openUrlInBrowser(fileSignedUrl?.getFileSignedUrl??"");
  }
}



