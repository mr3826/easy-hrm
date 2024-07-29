import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import '../../../../common/widget/custom_card_style.dart';
import '../../../../utils/dimensions.dart';
import '../../controller/timelog_summary_controller.dart';

// class SummaryTimeLogCalendar extends StatefulWidget {
//   const SummaryTimeLogCalendar({super.key});
//
//   @override
//   State<SummaryTimeLogCalendar> createState() => _SummaryTimeLogCalendarState();
// }
//
// class _SummaryTimeLogCalendarState extends State<SummaryTimeLogCalendar> {
//   final int startingYear = DateTime.now().year - 1;
//   final int currentYear = DateTime.now().year;
//   final ScrollController _scrollController = ScrollController();
//   final int itemCount = 12; // Set your desired item count
//   late int initialIndex = 0; // Set your desired initial index
//
//   initValue() {
//     var month = DateTime.now().month;
//
//     switch (month) {
//       case 1: //Month index number as like January
//         return initialIndex = 0; //initial index
//       case 2:
//         return initialIndex = 1;
//       case 3:
//         return initialIndex = 2;
//       case 4:
//         return initialIndex = 3;
//       case 5:
//         return initialIndex = 4;
//       case 6:
//         return initialIndex = 5;
//       case 7:
//         return initialIndex = 6;
//       case 8:
//         return initialIndex = 7;
//       case 9:
//         return initialIndex = 8;
//       case 10:
//         return initialIndex = 9;
//       case 11:
//         return initialIndex = 10;
//       case 12:
//         return initialIndex = 11;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: AppLayout.getHeight(45),
//       child: ListView.builder(
//         itemCount: 3,
//         scrollDirection: Axis.horizontal,
//         controller: _scrollController,
//         itemBuilder: (context, yIndex) {
//           /// starting year 2023
//           final year = startingYear + yIndex;
//           return SizedBox(
//             width: 1450,
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                   child: Card(
//                       shape: roundedRectangleBorder.copyWith(
//                           borderRadius: BorderRadius.circular(
//                               Dimensions.radiusExtraLarge)),
//                       elevation: 0,
//                       color: AppColor.hintColor.withOpacity(0.8),
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 8, right: 8),
//                         child: Text(
//                           year.toString(),
//                           style: AppStyle.mid_large_text.copyWith(
//                               color: AppColor.cardColor,
//                               fontSize: Dimensions.fontSizeDefault + 2),
//                         ),
//                       )),
//                 ),
//                 _showMonthList(year, yIndex),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     initValue();
//     // Center the initial index during initialization
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _scrollToIndex(initialIndex + 12);
//     });
//   }
//
//   void _scrollToIndex(int index) {
//     // Scroll to the specified index with center alignment
//     _scrollController
//         .jumpTo(index * 114); // Set your item height or estimated height
//   }
//
//   _showMonthList(int year, int yearIndex) {
//     return Expanded(
//         child: ListView.builder(
//       scrollDirection: Axis.horizontal,
//       controller: _scrollController,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: itemCount,
//       itemBuilder: (context, index) {
//         /// then goes to next
//         /// list of month
//         final month = DateTime.utc(year, index + 1);
//         DateTime now = DateTime.now();
//
//         ///current month
//         bool isCurrentMonth = year == now.year && index + 1 == now.month;
//         return Padding(
//           padding: const EdgeInsets.only(left: 0.0, right: 25),
//           child: Obx(() => GestureDetector(
//               onTap: () async {
//
//                 //set index data to show selected month and year
//                 Get.find<TimelineSummaryController>()
//                     .selectedSummaryDate
//                     .value = index.toString();
//                 Get.find<TimelineSummaryController>().selectedYearIndex.value =
//                     yearIndex;
//
//                 //add selected date info
//                 Get.find<TimelineSummaryController>()
//                     .selectedMonthStartDate
//                     .value = "${DateTime(year, month.month, 1, 0, 0, 0)}";
//                 Get.find<TimelineSummaryController>()
//                         .selectedMonthEndDate
//                         .value =
//                     "${DateTime(year, month.month + 1, 0, 23, 59, 59)}";
//
//                 await Get.find<TimelineSummaryController>()
//                     .getTimelineByMonth();
//                 await Get.find<TimelineSummaryController>()
//                     .getTimelogDetailsByMonth();
//               },
//               child: SizedBox(
//                 width: 90,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       DateFormat('MMMM').format(month),
//                       style: AppStyle.normal_text_grey.copyWith(
//                           color: yearIndex ==
//                                           Get.find<TimelineSummaryController>()
//                                               .selectedYearIndex
//                                               .value &&
//                                       (index.toString() ==
//                                           Get.find<TimelineSummaryController>()
//                                               .selectedSummaryDate
//                                               .value) ||
//                                   (isCurrentMonth &&
//                                       Get.find<TimelineSummaryController>()
//                                           .selectedSummaryDate
//                                           .value
//                                           .isEmpty)
//                               ? AppColor.primaryColor
//                               : AppColor.hintColor,
//                           fontSize: isCurrentMonth
//                               ? Dimensions.fontSizeDefault + 2
//                               : Dimensions.fontSizeDefault),
//                     ),
//                     yearIndex ==
//                                     Get.find<TimelineSummaryController>()
//                                         .selectedYearIndex
//                                         .value &&
//                                 (index.toString() ==
//                                     Get.find<TimelineSummaryController>()
//                                         .selectedSummaryDate
//                                         .value) ||
//                             (isCurrentMonth &&
//                                 Get.find<TimelineSummaryController>()
//                                     .selectedSummaryDate
//                                     .value
//                                     .isEmpty)
//                         ? Text(
//                             year.toString(),
//                             style: AppStyle.mid_large_text.copyWith(
//                                 color: AppColor.hintColor,
//                                 fontSize: isCurrentMonth
//                                     ? Dimensions.fontSizeDefault - 2
//                                     : Dimensions.fontSizeDefault),
//                           )
//                         : Container(),
//                   ],
//                 ),
//               ))),
//         );
//       },
//     ));
//   }
// }

