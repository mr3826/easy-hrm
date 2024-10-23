import 'package:flutter/material.dart';
import '../../../../../../../common/widget/custom_card_style.dart';
import '../../../../../../../common/widget/employee/status_button_helper.dart';
import '../../../../../../../utils/app_color.dart';
import '../../../../../../../utils/app_style.dart';
import '../../../../../../../utils/dimensions.dart';

class LeaveWidget extends StatelessWidget {
  const LeaveWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> data = [
      {"type": "Sick leave", "status": "approved"},
      {"type": "Sick leave", "status": "pending"},
      {"type": "Sick leave", "status": "rejected"},
      {"type": "Sick leave", "status": "taken"},
      {"type": "Sick leave", "status": "rejected"},
      {"type": "Sick leave", "status": "pending"},
      {"type": "Sick leave", "status": "reject"},
      {"type": "Sick leave", "status": "taken"},
    ];

    return ListView.builder(
      itemCount: data.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final leaveType = data[index]["type"]!;
        final leaveStatus = data[index]["status"]!;
        final itemColor =
            index % 2 == 0 ? AppColor.leaveRecordCardColor : Colors.transparent;

        return SizedBox(
          child: Card(
            elevation: 0,
            shape: roundedRectangleBorder.copyWith(
              borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
            ),
            color: itemColor,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          leaveType,
                          style: AppStyle.mid_large_text.copyWith(
                            color: AppColor.normalTextColor,
                            fontSize: Dimensions.fontSizeDefault,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "22 Apr - 23 Apr",
                            style: AppStyle.mid_large_text.copyWith(
                              color: AppColor.normalTextColor,
                              fontSize: Dimensions.fontSizeDefault,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "Duration 2 days",
                            style: AppStyle.mid_large_text.copyWith(
                              color: AppColor.hintColor,
                              fontSize: Dimensions.fontSizeSmall - 1,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      _showStatusButton(leaveStatus),
                      const Spacer(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget _showStatusButton(String leaveStatus) {
  switch (leaveStatus.toLowerCase()) {
    case 'approved':
      return StatusBtnHelper.approvedStatusBtn();

    case 'rejected':
      return StatusBtnHelper.rejectedStatusBtn();
    case 'pending':
      return StatusBtnHelper.pendingStatusBtn();
    case 'taken':
      return StatusBtnHelper.tokenStatusBtn();
    case 'cancelled':
      return StatusBtnHelper.cancelStatusBtn();
    default:
      return Container();
  }
}
