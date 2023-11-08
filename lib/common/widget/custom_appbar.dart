 import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:flutter/material.dart';


 class CustomAppbar extends StatelessWidget {
   const CustomAppbar({super.key});

   @override
   Widget build(BuildContext context) {
     return AppBar(
       scrolledUnderElevation: .5,
       leadingWidth: 130,
       toolbarHeight: 46,
       backgroundColor: AppColor.cardColor,
       leading: Padding(
         padding: leadingEdgeInsets,
         child: svgIcon(height: 20, width: 20),
       ),
       actions: [
         Stack(
           alignment: Alignment.center,
           children: [
             IconButton(
               padding: iconButtonEdgeInsets,
               onPressed: () async {
                 //Get.toNamed(Routes.NOTIFICATION_SCREEN);
               },
               icon: icon,
             ),
            // if (controller.length > 0)
               Positioned(left: AppLayout.getWidth(25), child: circleIcon)
           ],
         )
       ],
       elevation: .5,
     );
   }

   Size get preferredSize => const Size(double.maxFinite, 46);
 }


Widget svgIcon(
    {double? height = 35, double? width = 35, String? url, Color? color}) {
  return const Icon(Icons.add_circle_outline);
}

EdgeInsets get leadingEdgeInsets {
  return EdgeInsets.only(
      left: AppLayout.getWidth(18), bottom: AppLayout.getHeight(8));
}

EdgeInsets get iconButtonEdgeInsets {
  return EdgeInsets.only(bottom: AppLayout.getHeight(8));
}

Icon get icon {
  return Icon(
    Icons.notifications_none,
    color: AppColor.primaryColor,
    size: Dimensions.fontSizeExtraLarge + 6,
  );
}

Icon get circleIcon {
  return Icon(
    Icons.circle,
    color: Colors.red,
    size: AppLayout.getHeight(10),
  );
}

