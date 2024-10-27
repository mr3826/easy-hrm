import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/app/admin_app/leave_hr/presentation/controller/leave_controller.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../../../utils/app_color.dart';
import '../../../../../../utils/app_string.dart';
import '../../../../../../utils/app_style.dart';
import '../../../../../../utils/dimensions.dart';

class DateNavigatorWidget extends StatefulWidget {
  final ValueChanged<String> onDateChanged;

  const DateNavigatorWidget({
    Key? key,
    required this.onDateChanged,
  }) : super(key: key);

  @override
  _DateNavigatorWidgetState createState() => _DateNavigatorWidgetState();
}

class _DateNavigatorWidgetState extends State<DateNavigatorWidget> {
  late String currentDate;

  @override
  void initState() {
    super.initState();
    currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    widget.onDateChanged(currentDate);
  }

  void _updateDate(int daysToAdd) {
    final date = DateTime.parse(currentDate).add(Duration(days: daysToAdd));
    setState(() {
      currentDate = DateFormat('yyyy-MM-dd').format(date);
    });
    widget.onDateChanged(currentDate);
  }


  @override
  Widget build(BuildContext context) {
    var controller = Get.put(LeaveController());

    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 8, right: 8),
      child: GestureDetector(
        onTap: () {

          showDialog<String>(
            context: context,
            builder: (BuildContext context) => Dialog(
              child: _buildDialog(),
            ),
          );

        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      controller.listIndex.value-1;
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: AppColor.normalTextColor,
                      size: 18,
                    ),
                  ),
                 Obx(()=> Text(
                   controller.currentDate.value ,
                   style: AppStyle.mid_large_text.copyWith(
                     color: AppColor.secondaryColor,
                     fontSize: Dimensions.fontSizeDefault+3,
                     fontWeight: FontWeight.bold,
                   ),
                 ),),
                  GestureDetector(
                    onTap: (){

                    },
                    child: const Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: AppColor.normalTextColor,
                      size: 18,
                    ),
                  ),
                ],
              ),
              Center(
                child: Text(
                  DateFormat('EEEE').format(DateTime.parse(currentDate)),
                  style: AppStyle.mid_large_text.copyWith(
                    color: AppColor.hintColor,
                    fontSize: Dimensions.fontSizeDefault - 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



  _buildDialog() {
    var controller = Get.put(LeaveController());
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
        Obx(()=>  _buildTitle(_getDate(controller)),),
          customSpacerHeight(height: 16),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: controller.dayList.length <= 5
                  ? controller.dayList.length * 60.0 // Adjust item height as needed
                  : 300, // Max height for longer lists
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: controller.dayList.length,
              itemBuilder: (context, index) {
                return Obx(() => InkWell(
                  onTap: () {

                    controller.currentDate.value=controller.dayList[index];
                    controller.listIndex.value = index;


                     if(controller.dayList[index]=="Custom" && controller.listIndex.value==6){

                       showDialog<String>(
                         context: context,
                         builder: (BuildContext context) => Dialog(
                           child: Container(
                             decoration: BoxDecoration(
                               color: Colors.white,
                               borderRadius: BorderRadius.circular(12),
                             ),
                             padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                             child: Column(
                               mainAxisSize: MainAxisSize.min,
                               children: [
                                 TableCalendar(
                                   calendarStyle: CalendarStyle(
                                     defaultTextStyle: const TextStyle(fontSize: 16),
                                     weekendDecoration: BoxDecoration(
                                       shape: BoxShape.circle,
                                       color: AppColor.hintColor.withOpacity(.1),
                                     ),
                                     weekendTextStyle: TextStyle(
                                       fontSize: 14,
                                       color: AppColor.hintColor.withOpacity(.5),
                                     ),
                                     selectedDecoration: const BoxDecoration(
                                       shape: BoxShape.circle,
                                       color: Colors.blueAccent,
                                     ),
                                     todayDecoration: const BoxDecoration(
                                       shape: BoxShape.circle,
                                       color: Colors.transparent,
                                     ),
                                     todayTextStyle: const TextStyle(
                                       fontSize: 18,
                                       color: Colors.blueAccent,
                                       fontWeight: FontWeight.bold,
                                     ),
                                   ),
                                   focusedDay: DateTime.parse(currentDate),
                                   headerStyle: HeaderStyle(
                                     formatButtonShowsNext: false,
                                     formatButtonVisible: false,
                                     titleTextStyle: AppStyle.mid_large_text.copyWith(
                                       color: AppColor.normalTextColor,
                                       fontSize: Dimensions.fontSizeDefault + 1,
                                     ),
                                   ),
                                   firstDay: DateTime.utc(DateTime.now().year - 2, 01, 01),
                                   lastDay: DateTime.utc(DateTime.now().year + 2, 12, 31),
                                   selectedDayPredicate: (day) => isSameDay(day, DateTime.parse(currentDate)),
                                   onDaySelected: (selectedDay, focusedDay) {
                                     setState(() {
                                  //     currentDate = _formatDate(selectedDay);
                                     });
                                     widget.onDateChanged(currentDate);
                                   },
                                 ),
                                 const Divider(color: Colors.grey),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.end,
                                   children: [
                                     TextButton(
                                       onPressed: () => Navigator.pop(context),
                                       child: const Text('Close'),
                                     ),
                                     const SizedBox(width: 40),
                                     TextButton(
                                       onPressed: () {
                                         widget.onDateChanged(currentDate);
                                         Navigator.pop(context); // Close the dialog
                                       },
                                       child: const Text('Ok'),
                                     ),
                                   ],
                                 ),
                               ],
                             ),
                           ),
                         ),
                       );
                     }else{
                       Navigator.pop(context);
                     }




                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Container(
                      color: controller.listIndex.value == index
                          ? AppColor.primaryColor.withOpacity(0.1)
                          : AppColor.cardColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          controller.dayList[index],
                          style: AppStyle.mid_large_text.copyWith(
                            color: controller.listIndex.value == index
                                ? AppColor.secondaryColor
                                : AppColor.normalTextColor,
                            fontSize: Dimensions.fontSizeDefault + 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ));
              },
            ),
          ),
          customSpacerHeight(height: 4),

        ],
      ),
    );
  }


  _buildTitle(String text) {
    return Column(
      children: [
        Text(
          text,
          style: AppStyle.mid_large_text.copyWith(
            color: AppColor.secondaryColor,
            fontSize: Dimensions.fontSizeMid - 3,
            fontWeight: FontWeight.bold,
          ),
        ),
        Center(
          child: Text(
            DateFormat('EEEE').format(DateTime.parse(currentDate)),
            style: AppStyle.mid_large_text.copyWith(
              color: AppColor.hintColor,
              fontSize: Dimensions.fontSizeDefault - 1,
            ),
          ),
        ),
      ],
    );
  }

  String _getDate(LeaveController controller) {
    if(controller.listIndex.value==0){
      return controller.dayList[0];
    }else if(controller.listIndex.value==1){
      return controller.dayList[1];
    }else if(controller.listIndex.value==2){
      return controller.dayList[2];
    }else if(controller.listIndex.value==3){
      return controller.dayList[3];
    }else if(controller.listIndex.value==4){
      return controller.dayList[4];
    }else if(controller.listIndex.value==5){
      return controller.dayList[5];
    }else if(controller.listIndex.value==6){
      return controller.dayList[6];
    }else {
      return "";
    }

  }
}






