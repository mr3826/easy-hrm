// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:payrun_mobile/utils/app_color.dart';
// import 'package:payrun_mobile/utils/app_layout.dart';
//
// import '../../../../common/widget/custom_spacer.dart';
// import '../../../../utils/dimensions.dart';
//
// Widget dottedBorderLayout({onAction}) {
//   return DottedBorder(
//     radius: Radius.circular(Dimensions.radiusMid),
//     color: AppColor.disableColor,
//     strokeCap: StrokeCap.square,
//     dashPattern: [AppLayout.getHeight(8), AppLayout.getWidth(6)],
//     strokeWidth: 2,
//     child: GestureDetector(
//       onTap: () => onAction(),
//       child: Get.find<LeaveController>().isFilePicked.value == true
//           ? Container(
//         padding: EdgeInsets.symmetric(
//             horizontal: AppLayout.getWidth(20),
//             vertical: AppLayout.getHeight(20)),
//         color: AppColor.disableColor.withOpacity(0.4),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Expanded(child: Text(result?.files.first.name ?? ""))
//           ],
//         ),
//       )
//           : Container(
//         padding: EdgeInsets.symmetric(
//             horizontal: AppLayout.getWidth(20),
//             vertical: AppLayout.getHeight(20)),
//         color: AppColor.disableColor.withOpacity(0.4),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(CupertinoIcons.link),
//             customSpacerWidth(width: 6),
//             Text(
//               AppString.text_click,
//               style: AppStyle.mid_large_text.copyWith(
//                   color: AppColor.primaryColor,
//                   fontSize: Dimensions.fontSizeDefault),
//             ),
//             customSpacerWidth(width: 6),
//             Text(
//               AppString.text_to_add_fils,
//               style: AppStyle.mid_large_text.copyWith(
//                   color: AppColor.hintColor,
//                   fontSize: Dimensions.fontSizeDefault + 2),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }