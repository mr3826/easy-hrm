import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/forgot_password.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/password_update.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/sign_in.dart';
import 'package:payrun_mobile/modules/leave/presentation/view/leave_record.dart';
import 'package:payrun_mobile/modules/leave/presentation/view/leave_screen.dart';
import 'package:payrun_mobile/modules/notification/presentation/view/notification.dart';
import 'package:payrun_mobile/modules/profile/presentation/view/edit_profile.dart';
import 'package:payrun_mobile/modules/profile/presentation/view/profile.dart';
import 'package:payrun_mobile/modules/starting/view/onboarding_screen.dart';
import 'package:payrun_mobile/modules/starting/view/splash_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import '../modules/auth/presentation/view/otp_screen.dart';
import '../modules/auth/presentation/view/reset_password.dart';
import '../modules/home/presentation/main_screen.dart';
part 'app_routes.dart';


class AppPages {
  AppPages._();
  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      transition: Transition.size,
      page: ()=>const SplashScreen(),
    ),

    GetPage(
      name: _Paths.ONBOARD_SCRREN,
      transition: Transition.size,
      page: ()=> OnboardScreen(),
    ),
    GetPage(
      name: _Paths.SIGN_IN_SCREEN,

      transition: Transition.size,
      page: ()=>  SignInScreen(),
    ),

    GetPage(
      name: _Paths.FIRGIR_PASSWORD_SCREEN,
      transition: Transition.size,
      page: ()=> const ForgotScreen(),
    ),

    GetPage(
      name: _Paths.OTP,
      transition: Transition.size,
      page: ()=> const OTPScreen(),
    ),

    GetPage(
      name: _Paths.RESET_PASSWORD,

      transition: Transition.size,
      page: ()=>  ResetPasswordScreen(),


    ),

    GetPage(
      name: _Paths.PASSWORD_UPDATE_SCRREN,
      transition: Transition.size,
      page: ()=> const PasswordUpdateScreen(),
    ),

    GetPage(
      name: _Paths.MAIN_SCREEN,
      transition: Transition.size,
      page: ()=>  MainScreen(),
    ),

    GetPage(
      name: _Paths.LEAVE_SCREEN,
      transition: Transition.size,
      page: ()=> const LeaveScreen(),
    ),

    GetPage(
      name: _Paths.LEAVE_RECORD_SCREEN,
      transition: Transition.size,

      page: ()=> const LeaveRecordScreen(),
    ),

    GetPage(
      name: _Paths.LEAVE_RECORD_SCREEN,
      transition: Transition.size,
      page: ()=> const NotificationScreen(),
    ),

    GetPage(
      name: _Paths.PROFILE_SCREEN,
      transition: Transition.size,
      page: ()=> const ProfileScreen(),
    ),

    GetPage(
      name: _Paths.EDIT_PROFILE_SCREEN,
      transition: Transition.size,
      page: ()=> const EditProfileScreen(),
    ),

  ];
}
