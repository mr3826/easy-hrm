import 'package:get/get.dart';
import 'package:payrun_mobile/modules/leave/data/remote/leave_remote_data_source.dart';
import '../../domain/leave_record_response.dart';

class LeaveRecordsController extends GetxController with StateMixin {
  @override
  void onInit() {
    getLeaveRecordsData();
    super.onInit();
  }

  final LeaveRemoteDataSource _remoteDataSource =
      Get.find<LeaveRemoteDataSource>();

  List<GetLeaveRecordsForApp>? leaveRecordList;
  RxInt offset = 0.obs;
  int limit = 30;

  //todo
  //do pagination
  getLeaveRecordsData() async {
    change(null, status: RxStatus.loading());
    leaveRecordList = await _remoteDataSource.getLeaveRecordList(
        limit: limit, offset: offset.value);

    change(null, status: RxStatus.success());
  }
}
