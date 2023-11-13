import 'package:flutter/material.dart';
import 'package:payrun_mobile/common/widget/error_message.dart';



class ApplyLeaveScreen extends StatelessWidget {
  const ApplyLeaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(onPressed: (){
          showErrorMessage(message: "Warning message done !!");

        }, child: const Text("Click"))
      ],
    );
  }
}
