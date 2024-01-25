import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_style.dart';

import '../../../../common/widget/custom_card_style.dart';
import '../../../../utils/dimensions.dart';
import '../../controller/timeline_controller.dart';

import '../../controller/timelog_summary_controller.dart';

class SummaryTimeLogCalendar extends StatefulWidget {
  const SummaryTimeLogCalendar({super.key});

  @override
  State<SummaryTimeLogCalendar> createState() => _SummaryTimeLogCalendarState();
}

class _SummaryTimeLogCalendarState extends State<SummaryTimeLogCalendar> {
  final int startingYear = DateTime.now().year - 1;
  final int currentYear = DateTime.now().year;
  final ScrollController _scrollController = ScrollController();
  final int itemCount = 12; // Set your desired item count
  late int initialIndex = 0; // Set your desired initial index

  initValue() {
    var month = DateTime.now().month;

    switch (month) {
      case 1: //Month index number as like January
        return initialIndex = 0; //initial index
      case 2:
        return initialIndex = 1;
      case 3:
        return initialIndex = 2;
      case 4:
        return initialIndex = 3;
      case 5:
        return initialIndex = 4;
      case 6:
        return initialIndex = 5;
      case 7:
        return initialIndex = 6;
      case 8:
        return initialIndex = 7;
      case 9:
        return initialIndex = 8;
      case 10:
        return initialIndex = 9;
      case 11:
        return initialIndex = 10;
      case 12:
        return initialIndex = 11;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppLayout.getHeight(45),
      child: ListView.builder(
        itemCount: 3,
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        itemBuilder: (context, yIndex) {
          final year = startingYear + yIndex;
          log("year index ::: $yIndex");
          RxInt yearIndex = yIndex.obs;
          return SizedBox(
            width: 1450,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Card(
                      shape: roundedRectangleBorder.copyWith(
                          borderRadius: BorderRadius.circular(
                              Dimensions.radiusExtraLarge)),
                      elevation: 0,
                      color: AppColor.hintColor.withOpacity(0.8),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Text(
                          year.toString(),
                          style: AppStyle.mid_large_text.copyWith(
                              color: AppColor.cardColor,
                              fontSize: Dimensions.fontSizeDefault + 2),
                        ),
                      )),
                ),
                //  customSpacerWidth(width: 2),

                Expanded(
                    child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: _scrollController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: itemCount,
                  itemBuilder: (context, index) {
                    final month = DateTime.utc(year, index + 1);
                    DateTime now = DateTime.now();

                    bool isCurrentMonth =
                        year == now.year && index + 1 == now.month;
                    return Padding(
                      padding: const EdgeInsets.only(left: 0.0, right: 25),
                      child: Obx(() => GestureDetector(
                          onTap: () {
                            Get.find<TimelineSummaryController>().getTimelineByMonth(
                                startDate:
                                    "${DateTime(year, month.month, 1, 0, 0, 0)}",
                                endDate:
                                    "${DateTime(year, month.month + 1, 0, 23, 59, 59)}");
                            Get.find<TimelineSummaryController>().getTimelogDetailsByMonth(
                                startDate:
                                    "${DateTime(year, month.month, 1, 0, 0, 0)}",
                                endDate:
                                    "${DateTime(year, month.month + 1, 0, 23, 59, 59)}");

                            Get.find<TimelineController>()
                                .selectedSummaryDate
                                .value = index;
                            print(year);
                          },
                          child: SizedBox(
                            width: 90,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  DateFormat('MMMM').format(month),
                                  style: AppStyle.normal_text_grey.copyWith(
                                      color: index ==
                                              Get.find<TimelineController>()
                                                  .selectedSummaryDate
                                                  .value
                                          ? AppColor.primaryColor
                                          : AppColor.hintColor,
                                      fontSize: isCurrentMonth
                                          ? Dimensions.fontSizeDefault + 2
                                          : Dimensions.fontSizeDefault),
                                ),
                                isCurrentMonth
                                    ? Text(
                                        year.toString(),
                                        style: AppStyle.mid_large_text.copyWith(
                                            color: AppColor.hintColor,
                                            fontSize: isCurrentMonth
                                                ? Dimensions.fontSizeDefault - 2
                                                : Dimensions.fontSizeDefault),
                                      )
                                    : Container(),
                              ],
                            ),
                          ))),
                    );
                  },
                )),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    initValue();
    // Center the initial index during initialization
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToIndex(initialIndex + 12);
    });
  }

  void _scrollToIndex(int index) {
    // Scroll to the specified index with center alignment
    _scrollController
        .jumpTo(index * 114); // Set your item height or estimated height
  }

  _color({yearIndex, index, int? indexNum}) {
    Color textColor = AppColor.primaryColor;

    DateTime now = DateTime.now();

    RxString currentDate = "${now.year}".obs;
    RxString nextDate = "${now.year + 1}".obs;
    RxString preDate = "${now.year - 1}".obs;
    print("test :::: ${currentDate.value == indexNum.toString()}");
    print("indexNum :::: ${indexNum.toString()}");
    print("currentDate :::: ${currentDate.value.toString()}");

    _intValue(indexNum);
    print("indexNumber ::: ${_intValue(indexNum)}");
    textColor = yearIndex.value == _intValue(indexNum)
        ? index == Get.find<TimelineController>().selectedSummaryDate.value
            ? AppColor.primaryColor
            : AppColor.hintColor
        : AppColor.pendingColor;
    return textColor;
  }

  int _intValue(indexNum) {
    log(indexNum.toString(), error: 10);
    int indexNumber = 1;
    if (indexNum == "2024") {
      indexNumber = 1;
    }
    if (indexNum == "2023") {
      indexNumber = 0;
    }
    if (indexNum == "2025") {
      indexNumber = 2;
    }
    log(indexNum.toString(), error: 11);

    return indexNumber;
  }
}
