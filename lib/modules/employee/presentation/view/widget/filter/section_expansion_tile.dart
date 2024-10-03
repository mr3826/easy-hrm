

import 'package:flutter/material.dart';
import '../../../../../../utils/app_style.dart';
import '../../../../../../utils/dimensions.dart';

class SectionExpansionTile extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const SectionExpansionTile({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ExpansionTile(
        title: Text(
          title,
          style: AppStyle.normal_text_black
              .copyWith(fontSize: Dimensions.fontSizeDefault + 2),
        ),
        children: children,
      ),
    );
  }
}
