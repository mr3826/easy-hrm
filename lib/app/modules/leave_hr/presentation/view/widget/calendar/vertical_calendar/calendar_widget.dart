import 'package:flutter/material.dart';
import 'package:payrun_mobile/common/widget/custom_network_image.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import '../../../../../../../../common/widget/hr_timeline/custom_network_image.dart';
import '../../../../../../../../enum.dart';
import '../../../../../../../../utils/utils.dart';

class VerticalDottedDivider extends StatelessWidget {
  final double height;
  final double dashHeight;
  final double dashWidth;
  final int dotsPerRow;

  const VerticalDottedDivider({
    super.key,
    this.height = 70,
    this.dashHeight = 4,
    this.dashWidth = 1,
    this.dotsPerRow = 8,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate the number of rows based on height and dash height
    final rows = (height / (dashHeight * 2)).floor();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12), // Simplified padding
      child: SizedBox(
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            rows,
                (index) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                dotsPerRow,
                    (dotIndex) => Container(
                  width: dashWidth,
                  height: dashHeight,
                  color: Colors.grey.withOpacity(0.3),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

getStatusColor(status) {
  if (LeaveStatus.approved.name == status) {
    return Colors.green.withOpacity(0.2);
  } else if (LeaveStatus.pending.name == status) {
    return Colors.orange.withOpacity(0.2);
  } else if (LeaveStatus.reject.name == status) {
    return Colors.red.withOpacity(0.1);
  } else if (LeaveStatus.rejected.name == status) {
    return Colors.redAccent.withOpacity(0.1);
  } else if (LeaveStatus.taken.name == status) {
    return Colors.blueAccent.withOpacity(0.1);
  } else if (LeaveStatus.cancel.name == status) {
    return Colors.redAccent.withOpacity(0.1);
  } else if (LeaveStatus.cancelled.name == status) {
    return Colors.grey.withOpacity(0.2);
  } else {
    return Colors.grey.withOpacity(0.2);
  }
}

class StatusTag extends StatelessWidget {
  final String text;
  final Color color;

  const StatusTag({super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      margin: const EdgeInsets.only(right: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: FittedBox(
        child: Text(
          text,
          style: AppStyle.normal_text_black.copyWith(fontSize: MediaQuery.of(context).size.width * 0.03),
        ),
      ),
    );
  }
}

class OverlappingAvatars extends StatelessWidget {
  final List<String> imageUrls;
  final int maxAvatars;
  final double radius;
  final double overlap;

  const OverlappingAvatars({
    Key? key,
    required this.imageUrls,
    this.maxAvatars = 5,
    this.radius = 19,
    this.overlap = 23.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final displayCount = imageUrls.length > maxAvatars ? maxAvatars - 1 : imageUrls.length;
    final remainingCount = imageUrls.length - displayCount;

    return SizedBox(
      height: radius * 2.5,
      child: Stack(
        children: [
          for (int index = 0; index < displayCount; index++)
            Positioned(
              left: index * overlap,
              child: CircularNetworkImage(
                imageUrl: buildImgIxUrl(imagePath:imageUrls[index], isPublic: true),
                errorText: getInitials(imageUrls[index]),
                radius: 18,
              ),

            ),
          if (remainingCount > 0)
            Positioned(
              left: displayCount * overlap,
              child: CircleAvatar(
                radius: radius,
                backgroundColor: AppColor.primaryColor,
                child: Text(
                  '+$remainingCount',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
