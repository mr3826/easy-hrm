import 'dart:async';

import 'package:flutter/material.dart';
import 'package:payrun_mobile/utils/app_color.dart';

class TimerAnimation extends StatefulWidget {
  const TimerAnimation({super.key});

  @override
  State<TimerAnimation> createState() => _TimerAnimationState();
}

class _TimerAnimationState extends State<TimerAnimation> {
  double containerSize = 20.0;
  bool isContainerGrowing = true;

  @override
  void initState() {
    super.initState();
    startAnimation();
  }

  void startAnimation() {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (isContainerGrowing) {
          containerSize = 230.0;
        } else {
          containerSize = 70.0;
        }
        isContainerGrowing = !isContainerGrowing;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: AnimatedContainer(
            duration: const Duration(seconds: 1),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.primaryColor.withOpacity(0.2),
            ),
            width: containerSize,
            height: containerSize,
            curve: Curves.easeInOut,
          ),
        ),
        Positioned(
            top: 105,
            left: 105,
            child: Center(
              child: CircleAvatar(
                radius: 95,
                backgroundColor: AppColor.primaryColor.withOpacity(0.2),
                child: const CircleAvatar(
                  radius: 80,
                  backgroundColor: AppColor.primaryColor,
                ),
              ),
            )),
      ],
    );
  }
}
