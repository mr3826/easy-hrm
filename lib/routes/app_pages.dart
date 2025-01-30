import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:payrun_mobile/app/global/services/network_connectivity_service.dart';
import 'package:payrun_mobile/app/modules/auth/bindings/forgot_password_binding.dart';
import 'package:payrun_mobile/app/modules/auth/bindings/otp_screen_bindings.dart';
import 'package:payrun_mobile/app/modules/auth/bindings/signin_binding.dart';
import 'package:payrun_mobile/app/modules/splash/bindings/splash_bingings.dart';
import 'package:payrun_mobile/app/modules/auth/view/screens/forgot_password.dart';
import 'package:payrun_mobile/app/modules/auth/view/screens/otp_screen.dart';
import 'package:payrun_mobile/app/modules/auth/view/screens/password_update.dart';
import 'package:payrun_mobile/app/modules/auth/view/screens/reset_password.dart';
import 'package:payrun_mobile/app/modules/auth/view/screens/sign_in.dart';
import 'package:payrun_mobile/modules/leave/presentation/view/screen/leave_screen.dart';
import 'package:payrun_mobile/app/modules/splash/view/splash_screen.dart';
import 'package:payrun_mobile/modules/subscription/view/subscription_screen.dart';
import '../app/home/view/screen/main_screen.dart';
import '../app/modules/employee/bindings/update_org_user_binding.dart';
import '../app/modules/employee/view/screen/employee_profile_view_screen.dart';
import '../app/modules/employee/view/widget/employee_list/edit_employee.dart';
import '../app/modules/hr_dashboard/view/screens/all_candidates_screen.dart';
import '../app/modules/hr_dashboard/view/screens/job_details_screen.dart';
import '../app/modules/hr_timeline/bindings/add_new_entry_bindings.dart';
import '../app/modules/hr_timeline/view/screen/new_entry_screen.dart';
import '../modules/dashboard/presentation/view/screen/dashboard.dart';
import '../modules/leave/presentation/view/screen/leave_record.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import '../modules/notification/presentation/view/screen/notification.dart';
import '../app/modules/onboard/view/onboarding_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
        name: _Paths.SPLASH_SCREEN,
        page: () => const SplashScreen(),
        binding: SplashBinding()),
    GetPage(
      name: _Paths.ONBOARD_SCRREN,
      page: () => const OnboardScreen(),
    ),
    GetPage(
        name: _Paths.SIGN_IN_SCREEN,
        page: () => SignInScreen(),
        binding: SignInBinding()),
    GetPage(
        name: _Paths.FIRGIR_PASSWORD_SCREEN,
        transition: Transition.size,
        page: () => ForgotScreen(),
        binding: ForgotPasswordBindings()),
    GetPage(
        name: _Paths.OTP,
        transition: Transition.size,
        page: () => const OTPScreen(),
        binding: OtpScreenBindings()),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      transition: Transition.size,
      page: () => ResetPasswordScreen(),
    ),
    GetPage(
      name: _Paths.ALL_CANDIDATES,
      transition: Transition.size,
      page: () => AllCandidatesScreen(),
    ),
    GetPage(
      name: _Paths.JOB_DETAILS,
      transition: Transition.size,
      page: () => JobDetailsScreen(),
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
      page: () => const NetworkListener(child: MainScreen()),
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
      name: _Paths.NEW_ENTRY_SCREEN,
      transition: Transition.size,
      binding: AddNewEntryBindings(),
      page: () => const AddTimeEntryScreen(),
    ),
    GetPage(
      name: _Paths.EMPOLYEE_VIEW_PROFILE,
      transition: Transition.size,
      page: () => const EmployeeProfileViewScreen(),
    ),
    GetPage(
        name: _Paths.EDIT_EMPOLYEE_VIEW,
        transition: Transition.size,
        page: () => EditEmployee(),
        binding: UpdateOrgUserInfoBindings()),
  ];
}