class SummaryTimeLogCalendar extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _monthKeys = {};
  final _controller = Get.find<TimelineSummaryController>();
  SummaryTimeLogCalendar({super.key}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCurrentMonth();
    });
  }

  static const List<String> _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  final Map<int, List<String>> _dateMap =
      _generateDateMap(DateTime.now().year - 1, DateTime.now().year + 1);

  void _scrollToCurrentMonth() {
    _scrollToMonth(_controller.selectedValue.value);
  }

  void _scrollToMonth(String monthKey) {
    final context = _monthKeys[monthKey]?.currentContext;
    if (context != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Scrollable.ensureVisible(
          context,
          duration: const Duration(seconds: 1),
          alignment: 0.5,
        );
      });
    }
  }

  void _handleMonthTap(int year, String month) async{
    _controller.selectedValue.value = '$year-$month';
    _scrollToMonth(_controller.selectedValue.value);

    int monthNumber = monthToNumber[month] ?? 0;
    // //add selected date info
    Get.find<TimelineSummaryController>().selectedMonthStartDate.value = "${DateTime(year, monthNumber, 1, 0, 0, 0)}";

    Get.find<TimelineSummaryController>().selectedMonthEndDate.value =
    "${DateTime(year, monthNumber + 1, 0, 23, 59, 59)}";
    await Get.find<TimelineSummaryController>()
        .getTimelineByMonth();
    await Get.find<TimelineSummaryController>()
        .getTimelogDetailsByMonth();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: _scrollController,
      child: SizedBox(
        height: 60,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _dateMap.entries.expand((entry) {
            List<Widget> widgets = [];
            widgets.add(Card(
                shape: roundedRectangleBorder.copyWith(
                    borderRadius:
                        BorderRadius.circular(Dimensions.radiusExtraLarge)),
                elevation: 0,
                color: AppColor.hintColor.withOpacity(0.8),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Text(
                    entry.key.toString(),
                    style: AppStyle.mid_large_text.copyWith(
                        color: AppColor.cardColor,
                        fontSize: Dimensions.fontSizeDefault + 2),
                  ),
                )));

            widgets.addAll(
              entry.value.map((month) {
                String monthKey = '${entry.key}-$month';
                GlobalKey monthGlobalKey = GlobalKey();
                _monthKeys[monthKey] = monthGlobalKey;
                return Padding(
                  key: monthGlobalKey,
                  padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 4),
                  child: GestureDetector(
                    onTap: () => _handleMonthTap(entry.key, month),
                    child: Column(
                      children: [
                        Obx(() => Text(
                              month,
                              style: AppStyle.normal_text_grey.copyWith(
                                  color: monthKey ==
                                          _controller.selectedValue.value
                                      ? AppColor.primaryColor
                                      : AppColor.hintColor,
                                  fontSize:monthKey ==
                                      _controller.selectedValue.value? Dimensions.fontSizeDefault+1:Dimensions.fontSizeDefault),
                            )),
                        Obx(() => monthKey == _controller.selectedValue.value
                            ? Text(
                                entry.key.toString(),
                                style: AppStyle.mid_large_text.copyWith(
                                    color: AppColor.hintColor,
                                    fontSize: Dimensions.fontSizeDefault),
                              )
                            : Container()),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
            return widgets;
          }).toList(),
        ),
      ),
    );
  }
}

Map<int, List<String>> _generateDateMap(int startYear, int endYear) {
  return {
    for (int year = startYear; year <= endYear; year++)
      year: SummaryTimeLogCalendar._months
  };
}
Map<String, int> monthToNumber = {
  'January': 1,
  'February': 2,
  'March': 3,
  'April': 4,
  'May': 5,
  'June': 6,
  'July': 7,
  'August': 8,
  'September': 9,
  'October': 10,
  'November': 11,
  'December': 12,
};