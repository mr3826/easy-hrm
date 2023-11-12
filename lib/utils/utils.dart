import 'package:flutter/cupertino.dart';
import '../modules/leave/presentation/view/leave_screen.dart';



List<Widget> Function()  get buildScreens=>_buildScreens;


List<Widget> _buildScreens() {
  return [
    const LeaveScreen(),
    const LeaveScreen(),
    const LeaveScreen(),
    const LeaveScreen(),
    const LeaveScreen(),

  ];
}
