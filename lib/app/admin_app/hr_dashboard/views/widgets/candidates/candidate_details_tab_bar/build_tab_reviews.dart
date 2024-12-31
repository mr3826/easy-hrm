import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/input_note.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_style.dart';

import '../../../../controllers/hr_deshboard_controller.dart';

class BuildTabReviews extends StatelessWidget {
  const BuildTabReviews({super.key});
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: marginLayout,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          BuildRating(),







        ],
      ),
    );
  }
}




class BuildRating extends StatefulWidget {
  const BuildRating({super.key});

  @override
  State<BuildRating> createState() => _BuildRatingState();
}

class _BuildRatingState extends State<BuildRating> {
  var controller=Get.find<HrDashBoardController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customSpacerHeight(height: 8),

          Text("Rating",style:AppStyle.normal_text.copyWith(color: AppColor.normalTextColor.withOpacity(0.7)),),
          customSpacerHeight(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(5, (index) {
              return GestureDetector(
                onTap: () => onStarTap(index),
                child: Icon(
                 controller. activeStarIndex >= index ? Icons.star : Icons.star_border,
                  color:controller. activeStarIndex >= index ? Colors.amber : Colors.amber,
                  size: 40,
                ),
              );
            }),
          ),
          customSpacerHeight(height: 16),
          SizedBox(

              height: 80,
              child: InputNote(controller: controller.createReviewMessage,
                hintText: "Write your option",borderColor: AppColor.disableColor,
                borderRadius: BorderRadius.circular(6),

              
              ))

        ],
      ),
    );
  }

  /// Handles star tap events
  void onStarTap(int selectedIndex) {
    setState(() {
      controller. activeStarIndex = selectedIndex; // Update the active star index instantly
      if(controller.activeStarIndex==0){
        controller.  activeStarIndex=-1;
      }
      print(controller.activeStarIndex+1);
    });
  }
}
