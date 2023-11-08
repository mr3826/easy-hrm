import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/images.dart';
import '../../../starting/view/onboarding_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  final _formKey = GlobalKey<FormState>();
  final ExitAppController _controller = Get.put(ExitAppController());

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    return WillPopScope(
      onWillPop: () => _controller.willPop(),
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: SafeArea(
          child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: Image.asset(Images.app_logo)),



                  ],
                ),
              )),
        ),
      ),
    );
  }



  // _logIn() {
  //   return Get.find<AuthController>().isLoading.value
  //       ? const LoadingButtonLayout() // Show loading indicator
  //       : logInButton(onAction: () {
  //           FocusScope.of(context).requestFocus(FocusNode());
  //           if (_formKey.currentState!.validate()) {
  //             Get.find<AuthController>().logIn();
  //           }
  //         });
  // }
}

emailExp() {
  const pattern =
      r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$';
  return pattern;
}

passwordExp() {
  return r"(?=.*\d)(?=.*[a-z])(?=.*\W)";
}

// RoundedRectangleBorder get _roundedRectangleBorder {
//   return RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(Dimensions.radiusSmall));
// }
//
// EdgeInsets get _padding {
//   return EdgeInsets.only(
//       left: Dimensions.paddingLarge,
//       right: Dimensions.paddingLarge,
//       bottom: Dimensions.paddingDefault + 4,
//       top: Dimensions.paddingDefaultExtra + 3);
// }
//
// EdgeInsets get _checkBoxPadding {
//   return EdgeInsets.only(
//       left: AppLayout.getWidth(13), right: AppLayout.getWidth(18), top: 0);
// }
