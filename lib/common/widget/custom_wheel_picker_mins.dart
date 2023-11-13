import 'package:flutter/cupertino.dart';
import 'package:payrun_mobile/common/controller/date_time_helper_controller.dart';
import '../../utils/app_color.dart';
import '../../utils/app_style.dart';

class CustomWheelPickerMins extends StatefulWidget {
  final List list;
  final  DateTimeController controller;

  const CustomWheelPickerMins(
      {Key? key, required this.list, required this.controller})
      : super(key: key);

  @override
  State<CustomWheelPickerMins> createState() => _CustomWheelPickerMinsState();
}

class _CustomWheelPickerMinsState extends State<CustomWheelPickerMins> {
  late int currentIndex;
  late FixedExtentScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return CupertinoPicker.builder(
      itemExtent: 24,
      useMagnifier: true,
      squeeze: 1.1,
      diameterRatio: 1,
      magnification: 1.5,
      selectionOverlay: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              //<--- top side
              color: AppColor.primaryColor,
              width: 1.0,
            ),
            bottom: BorderSide(
              //  <--- top side
              color: AppColor.primaryColor,
              width: 1.0,
            ),
          ),
        ),
      ),
      scrollController: scrollController,
      childCount: widget.list.length,
      onSelectedItemChanged: (int value) => setState(() {
        currentIndex = value;
        widget.controller.selectedInputMins = value.toString();
      }),
      itemBuilder: (BuildContext context, int index) {
        return Text("${widget.list[index]}",
            style: currentIndex == index
                ? AppStyle.large_text_black.copyWith(
                    fontWeight: FontWeight.w600, color: AppColor.primaryColor)
                : AppStyle.large_text_black.copyWith(
                    fontWeight: FontWeight.w400,
                  ));
      },
    );
  }

  @override
  void initState() {
    super.initState();
    currentIndex = (widget.list.length / 2).floor();
    scrollController = FixedExtentScrollController(
        initialItem: (widget.list.length / 2).floor());
  }
}
