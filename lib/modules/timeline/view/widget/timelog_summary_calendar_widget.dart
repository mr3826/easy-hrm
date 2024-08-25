import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import '../../../../common/widget/custom_card_style.dart';
import '../../../../utils/dimensions.dart';
import '../../controller/timelog_summary_controller.dart';


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