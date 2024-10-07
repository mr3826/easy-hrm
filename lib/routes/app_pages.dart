import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/forgot_password.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/password_update.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/reset_password.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/sign_in.dart';
import 'package:payrun_mobile/modules/home/view/screen/main_screen.dart';
import 'package:payrun_mobile/modules/leave/presentation/view/screen/leave_screen.dart';
import 'package:payrun_mobile/modules/profile/view/screen/edit_profile.dart';
import 'package:payrun_mobile/modules/profile/view/screen/user_profile.dart';
import 'package:payrun_mobile/modules/starting/view/splash_screen.dart';
import 'package:payrun_mobile/modules/subscription/view/subscription_screen.dart';
import 'package:payrun_mobile/modules/timeline/view/screen/timer.dart';
import '../modules/dashboard/presentation/view/screen/dashboard.dart';
import '../modules/employee/presentation/view/screen/employee_profile_view_screen.dart';
import '../modules/leave/presentation/view/screen/leave_record.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:payrun_mobile/modules/timeline/view/screen/timelog_summary.dart';
import '../modules/notification/presentation/view/screen/notification.dart';
import '../modules/starting/view/onboarding_screen.dart';
import '../modules/timeline/view/screen/new_entry.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();
  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: _Paths.ONBOARD_SCRREN,
      page: () => const OnboardScreen(),
    ),
    GetPage(
      name: _Paths.TIMER_SCREEN,
      page: () => const TimerScreen(),
    ),
    GetPage(
      name: _Paths.SIGN_IN_SCREEN,
      page: () => SignInScreen(),
    ),
    GetPage(
      name: _Paths.FIRGIR_PASSWORD_SCREEN,
      transition: Transition.size,
      page: () => ForgotScreen(),
    ),
    GetPage(
      name: _Paths.OTP,
      transition: Transition.size,
      page: () => const OTPScreen(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      transition: Transition.size,
      page: () => ResetPasswordScreen(),
    ),
    GetPage(
      name: _Paths.PASSWORD_UPDATE_SCRREN,
      transition: Transition.size,
      page: () => const PasswordUpdateScreen(),
    ),
    GetPage(
      name: _Paths.SUBSCRIPTION_SCREEN,
      transition: Transition.size,
      page: () => const SubscriptionScreen(),
    ),
    GetPage(
      name: _Paths.MAIN_SCREEN,
      transition: Transition.size,
      page: () => const MainScreen(),
    ),
    GetPage(
      name: _Paths.LEAVE_SCREEN,
      transition: Transition.size,
      page: () => const LeaveScreen(),
    ),
    GetPage(
      name: _Paths.LEAVE_RECORD_SCREEN,
      transition: Transition.size,
      page: () => const LeaveRecordScreen(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION_SCREEN,
      transition: Transition.size,
      page: () => const NotificationScreen(),
    ),
    GetPage(
      name: _Paths.HOME_SCREEN,
      transition: Transition.size,
      page: () => const Dashboard(),
    ),
    GetPage(
      name: _Paths.PROFILE_SCREEN,
      transition: Transition.size,
      page: () => const ProfileScreen(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE_SCREEN,
      transition: Transition.size,
      page: () => EditProfileScreen(),
    ),
    GetPage(
      name: _Paths.TIME_LOG_SUMMARY,
      transition: Transition.size,
      page: () => const TimeLogSummary(),
    ),
    GetPage(
      name: _Paths.NEW_ENTRY_SCREEN,
      transition: Transition.size,
      page: () => const NewEntryScreen(),
    ),
    GetPage(
      name: _Paths.EMPOLYEE_VIEW_PROFILE,
      transition: Transition.size,
      page: () => const EmployeeProfileViewScreen(),
    ),
  ];
}
