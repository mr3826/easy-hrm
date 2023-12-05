import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/common/controller/convart_color_code_controller.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_text_field.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/leave/presentation/widget/custom_title_text_widget.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/utils.dart';

class TaskViewLayout extends StatefulWidget {
  const TaskViewLayout({super.key});

  @override
  State<TaskViewLayout> createState() => _TaskViewLayoutState();
}

class _TaskViewLayoutState extends State<TaskViewLayout> {

  List<dynamic> dataList = [
    'Project name one',
    'Project name two',
    'Project name three',
    'Project name four',
    'Project name five',
    'Project name six',
    'Orange',
    'Peach',
    'Pear',
    'Pineapple',
    'Strawberry',
    'Watermelon',
  ];
List<dynamic> color=[
    "#FF5733",
    "#1B4242",
    "#FFAD84",
    "#191919",
    "#B31312",
    "#B31312",
    "#B31312",
    "#FF5733",
    "#1B4242",
    "#FFAD84",
    "#191919",
    "#B31312",
    "#B31312",
    "#B31312",
  ];

  List<dynamic> filteredList = [];

  @override
  void initState() {
    super.initState();
    filteredList.addAll(dataList);
    taskSearchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    String query = taskSearchController.text.toLowerCase();
    setState(() {
      filteredList = dataList
          .where((item) => item.toLowerCase().contains(query))
          .toList();
    });
  }
  final SelectedTaskController selectionController = Get.put(SelectedTaskController());


  @override
  Widget build(BuildContext context) {
    print(selectionController.selectedData.toString()??"dfj");
    //print(selectionController.colorIndex.toString()??"dfj");
    return Padding(
      padding: marginLayout.copyWith(top: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customTitleText(text: AppString.text_project_or_task.tr),
          customSpacerHeight(height: 8),

          taskSearchInputField(),
          customSpacerHeight(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: filteredList.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                Color convertColor = HexColor(color[index]) ;
                return InkWell(
                  onTap: ()async {
                    if (filteredList[index] != null) {
                      selectionController.setSelectedData(filteredList[index]);

                      selectionController.setSelectedColor(color[index]);

                      selectionController.selectedData.isNotEmpty?Get.back():Container();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Icon(Icons.circle,size: 13,color: convertColor,),
                        ),
                        customSpacerWidth(width: 6),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(filteredList[index].toString(),style: AppStyle.mid_large_text.copyWith(fontSize: Dimensions.fontSizeMid-3,color: AppColor.normalTextColor),),
                            Text("Some random text as a description",style: AppStyle.mid_large_text.copyWith(fontSize: Dimensions.fontSizeMid-4,color: AppColor.hintColor),),

                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


Widget taskSearchInputField() {
  return SizedBox(
    height: AppLayout.getHeight(55),
    child: TextFormField(
      controller: taskSearchController,
      style: subTextFieldTitleStyle,
      autofocus: false,
      decoration: InputDecoration(
        hintText: AppString.text_select_option.tr,
        suffixIcon: GestureDetector(
          onTap: (){
            taskSearchController.clear();
          },
          child: taskSearchController.text.isNotEmpty? const Icon(
            Icons.close,
            size: 30,
            color: AppColor.hintColor,
          ):const Icon(CupertinoIcons.search),
        ),
        hintStyle: TextStyle(
            color: AppColor.hintColor,
            fontFamily: "Poppins",
            fontSize: Dimensions.fontSizeDefault + 1),
        border: OutlineInputBorder(
          borderSide:
              const BorderSide(width: 0.0, color: AppColor.primaryColor),
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault + 2),
        ),
        focusColor: AppColor.primaryColor,
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColor.hintColor,
            ),
            borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor.hintColor),
            borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
      ),
    ),
  );
}


class SelectedTaskController extends GetxController{
  RxString selectedData = ''.obs;
   Rx<MaterialColor> colorIndex = Colors.blue.obs;
   setSelectedData(String data) {
    selectedData.value=data;
   }
   setSelectedColor(color) {
    colorIndex.value=color;
    print(colorIndex);
    print("Color is normal $color");
  }



}

