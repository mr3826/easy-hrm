// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:payrun_mobile/app/admin_app/leave_hr/presentation/controller/picked_file_from_stroage.dart';
// import 'package:payrun_mobile/common/widget/custom_spacer.dart';
// import 'package:payrun_mobile/modules/leave/presentation/view/widget/dotted_circle_style.dart';
// import 'package:payrun_mobile/utils/app_color.dart';
// import 'package:payrun_mobile/utils/app_layout.dart';
// import 'package:payrun_mobile/utils/app_string.dart';
// import 'package:payrun_mobile/utils/app_style.dart';
// import 'package:payrun_mobile/utils/dimensions.dart';
// import 'package:payrun_mobile/utils/images.dart';
// import '../../../../../../../../../common/widget/custom_card_style.dart';
//
// class AddAttachmentFile extends StatelessWidget {
//   const AddAttachmentFile({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     Get.put(LeaveFileUploadController());
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Obx(() => _pathNameText()),
//         customSpacerHeight(height: 8),
//         Obx(() {
//           return dottedCircleStyle(
//               child: Get.find<LeaveFileUploadController>().path.value.isEmpty
//                   ? _emptyBox()
//                   : _selectedImageViewLayout());
//         }),
//       ],
//     );
//   }
// }
//
// _emptyBox() {
//   return GestureDetector(
//     onTap: () {
//       Get.find<LeaveFileUploadController>().selectFile();
//     },
//     child: Container(
//       color: AppColor.primaryColor.withOpacity(0.05),
//       child: SizedBox(
//         height: 130,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Card(
//               elevation: 0,
//               shape: roundedRectangleBorder.copyWith(
//                   side: BorderSide(color: AppColor.hintColor.withOpacity(0.3))),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   children: [
//                     const Icon(
//                       Icons.image_outlined,
//                       color: AppColor.hintColor,
//                     ),
//                     customSpacerWidth(width: 8),
//                     Text(
//                       AppString.text_upload_image.tr,
//                       style: AppStyle.mid_large_text.copyWith(
//                           color: AppColor.hintColor,
//                           fontSize: Dimensions.fontSizeDefault + 2),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
//
// _pathNameText({String? remoteUrl}) {
//   final filePath = Get.find<LeaveFileUploadController>().path.value;
//
//   // Check if both remoteUrl and filePath are null or empty
//   if ((remoteUrl?.isEmpty ?? true) && (filePath.isEmpty ?? true)) {
//     return Text(
//       "pdf, image, or doc file",
//       style: AppStyle.mid_large_text.copyWith(
//         color: AppColor.normalTextColor.withOpacity(0.6),
//         fontSize: Dimensions.fontSizeDefault - 2,
//       ),
//     );
//   }
//
//   // Check if remoteUrl is empty or filePath is not empty
//   return (remoteUrl?.isEmpty ?? true) || (filePath.isNotEmpty ?? false)
//       ? Text(
//           filePath.split('/').last ?? '',
//           style: AppStyle.mid_large_text.copyWith(
//             color: AppColor.primaryColor,
//             fontSize: Dimensions.fontSizeDefault - 2,
//           ),
//         )
//       : Text(
//           remoteUrl ?? '',
//           style: AppStyle.mid_large_text.copyWith(
//             color: AppColor.primaryColor,
//             fontSize: Dimensions.fontSizeDefault - 2,
//           ),
//         );
// }
//
// _selectedImageViewLayout() {
//   final controller = Get.find<LeaveFileUploadController>();
//   final filePath = controller.path.value;
//
//   if (filePath.isNotEmpty && filePath.endsWith(".pdf")) {
//     return _replaceFileLayout();
//   }
//
//   return GestureDetector(
//     onTap: () {
//       controller.selectFile();
//     },
//     child: Container(
//       height: AppLayout.getHeight(130),
//       decoration: BoxDecoration(
//         color: AppColor.disableColor.withOpacity(0.4),
//         image: filePath.isNotEmpty && File(filePath).existsSync()
//             ? DecorationImage(
//                 image: FileImage(File(filePath).absolute),
//                 fit: BoxFit.cover,
//               )
//             : null,
//       ),
//     ),
//   );
// }
//
// _replaceFileLayout() {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       GestureDetector(
//         onTap: () => Get.find<LeaveFileUploadController>().selectFile(),
//         child: Card(
//           elevation: 0,
//           shape: roundedRectangleBorder.copyWith(
//               side: BorderSide(color: AppColor.hintColor.withOpacity(0.3))),
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 const Icon(
//                   Icons.image_outlined,
//                   color: AppColor.primaryColor,
//                 ),
//                 customSpacerWidth(width: 8),
//                 Text(
//                   AppString.text_replace_file.tr,
//                   style: AppStyle.mid_large_text.copyWith(
//                       color: AppColor.primaryColor,
//                       fontSize: Dimensions.fontSizeDefault + 2),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     ],
//   );
// }
//
// _brokenImageViewLayout() {
//   return Container(
//     height: AppLayout.getHeight(100),
//     decoration: BoxDecoration(
//       color: AppColor.disableColor.withOpacity(0.4),
//       image: DecorationImage(
//         image: AssetImage(Images.PLACEHOLDER),
//         fit: BoxFit.cover,
//       ),
//     ),
//   );
// }
