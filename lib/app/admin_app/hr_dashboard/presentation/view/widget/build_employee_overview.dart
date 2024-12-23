import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../../../../utils/app_color.dart';
import '../../../../../../utils/app_style.dart';
import '../../../../../../utils/dimensions.dart';

class BuildEmployeeOverview extends StatelessWidget {
  const BuildEmployeeOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding:
            const EdgeInsets.all(24.0), // Adjusted padding for better layout
        child: Row(
          children: [
            const Spacer(),
            _buildText(label: "Present", value: "148.23"),
            const Spacer(),
            _divider(),
            const Spacer(),
            _buildText(label: "On leave", value: "35.2"),
            const Spacer(),
            _divider(),
            const Spacer(),
            _buildText(
              label: "Absent",
              value: "148",
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  _buildText({required String label, required String value}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _formatNumber(value).replaceAll(".0", ""),
          style: AppStyle.mid_large_text.copyWith(
            color: AppColor.cardColor,
            fontSize: Dimensions.fontSizeLarge,
            overflow: TextOverflow.ellipsis,
          ),
          maxLines: 1, // Ensures ellipsis is applied for overflow
        ),
        Text(
          label,
          style: AppStyle.mid_large_text.copyWith(
            color: AppColor.cardColor,
            fontSize: Dimensions.fontSizeSmall + 1,
            overflow: TextOverflow.ellipsis,
          ),
          maxLines: 1, // Ensures ellipsis is applied for overflow
        ),
      ],
    );
  }

  _divider() {
    return Container(
      height: 30,
      width: .6,
      color: AppColor.cardColor,
    );
  }

  String _formatNumber(String value) {
    double number = double.tryParse(value) ?? 0.0;
    return number.toStringAsFixed(1);
  }
}
