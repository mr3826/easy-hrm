import 'package:get/get.dart';
import 'package:payrun_mobile/modules/leave/data/remote/leave_remote_data_source.dart';
import '../../../../app/modules/leave_hr/data/leave_remote_data_source.dart';
import '../../../../app/modules/leave_hr/presentation/model/leave_details_by_id.dart';
import '../../domain/leave_record_response.dart';

class LeaveRecordsController extends GetxController with StateMixin {
  @override
  void onInit() {
    getLeaveRecordsData();
    super.onInit();
  }
  final HrLeaveRemoteDataSource _hrLeaveRemoteDataSource = Get.find();

  final LeaveRemoteDataSource _remoteDataSource = Get.find<LeaveRemoteDataSource>();
  LeaveDetailsById? leaveDetailsById;
  RxBool isLeaveDetailsByLoading=false.obs;
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



  /// Fetches employee leave data and updates the [hrLeaveCalender] object.
  Future<void> getLeaveDetailsById({required String leaveId}) async {
    isLeaveDetailsByLoading(true);
    leaveDetailsById =
    await _hrLeaveRemoteDataSource.getLeaveDetailsById(leaveId);
    isLeaveDetailsByLoading(false);
  }

}
