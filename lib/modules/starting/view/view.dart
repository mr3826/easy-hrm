import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class ViewScreen extends StatelessWidget {
  const ViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),

      child: Scaffold(
        appBar: AppBar(title: const Text("View"),centerTitle: true,),
        body: Container(),
      ),
    );
  }
}
Future<bool> _onWillPop(BuildContext context) async {
  if (Platform.isAndroid) {
    SystemNavigator.pop();
  } else if (Platform.isIOS) {
    exit(0);
  }
  return false;
}
