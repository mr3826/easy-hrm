import 'package:flutter/cupertino.dart';
import '../../../../../../common/widget/hr_timeline/custom_network_image.dart';
import '../../../../../../utils/app_color.dart';
import '../../../../../../utils/app_style.dart';
import '../../../../../../utils/dimensions.dart';

class BuildTimesheetList extends StatelessWidget {
  const BuildTimesheetList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 15,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
      return _timeSheetDetailsCard();
    },);
  }

  _timeSheetDetailsCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: AppColor.leaveRecordCardColor,
            borderRadius: BorderRadius.circular(8),
          ),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _profileInfo(),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 10.0, // Horizontal space between items
                  runSpacing: 12.0, // Vertical space between rows
                  children: [
                    _buildDetailRow('Date:', 'Today (10:15 am - 08:15 pm)'),
                    Row(
                      children: [
                        Flexible(child: _buildDetailRow('Scheduled:', '9h')),
                        const SizedBox(width: 12),
                        Flexible(child: _buildDetailRow('Logged:', '8h 12m')),
                      ],
                    ),
                    _buildBalanceRow(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



  // Helper method for individual rows
  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: AppStyle.normal_text.copyWith(
            color: AppColor.normalTextColor.withOpacity(0.5),
            fontSize: Dimensions.fontSizeSmall,
          ),
        ),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            value,
            overflow: TextOverflow.ellipsis, // Prevent overflow if the text is too long
            style: AppStyle.normal_text.copyWith(
              color: AppColor.normalTextColor.withOpacity(0.8),
              fontSize: Dimensions.fontSizeSmall,
            ),
          ),
        ),
      ],
    );
  }

  // Helper method for the balance row with styled containers
  Widget _buildBalanceRow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Balance:',
          style: AppStyle.normal_text.copyWith(
            color: AppColor.normalTextColor.withOpacity(0.5),
            fontSize: Dimensions.fontSizeSmall,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          '-48m',
          style: AppStyle.normal_text.copyWith(color: AppColor.normalTextColor.withOpacity(0.8)),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.only(left: 12.0, right: 12,top: 0,bottom: 0),
          decoration: BoxDecoration(
            color: AppColor.pendingColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),

          ),
          child: Text(
            '2h',
            style: AppStyle.normal_text.copyWith(color: AppColor.pendingColor,fontSize: Dimensions.fontSizeSmall+1),
          ),
        ),
      ],
    );
  }

  // Profile information layout
  Widget _profileInfo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomNetworkImage(
          imageUrl: "https://thumbs.dreamstime.com/b/lonely-cherry-tree-seaside-rocks-d-artwork-35112983.jpg", // Provide an image URL if available
          isCircleImage: true,
          radius: 17,
          errorText: "Er",
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Agens Neilson',
                style: AppStyle.normal_text.copyWith(
                    color: AppColor.secondaryColor, fontSize: Dimensions.fontSizeDefault + 1),
              ),
              Text(
                'Laravel department',
                style: AppStyle.normal_text.copyWith(
                    color: AppColor.hintColor, fontSize: Dimensions.fontSizeSmall),
              ),
            ],
          ),
        ),
      ],
    );
  }
