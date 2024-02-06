import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_string.dart';
import '../../../utils/app_style.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/images.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView.builder(
      controller: _pageController,
      itemCount: demoData.length,
      onPageChanged: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      itemBuilder: (context, index) {
        return Column(
          children: [
            Expanded(child: OnboardContent(index: index,currentIndex: _currentIndex,controller: _pageController,)),



            // _buttonLayout(onAction: (){
            //
            //     //  GetStorage().write(AppString.IS_LOGGED_IN_FIRST_TIME, false);
            //     // Get.offAndToNamed(Routes.SIGN_IN_SCREEN);
            //
            //
            //   setState(() {
            //     _pageController.nextPage(
            //         duration: const Duration(milliseconds: 300),
            //         curve: Curves.ease);
            //   });
            //
            // })
          ],
        );
      },
    ));
  }
}



Widget _skipButton({context}) {
  return TextButton(
    onPressed: () async {
      await GetStorage().write(AppString.IS_LOGGED_IN_FIRST_TIME, false);
      Get.toNamed(Routes.SIGN_IN_SCREEN);
    },
    child: Text(
      AppString.text_skip,
      style: TextStyle(
          fontSize: Dimensions.fontSizeDefault,
          color: AppColor.primaryColor,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w500),
    ),
  );
}

Widget _buttonLayout({context,onAction}) {

  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      GestureDetector(
        onTap:onAction,
        child: const CircleAvatar(
          radius: 27,
          backgroundColor: AppColor.primaryColor,
          child: Icon(
            Icons.arrow_forward,
            color: AppColor.backgroundColor,
          ),
        ),
      ),
      _skipButton(context: context),
    ],
  );
}



class ActiveDot extends StatelessWidget {
  final bool isActive;
  const ActiveDot({super.key, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          radius: 9,
          backgroundColor: isActive ? Colors.orangeAccent : Colors.transparent,
          child: const CircleAvatar(
            radius: 8,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 6,
              backgroundColor: Colors.blue,
            ),
          ),
        ));
  }
}

class OnboardContent extends StatelessWidget {
  final int index;
  final int currentIndex;
  final Controller controller;
  const OnboardContent({super.key, required this.index, this.currentIndex = 0,required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: _onboardByImage(imageUrl: demoData[index]["image"]),
        ),
        Container(
          decoration: AppStyle.ContainerStyle.copyWith(
              color: AppColor.bgColorWithPrimary),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(demoData.length, (index) {
                  return ActiveDot(
                    isActive: currentIndex == index,
                  );
                }),
              ),
              _onboardTitleText(text: demoData[index]["title"]),
              customSpacerHeight(height: 12),
              _descriptionText(text: demoData[index]["description"]),
            ],
          ),
        ),


        _buttonLayout(onAction: (){

          //  GetStorage().write(AppString.IS_LOGGED_IN_FIRST_TIME, false);
          // Get.offAndToNamed(Routes.SIGN_IN_SCREEN);


          setState(() {
            _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease);
          });

        })
      ],
    );
  }
}

List<Map<String, dynamic>> demoData = [
  {
    "image": Images.employee_on,
    "title": AppString.text_mange_your_employee,
    "description": AppString.text_mange_your_employee_with,
  },
  {
    "image": Images.time_log_on,
    "title": AppString.text_track_your_time,
    "description": AppString.text_with_the_help_etc,
  },
  {
    "image": Images.leave_on,
    "title": AppString.text_manage_your_leave,
    "description": AppString.text_leave_management_etc,
  }
];

Widget _descriptionText({required text}) {
  return Text(
    text,
    style: TextStyle(
        color: AppColor.normalTextColor.withOpacity(0.5),
        fontFamily: "Poppins",
        fontSize: Dimensions.fontSizeMid - 2,
        fontWeight: FontWeight.w300),
    textAlign: TextAlign.center,
  );
}

Widget _onboardTitleText({text}) {
  return Text(
    text,
    style: TextStyle(
      fontWeight: FontWeight.w600,
      fontFamily: "Poppins",
      fontSize: Dimensions.fontSizeLarge + 2,
      color: AppColor.normalTextColor,
    ),
    textAlign: TextAlign.center,
  );
}

Widget _onboardByImage({required imageUrl}) {
  return Center(
    child: SvgPicture.asset(
      imageUrl.toString(),
      fit: BoxFit.cover,
    ),
  );
}
