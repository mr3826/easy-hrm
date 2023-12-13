import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_appbar.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/new_entry_text_field_widget.dart';
import 'package:payrun_mobile/utils/app_string.dart';


class NewEntryScreen extends StatelessWidget {
  const NewEntryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title: AppString.text_new_entry.tr),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NewEntryTextField()
          ],
        ),
      ),
    );
  }
}
