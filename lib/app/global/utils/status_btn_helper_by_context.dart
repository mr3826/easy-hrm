import 'package:flutter/cupertino.dart';
import '../../../enum.dart';
import 'app_status_helper.dart';

class StatusBtnHelperByContext {

 static statusBtnByContext(String status) {
    if (status == LeaveStatus.rejected.name) {
      return StatusBtnHelper.rejectedStatusBtn();
    } else if (status == LeaveStatus.reject.name) {
      return StatusBtnHelper.rejectedStatusBtn();
    }  else if (status == LeaveStatus.pending.name) {
      return StatusBtnHelper.pendingStatusBtn();
    } else if (status == LeaveStatus.taken.name) {
      return StatusBtnHelper.tokenStatusBtn();
    } else if (status == LeaveStatus.approved.name) {
      return StatusBtnHelper.approvedStatusBtn();
    }else if (status == LeaveStatus.cancelled.name) {
      return StatusBtnHelper.cancelledStatusBtn();
    }else if (status == LeaveStatus.cancel.name) {
      return StatusBtnHelper.cancelStatusBtn();
    } else {
      return Container();
    }
  }
}