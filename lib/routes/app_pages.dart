import 'package:payrun_mobile/modules/auth/presentation/view/forgot_password.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/password_update.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/sign_in.dart';
import 'package:payrun_mobile/modules/starting/view/onboarding_screen.dart';
import 'package:payrun_mobile/modules/starting/view/splash_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../modules/auth/presentation/view/otp_screen.dart';
import '../modules/auth/presentation/view/reset_password.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();
  static const INITIAL = Routes.SPLASH_SCREEN;
  static final routes = [
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: ()=>const SplashScreen(),
    ),

    GetPage(
      name: _Paths.ONBOARD_SCRREN,
      page: ()=> OnboardScreen(),
    ),
    GetPage(
      name: _Paths.SIGN_IN_SCREEN,
      page: ()=> const SignInScreen(),
    ),

    GetPage(
      name: _Paths.FIRGIR_PASSWORD_SCREEN,
      page: ()=> const ForgotScreen(),
    ),

    GetPage(
      name: _Paths.OTP,
      page: ()=> const OTPScreen(),
    ),

    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: ()=> const ResetPasswordScreen(),
    ),    GetPage(
      name: _Paths.PASSWORD_UPDATE_SCRREN,
      page: ()=> const PasswordUpdateScreen(),
    ),

  ];
}
