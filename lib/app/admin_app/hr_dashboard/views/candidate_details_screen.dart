import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/hr_deshboard/custom_network_img.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import '../../../../common/widget/custom_appbar.dart';
import '../../../../utils/app_string.dart';
import 'widgets/candidates/candidate_details_tabbar.dart';

class CandidateDetailsScreen extends StatelessWidget {
  const CandidateDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title:"${ AppString.text_candidate.tr} ${AppString.text_details.tr}"),
      body: Column(
        children: [

          _buildCandidateInfo(),

        ],
      ),
    );
  }

  _buildCandidateInfo() {
    return   Column(
      children: [
        const Center(child: CustomNetworkImage(imageUrl: "https://thumbs.dreamstime.com/b/stylish-cat-sunglasses-poses-confidently-rocky-beach-capturing-unique-blend-humor-charm-warm-glow-sunset-349482060.jpg",isCircleImage: true,radius: 32,)),
        customSpacerHeight(height: 12),

        Text("Katarina Neilson",style:AppStyle.large_text.copyWith(color: AppColor.normalTextColor,fontWeight: FontWeight.w600,fontSize: Dimensions.fontSizeMid-2),),
        customSpacerHeight(height: 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${AppString.text_applied.tr} ",style:AppStyle.large_text.copyWith(color: AppColor.hintColor,fontWeight: FontWeight.w500,fontSize: Dimensions.fontSizeDefault),),
            Text("Node.js Developer",style:AppStyle.large_text.copyWith(color: AppColor.secondaryColor,fontWeight: FontWeight.w500,fontSize: Dimensions.fontSizeDefault),),
          ],
        ),
        customSpacerHeight(height: 6),
        _review(),
        customSpacerHeight(height: 12),


        _candidateStatus(),
        customSpacerHeight(height: 14),

        const CandidateDetailsTabbar(),









      ],
    );
  }

  _candidateStatus() {

    return Center(
      child: Container(


        decoration: BoxDecoration(
          color: AppColor.secondaryColor,

          borderRadius: BorderRadius.circular(30)

        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0,right: 20,bottom: 6,top: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Interview",style: AppStyle.normal_text_black.copyWith(color: AppColor.cardColor),),
              customSpacerWidth(width: 8),
              const Icon(Icons.keyboard_arrow_down_sharp,color: AppColor.cardColor,)
            ],
          ),
        ),

      ),
    );


  }
}

_review() {
  
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Icon(Icons.star,size: 22,color: AppColor.pendingColor,),
      Text(" 4.5 (${"3"})",style: AppStyle.normal_text_black.copyWith(color: AppColor.pendingColor),)
    ],
  );
  
}
