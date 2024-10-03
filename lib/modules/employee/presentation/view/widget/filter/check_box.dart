import 'package:flutter/material.dart';

class GSMultiCheckbox extends StatefulWidget {
  final List<CheckBoxModel> itemsList;
  final Function(List<CheckBoxModel>) onSelectionChanged;
  final Color? checkBoxActiveColor;
  final TextStyle? textStyle;

  const GSMultiCheckbox({
    super.key,
    required this.itemsList,
    this.checkBoxActiveColor,
    this.textStyle,
    required this.onSelectionChanged,
  });

  @override
  State<GSMultiCheckbox> createState() => _GSMultiCheckboxState();
}

class _GSMultiCheckboxState extends State<GSMultiCheckbox> {
  @override
  Widget build(BuildContext context) {
    print("widget.itemsList.length ::: ${widget.itemsList.length}");
    print("widget.itemsList.length ::: ${widget.itemsList.first.checkBoxName}");
    return ListView.builder(
      itemCount: widget.itemsList.length,
      padding: const EdgeInsets.only(top: 12),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Row(
          children: [
            Checkbox(
              value: widget.itemsList[index].value,
              visualDensity: const VisualDensity(
                horizontal: -4,
              ),
              activeColor: widget.checkBoxActiveColor ?? Colors.blue,
              onChanged: (bool? value) {
                setState(() {
                  widget.itemsList[index].value = value ?? false;
                });

                // Call the callback function with the selected items
                List<CheckBoxModel> selectedItems =
                widget.itemsList.where((item) => item.value!).toList();
                widget.onSelectionChanged(selectedItems);
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                widget.itemsList[index].checkBoxName,
                style: widget.textStyle ?? const TextStyle(),
                // Your text style here
              ),
            ),
          ],
        );
      },
    );
  }
}

class CheckBoxModel {
  String checkBoxName;
  String checkBoxNameValue;
  bool? value;

  CheckBoxModel(
      {required this.checkBoxName,
        required this.checkBoxNameValue,
        this.value = false});


  @override
  String toString() {
    return 'CheckBoxModel{checkBoxName: $checkBoxName, checkBoxNameValue: $checkBoxNameValue, value: $value}';
  }
}
