import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/common/widget/custom_card_style.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';

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
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: ListView.builder(
          itemCount: 3,
          scrollDirection: Axis.horizontal,
          controller: _scrollController,
          itemBuilder: (context, index) {
            final year = startingYear + index;
            return SizedBox(
              width: AppLayout.getWidth(1000),
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

                      final monthName = DateFormat('MMMM').format(month);
                      DateTime now = DateTime.now();

                      bool isCurrentMonth =
                          year == now.year && index + 1 == now.month;
                      Color textColor = isCurrentMonth
                          ? AppColor.primaryColor
                          : AppColor.hintColor;
                      return Padding(
                        padding: const EdgeInsets.only(left: 0.0, right: 25),
                        child: InkWell(
                            onTap: () {
                              print(year);
                              print(month);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  monthName,
                                  style: AppStyle.normal_text_grey.copyWith(
                                      color: textColor,
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
                            )),
                      );
                    },
                  )),
                ],
              ),
            );
          },
        ),
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
        .jumpTo(index * 76); // Set your item height or estimated height
  }
}
